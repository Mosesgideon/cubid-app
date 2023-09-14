import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/app_utils/app_utils.dart';
import 'package:video_player/video_player.dart';

class Videos extends StatefulWidget {
  const Videos({
    Key? key,
  }) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Videos and Reels",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('videos').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.4,
                              // height: 400,
                              decoration: const BoxDecoration(
                                // border: Border.all(color: Colors.black),
                              ),

                              child: Stack(children: [
                                VideoPlayerWidget(
                                  videoFile: snapshot.data!.docs[index]
                                      .get('url'),
                                ),
                                Positioned(
                                  top: 370,
                                  right: -2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        const Column(
                                          children: [
                                            Icon(
                                              Iconsax.like_1,
                                              size: 25,
                                              color: Colors.black,
                                            ),
                                            Text('20')
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const Column(
                                          children: [
                                            Icon(
                                              size: 25,
                                              Iconsax.message,
                                              color: Colors.black,
                                            ),
                                            Text('20')
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.share,
                                              color: Colors.black,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  top: 450,
                                  left: 2,
                                  child: Row(
                                    children: [
                                      CircleAvatar(),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Posters Name',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text('Posters Username')
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          ));
                }),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).cardColor,
                      child: IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Iconsax.arrow_left,
                            color: Colors.black,
                          )),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).cardColor,
                          child: IconButton(
                              onPressed: () {
                                _pickVideos();
                              },
                              icon: const Icon(
                                Iconsax.video,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).cardColor,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.camera,
                                color: Colors.black,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickVideos() async {
    final files = await AppUtils.pickVideo();

    if (files != null && files.isNotEmpty) {
      for (var file in files!) {
        log(file.name);
        uploadToFirebase(file.path!);
      }
    }
  }

  Future<FutureOr> uploadToFirebase(String videoFile) async {
    try {
      final Reference storageRef =
          _storage.ref().child('videos/${DateTime.now()}.mp4');
      final UploadTask uploadTask = storageRef.putFile(File(videoFile));

      final TaskSnapshot storageSnapshot = await uploadTask;
      final String downloadURL = await storageSnapshot.ref.getDownloadURL();

      // Save the download URL in Firestore
      await _firestore.collection('videos').add({'url': downloadURL});

      log('uploaded');
      print('Video uploaded and URL saved: $downloadURL');
    } catch (error) {
      print('Error uploading video: $error');
      log('failed');
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoFile;

  VideoPlayerWidget({required this.videoFile});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoFile))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width,

            child: VideoPlayer(_controller)),
        Center(
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).cardColor,
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
