import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/features/rtc/data/data_source/signaling_data_source.dart';
import 'package:dating_app/features/rtc/domain/entites/room.dart';
import 'package:dating_app/features/rtc/domain/repositories/signaling_repository.dart';
import 'package:dating_app/services/web_rtc_service.dart';
import 'package:flutter/foundation.dart';

class SignalingRepositoryImpl implements SignalingRepository {
  SignalingRepositoryImpl(this._ds, this._rtc);

  final SignalingDataSource _ds;
  final WebRTCService _rtc;

  final Map<String, StreamSubscription> _roomSubs = {};
  final Map<String, StreamSubscription> _candSubs = {};
  final Set<String> _answerAppliedRooms = {};

  void _log(String msg) => debugPrint('[SIG] $msg');

  @override
  WebRTCService get rtc => _rtc;

  @override
  Future<Room> createRoom({required String username}) async {
    String? roomId;
    try {
      await _rtc.initRenderers();

      await _rtc.prepareIce((c) {
        if (roomId == null) return;
        final map = <String, dynamic>{
          'candidate': c.candidate ?? '',
          'sdpMid': c.sdpMid ?? '',
          'sdpMLineIndex': c.sdpMLineIndex ?? 0,
        };
        _log('-> caller ICE ${map['candidate']}');
        _ds.addIceCandidate(roomId!, map, forCaller: true);
      });

      final offer = await _rtc.createOffer();

      final id = await _ds.createRoomDoc(
        username,
        offer.sdp ?? '',
        offer.type ?? 'offer',
      );
      roomId = id;
      _log('room created: $roomId');

      // Listen to callee candidates
      _candSubs['$id-callee'] =
          _ds.remoteCandidatesStream(id, forCallee: true).listen(
        (QuerySnapshot<Map<String, dynamic>> snap) {
          for (final ch in snap.docChanges) {
            if (ch.type == DocumentChangeType.added) {
              final data = ch.doc.data() ?? <String, dynamic>{};
              _log('<- callee ICE ${data['candidate']}');
              _rtc.addIceCandidate(data);
            }
          }
        },
      );

      _roomSubs[id] = _ds.roomStream(id).listen((s) async {
        final data = s.data();
        if (data == null) return;

        final parts = (data['participants'] as List<dynamic>? ?? <dynamic>[]);
        if (parts.length > 2) return;

        final ans = data['answer'] as Map<String, dynamic>?;
        if (ans == null) return;
        if (_answerAppliedRooms.contains(id)) return;

        final sdp = ans['sdp'] as String? ?? '';
        final type = ans['type'] as String? ?? 'answer';
        if (sdp.isEmpty) return;

        _answerAppliedRooms.add(id);
        _log('apply remote answer (room=$id)');
        await _rtc.setRemoteAnswer(sdp, type);
      });

      return Room(id: id, participants: [username]);
    } catch (e) {
      _log('createRoom error: $e');
      if (roomId != null) {
        await _roomSubs.remove(roomId)?.cancel();
        await _candSubs.remove('$roomId-callee')?.cancel();
        _answerAppliedRooms.remove(roomId);
      }
      await _rtc.dispose();
      rethrow;
    }
  }

  @override
  Future<Room> joinRoom({
    required String username,
    required String roomId,
  }) async {
    try {
      final Map<String, dynamic>? room = await _ds.getRoom(roomId);
      if (room == null) throw Exception('Room not found');

      final current =
          (room['participants'] as List<dynamic>? ?? <dynamic>[]);
      if (current.length >= 2 && !current.contains(username)) {
        throw Exception('Room is full');
      }

      await _rtc.initRenderers();

      await _rtc.prepareIce((c) {
        final map = <String, dynamic>{
          'candidate': c.candidate ?? '',
          'sdpMid': c.sdpMid ?? '',
          'sdpMLineIndex': c.sdpMLineIndex ?? 0,
        };
        _log('-> callee ICE ${map['candidate']}');
        _ds.addIceCandidate(roomId, map, forCaller: false);
      });

      final offerMap = (room['offer'] as Map<String, dynamic>);
      final offerSdp = offerMap['sdp'] as String;
      final offerType = offerMap['type'] as String;

      final answer = await _rtc.createAnswer(offerSdp, offerType);

      final updated = await _ds.joinRoomTx(
        roomId: roomId,
        username: username,
        answerSdp: answer.sdp ?? '',
        answerType: answer.type ?? 'answer',
      );
      _log('joined room: $roomId as $username');

      _candSubs['$roomId-caller'] = _ds
          .remoteCandidatesStream(roomId, forCallee: false)
          .listen((QuerySnapshot<Map<String, dynamic>> snap) {
        for (final ch in snap.docChanges) {
          if (ch.type == DocumentChangeType.added) {
            final data = ch.doc.data() ?? <String, dynamic>{};
            _log('<- caller ICE ${data['candidate']}');
            _rtc.addIceCandidate(data);
          }
        }
      });

      final  participants = List<String>.from(
        (updated['participants'] as List<dynamic>? ?? <dynamic>[]),
      );
      return Room(id: roomId, participants: participants);
    } catch (e) {
      _log('joinRoom error: $e');
      await _candSubs.remove('$roomId-caller')?.cancel();
      await _rtc.dispose();
      rethrow;
    }
  }

  @override
  Future<void> leaveRoom({
    required String roomId,
    required String username,
  }) async {
    _log('leaveRoom: $roomId by $username');
    await _ds.removeParticipant(roomId, username);
    await _roomSubs.remove(roomId)?.cancel();
    await _candSubs.remove('$roomId-caller')?.cancel();
    await _candSubs.remove('$roomId-callee')?.cancel();
    _answerAppliedRooms.remove(roomId);
    await _rtc.dispose();
  }
}
