import 'package:dating_app/features/rtc/domain/entites/room.dart';
import 'package:dating_app/services/web_rtc_service.dart';


abstract class SignalingRepository {
  Future<Room> createRoom({required String username});
  Future<Room> joinRoom({required String username, required String roomId});
  Future<void> leaveRoom({required String roomId, required String username});
  WebRTCService get rtc;
}
