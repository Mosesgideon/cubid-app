import 'package:firebase_messaging/firebase_messaging.dart';



//
// Future<void>handleBackgroungMessage(RemoteMessage message)async {
//
//   print('Title:${message.notification?.title}');
//   print('Body:${message.notification?.body}');
//   print('Payload:${message.data}');
// }
// void handleMessage(RemoteMessage? message){
//   if(message==null) {
//
//   }
// }
//
//
//
// class firebaseApi{
//   final firebaseMessaging=FirebaseMessaging.instance;
//
//   Future<void> notifications()async{
//     await firebaseMessaging.requestPermission();
//     final FCToken=firebaseMessaging.getToken();
//     print('Token:$FCToken');
//
//     FirebaseMessaging.onBackgroundMessage( handleBackgroungMessage);
//
//
//   }
// }