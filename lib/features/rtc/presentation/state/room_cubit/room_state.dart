// lib/features/rtc/presentation/bloc/room_state.dart
part of 'room_cubit.dart';

abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomReady extends RoomState {
  final Room room;
  RoomReady(this.room);
  @override
  List<Object?> get props => [room];
}

class RoomError extends RoomState {
  final String message;
  RoomError(this.message);
  @override
  List<Object?> get props => [message];
}
