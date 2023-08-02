import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/features/chat_page/presentation/model/message.dart';

class ChatServices extends ChangeNotifier {
  //instance of firebase

  final firebaseauth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage( String recieverid,String message,) async {


    //get user info
    final String currentUserId = firebaseauth.currentUser!.uid;
    final String currentUseremail = firebaseauth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    final DateTime dateTime = DateTime.now();

    //get message
    Message newmessage  = Message(
        senderID: currentUserId,
        senderEmail: currentUseremail,
        recieverID: recieverid,
        message: message,
        time: dateTime.toIso8601String().toString());

    //construct a room id for current user and reciever
    List<String> idcollection = [currentUserId, recieverid];
    idcollection.sort();
    //combine the two to a single string
    String chatroomId = idcollection.join("_");

    log(chatroomId);


    //add new message to database
    await firestore
        .collection("chatroom")
        .doc(chatroomId)
        .collection("messages").add(newmessage.toMap());

  }

//get message
  Stream<QuerySnapshot> getMessages(String senderId, String recieverId)  {
    List<String> roomId = [senderId, recieverId];
    roomId.sort();
    String chatroomId = roomId.join("_");

    log(chatroomId);

    return firestore
        .collection("chatroom")
        .doc(chatroomId)
        .collection("messages")
        .orderBy('time', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getNotifications(String senderId, String recieverId)  {
    List<String> roomId = [senderId, recieverId];
    roomId.sort();
    String notificationId = roomId.join("_");

    log(notificationId);

    return firestore
        .collection("notifications")
        .doc(notificationId)
        .collection("messages")
        .orderBy('time', descending: false)
        .snapshots();
  }
  Future<void> sendNotifications( String recieverid,String message,) async {


    //get user info
    final String currentUserId = firebaseauth.currentUser!.uid;
    final String currentUseremail = firebaseauth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    final DateTime dateTime = DateTime.now();

    //get message
    Message newmessage  = Message(
        senderID: currentUserId,
        senderEmail: currentUseremail,
        recieverID: recieverid,
        message: message,
        time: dateTime.toIso8601String().toString());

    //construct a room id for current user and reciever
    List<String> idcollection = [currentUserId, recieverid];
    idcollection.sort();
    //combine the two to a single string
    String notificationId = idcollection.join("_");

    log(notificationId);


    //add new message to database
    await firestore
        .collection("notifications")
        .doc(notificationId)
        .collection("messages").add(newmessage.toMap());

  }
}



