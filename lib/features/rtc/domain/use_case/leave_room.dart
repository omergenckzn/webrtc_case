import 'package:dating_app/features/rtc/domain/repositories/signaling_repository.dart';

class LeaveRoom {
  LeaveRoom(this.repo);
  final SignalingRepository repo;
  Future<void> call(String roomId, String username) =>
      repo.leaveRoom(roomId: roomId, username: username);
}
