import 'dart:async';

import 'package:dating_app/features/push_notification/data/data_source/push_notification_remote_data_source.dart';
import 'package:dating_app/features/push_notification/domain/entities/push_message.dart';
import 'package:dating_app/features/push_notification/domain/repository/push_notification_repository.dart';
import 'package:dating_app/flavors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationRepositoryImpl implements PushNotificationRepository {
  PushNotificationRepositoryImpl(this._ds) {
    _ds.foreground().listen(_map);
    _ds.opened().listen(_map);
  }
  final PushNotificationRemoteDatasource _ds;
  final _controller = StreamController<PushMessage>.broadcast();

  void _map(RemoteMessage m) => _controller.add(PushMessage(
        title: m.notification?.title,
        body: m.notification?.body,
        data: m.data,
      ));

  @override
  Stream<PushMessage> messages() => _controller.stream;

  @override
  Future<String?> fetchToken() => _ds.token();

  @override
  Future<void> initialise() async {
    await _ds.requestPermission();
    FirebaseMessaging.onBackgroundMessage(
      _bgHandler,
    );
  }

  @override
  Future<void> subscribe(String topic) => _ds.subscribe(topic);
  @override
  Future<void> unsubscribe(String topic) => _ds.unsubscribe(topic);
}

@pragma('vm:entry-point')
Future<void> _bgHandler(RemoteMessage m) async {
  await Firebase.initializeApp(
    options: F.firebaseOptions,
    name: 'primary',
  );
}
