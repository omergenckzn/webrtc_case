// lib/domain/usecases/get_token_usecase.dart

import 'package:dating_app/features/push_notification/domain/repository/push_notification_repository.dart';

class GetFcmTokenUseCase {
  GetFcmTokenUseCase(this.repo);
  final PushNotificationRepository repo;
  Future<String?> call() => repo.fetchToken();
}
