import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SignalingDataSource {
  Future<String> createRoomDoc(String username, String sdp, String type);
  Future<Map<String, dynamic>?> getRoom(String roomId);
  Stream<DocumentSnapshot<Map<String, dynamic>>> roomStream(String roomId);
  Stream<QuerySnapshot<Map<String, dynamic>>> remoteCandidatesStream(
    String roomId, {
    required bool forCallee,
  });
  Future<void> addIceCandidate(
    String roomId,
    Map<String, dynamic> cand, {
    required bool forCaller,
  });
  Future<Map<String, dynamic>> joinRoomTx({
    required String roomId,
    required String username,
    required String answerSdp,
    required String answerType,
  });
  Future<void> removeParticipant(String roomId, String username);
}

class FirestoreSignalingDataSource implements SignalingDataSource {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _rooms =>
      _db.collection('rooms');

  @override
  Future<String> createRoomDoc(String username, String sdp, String type) async {
    final doc = _rooms.doc();
    await doc.set(<String, dynamic>{
      'createdAt': FieldValue.serverTimestamp(),
      'state': 'open',
      'capacity': 2,
      'offer': <String, dynamic>{'sdp': sdp, 'type': type},
      'participants': <String>[username], // sadece caller
    });
    return doc.id;
  }

  @override
  Future<Map<String, dynamic>?> getRoom(String roomId) async {
    final snap = await _rooms.doc(roomId).get();
    return snap.data();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> roomStream(String roomId) =>
      _rooms.doc(roomId).snapshots();

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> remoteCandidatesStream(
    String roomId, {
    required bool forCallee,
  }) {
    final sub = forCallee ? 'calleeCandidates' : 'callerCandidates';
    return _rooms.doc(roomId).collection(sub).orderBy('ts').snapshots();
  }

  @override
  Future<void> addIceCandidate(
    String roomId,
    Map<String, dynamic> cand, {
    required bool forCaller,
  }) async {
    final sub = forCaller ? 'callerCandidates' : 'calleeCandidates';
    await _rooms.doc(roomId).collection(sub).add({
      ...cand,
      'ts': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<Map<String, dynamic>> joinRoomTx({
    required String roomId,
    required String username,
    required String answerSdp,
    required String answerType,
  }) async {
    return _db.runTransaction((tx) async {
      final ref = _rooms.doc(roomId);
      final snap = await tx.get(ref);
      if (!snap.exists) {
        throw StateError('Room not found');
      }
      final data = (snap.data() ?? <String, dynamic>{});
      final current = (data['participants'] as List<dynamic>? ?? <dynamic>[]);
      if (current.length >= 2 && !current.contains(username)) {
        throw StateError('Room is full');
      }

      final next =
          <String>{...current.map((e) => e.toString()), username}.toList();

      if (next.length > 2) {
        throw StateError('Room is full');
      }

      tx.update(ref, <String, dynamic>{
        'participants': next,
        'answer': <String, dynamic>{'sdp': answerSdp, 'type': answerType},
        'state': 'active',
      });

      return <String, dynamic>{
        ...data,
        'participants': next,
      };
    });
  }

  @override
  Future<void> removeParticipant(String roomId, String username) async {
    final ref = _rooms.doc(roomId);
    await _db.runTransaction((tx) async {
      final snap = await tx.get(ref);
      if (!snap.exists) return;
      final data = snap.data()!;
      final cur = (data['participants'] as List<dynamic>? ?? <dynamic>[]);
      final next =
          cur.where((e) => e != username).map((e) => e.toString()).toList();

      if (next.isEmpty) {
        final caller = await ref.collection('callerCandidates').get();
        final callee = await ref.collection('calleeCandidates').get();
        final batch = _db.batch();
        for (final d in caller.docs) {
          batch.delete(d.reference);
        }
        for (final d in callee.docs) {
          batch.delete(d.reference);
        }
        batch.delete(ref);
        await batch.commit();
      } else {
        tx.update(ref, <String, dynamic>{
          'participants': next,
          'state': 'open',
          'answer': FieldValue.delete(), // bir sonraki katılımcı için sıfırla
        });
      }
    });
  }
}
