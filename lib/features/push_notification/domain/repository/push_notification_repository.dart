import 'package:dating_app/features/push_notification/domain/entities/push_message.dart';

abstract interface class PushNotificationRepository {
  Future<String?> fetchToken();
  Stream<PushMessage> messages();      
  Future<void> initialise();
  Future<void> subscribe(String topic);
  Future<void> unsubscribe(String topic);
}
