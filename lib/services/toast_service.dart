import 'dart:async';
import 'package:flutter/material.dart';

enum ToastType { success, error }

class ToastService {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static BuildContext? _currentContext;

  static void showToast({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.error,
    int duration = 20,
  }) {
    removeToast();

    _currentContext = context;

    _overlayEntry = _createOverlayEntry(context, message, type);
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);

    _timer = Timer(Duration(seconds: duration), removeToast);
  }

  static OverlayEntry _createOverlayEntry(
    BuildContext context,
    String message,
    ToastType type,
  ) {
    final color = type == ToastType.success ? Colors.green : Colors.red;

    return OverlayEntry(
      builder: (context) => Positioned(
        top: 64,
        left: 20,
        right: 20,
        child: GestureDetector(
          onTap: removeToast,
          behavior: HitTestBehavior.opaque,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> removeToast() async {
    _timer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
    _currentContext = null;
  }
}
