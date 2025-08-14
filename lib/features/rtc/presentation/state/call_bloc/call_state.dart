// lib/features/rtc/presentation/bloc/call_state.dart
part of 'call_bloc.dart';

class CallState extends Equatable {
  const CallState.initial() : this(micOn: true, camOn: true);

  const CallState({required this.micOn, required this.camOn});
  final bool micOn;
  final bool camOn;

  CallState copyWith({bool? micOn, bool? camOn}) =>
      CallState(micOn: micOn ?? this.micOn, camOn: camOn ?? this.camOn);

  @override
  List<Object?> get props => [micOn, camOn];
}
