
// lib/features/rtc/presentation/bloc/call_event.dart
part of 'call_bloc.dart';

sealed class CallEvent extends Equatable {
  const CallEvent();
  @override
  List<Object?> get props => [];
}

final class CallMicToggled extends CallEvent {
  const CallMicToggled();
}

final class CallCamToggled extends CallEvent {
  const CallCamToggled();
}

final class CallEnded extends CallEvent {
  const CallEnded(this.roomId, this.username);
  final String roomId;
  final String username;

  @override
  List<Object?> get props => [roomId, username];
}
