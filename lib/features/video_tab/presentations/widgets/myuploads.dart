import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyUpload extends StatefulWidget {
  const MyUpload({super.key});

  @override
  State<MyUpload> createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }

  File? videoFile;

  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> uploadVideo(videoFile) async {
    try {
      final Reference storageRef =
          _storage.ref().child('videos/${DateTime.now()}.mp4');
      final UploadTask uploadTask = storageRef.putFile(videoFile);

      final TaskSnapshot storageSnapshot = await uploadTask;
      final String downloadURL = await storageSnapshot.ref.getDownloadURL();

      // Save the download URL in Firestore
      await _firestore.collection('videos').add({'url': downloadURL});

      log('uploaded');
      print('Video uploaded and URL saved: $downloadURL');
    } catch (error) {
      print('Error uploading video: $error');
    }
  }

  Future<void> pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );
      if (result != null && result.files.isNotEmpty) {
        videoFile = File(result.files.first.path!);
      } else {}
    } catch (e) {
      print('Error picking video: $e');
    }
  }
}
