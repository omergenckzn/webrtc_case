// lib/services/web_rtc_service.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

///Review notu: _log methodlarını developmenta çalışma mantığını kavramak için kaldırmadım. prod versiyonunda kaldırılacak.

typedef IceCallback = void Function(RTCIceCandidate candidate);

class WebRTCService {
  WebRTCService();

  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  RTCPeerConnection? _pc;
  MediaStream? _localStream;

  bool _micOn = true;
  bool _camOn = true;
  bool _initialized = false;


  ///This will be moved into Constants.
  final Map<String, dynamic> _pcConfig = <String, dynamic>{
    'sdpSemantics': 'unified-plan',
    'bundlePolicy': 'balanced',
    'rtcpMuxPolicy': 'require',
    'iceServers': <Map<String, dynamic>>[
      {
        'urls': <String>[
          'stun:stun.l.google.com:19302',
          'stun:stun.l.google.com:5349',
          'stun:stun1.l.google.com:3478',
          'stun:stun1.l.google.com:5349',
          'stun:stun2.l.google.com:19302',
          'stun:stun2.l.google.com:5349',
          'stun:stun3.l.google.com:3478',
          'stun:stun3.l.google.com:5349',
          'stun:stun4.l.google.com:19302',
          'stun:stun4.l.google.com:5349',
        ],
      },
    ],
  };

