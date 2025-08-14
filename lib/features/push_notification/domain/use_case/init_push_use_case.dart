// lib/domain/usecases/init_push_usecase.dart

import 'package:dating_app/features/push_notification/domain/repository/push_notification_repository.dart';

class InitPushUseCase {
  InitPushUseCase(this.repo);
  final PushNotificationRepository repo;
  Future<void> call() => repo.initialise();
}
