import 'package:dating_app/features/rtc/domain/repositories/signaling_repository.dart';

class ToggleCamera {
  ToggleCamera(this.repo);
  final SignalingRepository repo;
  bool call() => repo.rtc.toggleCamera();
}
