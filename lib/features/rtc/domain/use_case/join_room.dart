import 'package:dating_app/features/rtc/domain/entites/room.dart';

import 'package:dating_app/features/rtc/domain/repositories/signaling_repository.dart';

class JoinRoom {
  JoinRoom(this.repo);
  final SignalingRepository repo;
  Future<Room> call(String username, String roomId) =>
      repo.joinRoom(username: username, roomId: roomId);
}
