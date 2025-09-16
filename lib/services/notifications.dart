import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications {
  static final firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initializeNotifications() async {
    await firebaseMessaging.requestPermission();
    String? token = await firebaseMessaging.getToken();
    log('FCM Token: $token');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log(
      'onBackgroundMessage: ${message.notification!.title}',
    );
  }
}
