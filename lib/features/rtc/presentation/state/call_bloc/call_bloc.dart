// lib/features/rtc/presentation/bloc/call_bloc.dart
import 'package:dating_app/features/rtc/domain/use_case/leave_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/toggle_camera.dart';
import 'package:dating_app/features/rtc/domain/use_case/toggle_mic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc({
    required this.toggleMic,
    required this.toggleCamera,
    required this.leaveRoom,
  }) : super(const CallState.initial()) {
    on<CallMicToggled>(_onMicToggled);
    on<CallCamToggled>(_onCamToggled);
    on<CallEnded>(_onEnded);
  }

  final ToggleMic toggleMic;
  final ToggleCamera toggleCamera;
  final LeaveRoom leaveRoom;

  Future<void> _onMicToggled(
    CallMicToggled event,
    Emitter<CallState> emit,
  ) async {
    final on = toggleMic();
    emit(state.copyWith(micOn: on));
  }

  Future<void> _onCamToggled(
    CallCamToggled event,
    Emitter<CallState> emit,
  ) async {
    final on = toggleCamera();
    emit(state.copyWith(camOn: on));
  }

  Future<void> _onEnded(CallEnded event, Emitter<CallState> emit) async {
    await leaveRoom(event.roomId, event.username);
    emit(const CallState.initial());
  }
}
