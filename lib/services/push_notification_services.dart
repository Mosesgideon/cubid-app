import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', 'testing_channel',
      description: 'testing_description',
      importance: Importance.high,
      playSound: true,
      showBadge: true);

  static Future inititialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    var token = await getDeviceToken();

    log(token.toString());

    print('User granted permission: ${settings.authorizationStatus}');

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var allowed = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    log(allowed.toString());

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(message.notification!.title.toString());

      flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification?.title,
          message.notification?.body,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  playSound: true,
                  importance: Importance.high,
                  icon: 'launch_background')));

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        storeNotification(message!.notification!.title.toString(), message.notification!.body!);
      }
    });
  }

  static Future<String?> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    return await messaging.getToken();
  }

 static Future<void> storeNotification(String tittle, String body) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('notifications');

    final docRef = collectionReference.doc();

    try {
      return docRef.set({"id": docRef.id, "tittle": tittle, "body": body});
    } on Exception catch (e) {
      log(e.toString());

      return Future(() => false);
    }
  }
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   // Initialize notification settings for Android and iOS
//   const AndroidInitializationSettings androidInitializationSettings =
//   AndroidInitializationSettings('app_icon');
//   final IOSInitializationSettings iosInitializationSettings =
//   IOSInitializationSettings(
//     requestSoundPermission: false,
//     requestBadgePermission: false,
//     requestAlertPermission: false,
//   );
//   final InitializationSettings initializationSettings =
//   InitializationSettings(
//     android: androidInitializationSettings,
//     iOS: iosInitializationSettings,
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );
//
//   runApp(MyApp());
// }

// Future<void> showChatNotification(
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
//     String title,
//     String body) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails(
//     'chat_notification_channel',
//     'Chat Notifications',
//     'Notifications for incoming chat messages',
//     importance: Importance.max,
//     priority: Priority.high,
//     enableVibration: true,
//     playSound: true,
//     sound: RawResourceAndroidNotificationSound('notification_sound'),
//   );
//
//   const IOSNotificationDetails iosPlatformChannelSpecifics =
//   IOSNotificationDetails(presentSound: false);
//
//   const NotificationDetails platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//     iOS: iosPlatformChannelSpecifics,
//   );
//
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     platformChannelSpecifics,
//   );
// }

