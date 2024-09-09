import 'package:flutter/services.dart';

class CustomNotification {
  static const platform =
      MethodChannel('com.example.adkar/custom_notification');

  Future<void> startCustomNotificationService() async {
    try {
      await platform.invokeMethod('startCustomNotificationService');
    } on PlatformException catch (e) {
      print("Failed to start custom notification service: '${e.message}'.");
    }
  }
}
