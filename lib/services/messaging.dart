import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Messaging {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> initNotification() async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    log(token.toString());
    FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);
  }

  static Future<void> handleBackGroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}
