import 'package:dating_app/features/rtc/domain/entites/room.dart';
import 'package:dating_app/features/rtc/domain/use_case/create_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/join_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/leave_room.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit({
    required this.createRoom,
    required this.joinRoom,
    required this.leaveRoom,
  }) : super(RoomInitial());

  final CreateRoom createRoom;
  final JoinRoom joinRoom;
  final LeaveRoom leaveRoom;

  Future<void> create(String username) async {
    emit(RoomLoading());
    try {
      final room = await createRoom(username);
      emit(RoomReady(room));
    } catch (e) {
      emit(RoomError(e.toString()));
    }
  }

  Future<void> join(String username, String roomId) async {
    emit(RoomLoading());
    try {
      final room = await joinRoom(username, roomId);
      emit(RoomReady(room));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('Room is full')) {
        emit(RoomError('Room is full (only 1:1 allowed)'));
      } else {
        emit(RoomError(msg));
      }
    }
  }

  Future<void> leave(String roomId, String username) async {
    await leaveRoom(roomId, username);
    emit(RoomInitial());
  }
}
