import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationRemoteDatasource {
  final FirebaseMessaging _fm = FirebaseMessaging.instance;

  Future<void> requestPermission() => _fm.requestPermission();

  Future<String?> token() => _fm.getToken();

  Stream<RemoteMessage> foreground() => FirebaseMessaging.onMessage;

  Stream<RemoteMessage> opened() => FirebaseMessaging.onMessageOpenedApp;

  Future<void> subscribe(String topic) => _fm.subscribeToTopic(topic);
  Future<void> unsubscribe(String topic) => _fm.unsubscribeFromTopic(topic);
}
