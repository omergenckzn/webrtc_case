// lib/features/rtc/presentation/bloc/room_state.dart
part of 'room_cubit.dart';

abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomReady extends RoomState {
  RoomReady(this.room);
  final Room room;
  @override
  List<Object?> get props => [room];
}

class RoomError extends RoomState {
  RoomError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
