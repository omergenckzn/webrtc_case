import 'package:dating_app/features/rtc/domain/entites/room.dart';

import 'package:dating_app/features/rtc/domain/repositories/signaling_repository.dart';

class CreateRoom {
  CreateRoom(this.repo);
  final SignalingRepository repo;
  Future<Room> call(String username) => repo.createRoom(username: username);
}
