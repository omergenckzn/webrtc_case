// lib/features/rtc/presentation/pages/call_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:dating_app/core/global_widgets/custom_app_bar.dart';
import 'package:dating_app/core/theme/dating_app_color.dart';
import 'package:dating_app/features/auth/presentation/state/username_cubit.dart';
import 'package:dating_app/features/rtc/presentation/state/call_bloc/call_bloc.dart';
import 'package:dating_app/locator.dart' as di;
import 'package:dating_app/services/share_service.dart';
import 'package:dating_app/services/web_rtc_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

@RoutePage()
class CallView extends StatefulWidget {
  const CallView({required this.roomId, super.key});
  final String roomId;

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  final WebRTCService _rtc = di.getIt<WebRTCService>();
  late final CallBloc _callBloc;

  @override
  void initState() {
    super.initState();
    _callBloc = di.getIt<CallBloc>();
    _initializeWebRTC();
  }

  Future<void> _initializeWebRTC() async {
    await _rtc.initRenderers();
    _rtc.remoteRenderer.onFirstFrameRendered = () {
      setState(() {});
    };
    _rtc.remoteRenderer.onResize = () {
      setState(() {});
    };
    setState(() {}); // ensure UI builds with initial renderers
  }

  Future<bool> _endAndPop(BuildContext context) async {
    final username = context.read<UsernameCubit>().state!;
    _callBloc.add(CallEnded(widget.roomId, username));
    context.router.maybePop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final username = context.read<UsernameCubit>().state!;
    return Scaffold(
      appBar: CustomAppBar(
        title: '${widget.roomId}',
        action: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.ios_share), // or Icons.share
              tooltip: 'Share',
              color: context.datingAppColor.antiFlashWhite,
              onPressed: () async {
                final share = di.getIt<ShareService>();
                final text = 'Join my room: ${widget.roomId}\n'
                    'Open Gpace App and enter the Room ID to join.';
                await share.shareText(
                  text: text,
                  subject: 'Room Invitation: ${widget.roomId}',
                );
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<CallBloc, CallState>(
        bloc: _callBloc,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black54,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            RTCVideoView(
                              _rtc.remoteRenderer,
                              objectFit: RTCVideoViewObjectFit
                                  .RTCVideoViewObjectFitCover,
                            ),
                            Positioned(
                              left: 8,
                              bottom: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  (_rtc.remoteRenderer.srcObject
                                              ?.getVideoTracks()
                                              .isNotEmpty ??
                                          false)
                                      ? 'remote: video ✓'
                                      : 'remote: waiting…',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black26,
                        ),
                        child: RTCVideoView(
                          _rtc.localRenderer,
                          mirror: true,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () => _callBloc.add(const CallMicToggled()),
                      icon: Icon(state.micOn ? Icons.mic : Icons.mic_off),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filledTonal(
                      onPressed: () => _callBloc.add(const CallCamToggled()),
                      icon: Icon(
                        state.camOn ? Icons.videocam : Icons.videocam_off,
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filled(
                      style: IconButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        final username = context.read<UsernameCubit>().state!;
                        _callBloc.add(CallEnded(widget.roomId, username));
                        context.router.maybePop();
                      },
                      icon: const Icon(Icons.call_end),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