  final Map<String, dynamic> _pcConstraints = <String, dynamic>{
    'mandatory': <String, dynamic>{},
    'optional': <Map<String, dynamic>>[
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  void _log(String msg) => debugPrint('[RTC] $msg');

  Future<void> initRenderers() async {
    if (_initialized) {
      _log('initRenderers: already initialized, skip.');
      return;
    }
    _log('initRenderers: initializing renderers...');
    await localRenderer.initialize();
    await remoteRenderer.initialize();

    _log('initRenderers: capturing local media...');
    _localStream = await navigator.mediaDevices.getUserMedia(<String, dynamic>{
      'audio': true,
      'video': <String, dynamic>{
        'facingMode': 'user',
      },
    });
    localRenderer.srcObject = _localStream;

    _log('initRenderers: creating RTCPeerConnection...');
    _pc = await createPeerConnection(_pcConfig, _pcConstraints);

    // Events
    _pc!.onSignalingState =
        (RTCSignalingState s) => _log('onSignalingState -> $s');
    _pc!.onIceGatheringState =
        (RTCIceGatheringState s) => _log('onIceGatheringState -> $s');
    _pc!.onIceConnectionState =
        (RTCIceConnectionState s) => _log('onIceConnectionState -> $s');
    _pc!.onRenegotiationNeeded = () => _log('onRenegotiationNeeded');

    _pc!.onTrack = (RTCTrackEvent e) {
      final kind = e.track.kind;
      _log('onTrack: kind=$kind, streams=${e.streams.length}');
      if (e.streams.isNotEmpty) {
        remoteRenderer.srcObject = e.streams.first;
        _log(
          'onTrack: remote stream attached -> id=${e.streams.first.id} '
          '(v:${e.streams.first.getVideoTracks().length} a:${e.streams.first.getAudioTracks().length})',
        );
      }
      if (kind == 'video') {
        _log('remote video settings -> ${e.track.getSettings()}');
      }
    };

    _pc!.onAddStream = (MediaStream s) {
      _log(
          'onAddStream (legacy): id=${s.id} (v:${s.getVideoTracks().length} a:${s.getAudioTracks().length})');
      if (remoteRenderer.srcObject == null) {
        remoteRenderer.srcObject = s;
      }
    };

    int a = 0, v = 0;
    for (final track in _localStream!.getTracks()) {
      await _pc!.addTrack(track, _localStream!);
      if (track.kind == 'audio') a++;
      if (track.kind == 'video') v++;
    }
    _log('initRenderers: added local tracks (a:$a v:$v)');

    _initialized = true;
    _log('initRenderers: done.');
  }

  Future<void> prepareIce(IceCallback cb) async {
    if (_pc == null) throw StateError('prepareIce: pc is null');
    _pc!.onIceCandidate = (RTCIceCandidate c) {
      _log(
          'onIceCandidate (local) -> type=${c.candidate?.contains("typ relay") == true ? "relay" : (c.candidate?.contains("typ srflx") == true ? "srflx" : "host")} proto=${c.candidate?.contains(" tcp ") == true ? "tcp" : "udp"}');
      cb(c);
    };
  }

  Future<void> setIceCallback(IceCallback cb) => prepareIce(cb);

  Future<RTCSessionDescription> createOffer() async {
    if (_pc == null) throw StateError('createOffer: pc is null');
    _log('createOffer: generating...');
    final RTCSessionDescription offer =
        await _pc!.createOffer(<String, dynamic>{
      'offerToReceiveAudio': 1,
      'offerToReceiveVideo': 1,
    });
    await _pc!.setLocalDescription(offer);
    _log('createOffer: localDescription set (type=${offer.type ?? 'offer'})');
    return offer;
  }

  Future<RTCSessionDescription> createAnswer(
    String offerSdp,
    String offerType,
  ) async {
    if (_pc == null) throw StateError('createAnswer: pc is null');
    _log('createAnswer: setRemoteDescription(offer)...');
    await _pc!.setRemoteDescription(RTCSessionDescription(offerSdp, offerType));

    _log('createAnswer: generating...');
    final RTCSessionDescription answer =
        await _pc!.createAnswer(<String, dynamic>{
      'offerToReceiveAudio': 1,
      'offerToReceiveVideo': 1,
    });
    await _pc!.setLocalDescription(answer);
    _log(
        'createAnswer: localDescription set (type=${answer.type ?? 'answer'})');
    return answer;
  }

  Future<void> setRemoteAnswer(String sdp, String type) async {
    if (_pc == null) throw StateError('setRemoteAnswer: pc is null');
    _log('setRemoteAnswer: applying remote answer...');
    await _pc!.setRemoteDescription(RTCSessionDescription(sdp, type));
    _log('setRemoteAnswer: done.');
  }

  Future<void> addIceCandidate(Map<String, dynamic> m) async {
    final c = RTCIceCandidate(
      (m['candidate'] as String?) ?? '',
      m['sdpMid'] as String?,
      (m['sdpMLineIndex'] as num?)?.toInt(),
    );
    if (c.candidate != null && c.candidate!.isNotEmpty) {
      _log('addIceCandidate (remote) <- ${c.candidate}');
      await _pc?.addCandidate(c);
    }
  }

  bool toggleMic() {
    _micOn = !_micOn;
    _localStream?.getAudioTracks().forEach((t) => t.enabled = _micOn);
    _log('toggleMic -> $_micOn');
    return _micOn;
  }

  bool get micOn => _micOn;

  bool toggleCamera() {
    _camOn = !_camOn;
    _localStream?.getVideoTracks().forEach((t) => t.enabled = _camOn);
    _log('toggleCamera -> $_camOn');
    return _camOn;
  }

  bool get camOn => _camOn;

  Future<void> dumpSelectedCandidatePair() async {
    final reports = await _pc?.getStats() ?? const <StatsReport>[];
    for (final r in reports) {
      if (r.type == 'candidate-pair') {
        final v = r.values;
        final selected = v['selected'] == true ||
            v['state'] == 'succeeded' ||
            v['googActiveConnection'] == true;
        if (selected) {
          _log('STATS selected pair -> $v');
        }
      }
    }
  }

  Future<void> dispose() async {
    _log('dispose: closing...');
    try {
      await _pc?.close();
    } catch (_) {}
    _pc = null;

    try {
      await localRenderer.dispose();
    } catch (_) {}
    try {
      await remoteRenderer.dispose();
    } catch (_) {}

    try {
      await _localStream?.dispose();
    } catch (_) {}
    _localStream = null;

    _initialized = false;
    _log('dispose: done.');
  }
}
