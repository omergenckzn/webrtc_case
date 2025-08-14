// lib/core/services/share/share_service_impl.dart
import 'dart:ui';
import 'package:share_plus/share_plus.dart';

class ShareService {
  @override
  Future<void> shareText({
    required String text,
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        text: text,
        title: subject,
      ),
    );
  }
}
