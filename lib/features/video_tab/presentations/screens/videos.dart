import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/app_constants/theme/app_colors.dart';
import 'package:social_media/app_utils/app_utils.dart';
import 'package:social_media/features/video_tab/presentations/widgets/videocomment.dart';
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
  String fireAuth = FirebaseAuth.instance.currentUser!.uid;
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Videos and Reels",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
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
                builder: (context, postSnapshots) {
                  if (postSnapshots.hasError) {
                    return Center(
                      child: Image.asset('assets/png/error.png'),
                    );
                  } else if (postSnapshots.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (postSnapshots.data!.docs.isEmpty) {
                    return Center(
                      child: Image.asset('assets/png/nodata.png'),
                    );
                  }

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: postSnapshots.data!.docs.length,
                      itemBuilder: (BuildContext context, int postIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.4,
                            // height: 400,
                            decoration: const BoxDecoration(
                                // border: Border.all(color: Colors.black),
                                ),

                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.4,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(children: [
                                VideoPlayerWidget(
                                  videoFile: postSnapshots.data!.docs[postIndex]
                                      .get('url'),
                                ),
                                Positioned(
                                  top: 370,
                                  right: -2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        StreamBuilder(
                                            stream: userLikedPost(postSnapshots
                                                .data!.docs[postIndex].id),
                                            builder: (context, snapshot) {
                                              int likes = 0;
                                              if (snapshot.hasData) {
                                                likes =
                                                    snapshot.data!.docs.length;
                                                log(snapshot.data!.docs.length
                                                    .toString());
                                              }
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (likes == 0) {
                                                        likeUserPost(
                                                            postSnapshots
                                                                .data!
                                                                .docs[postIndex]
                                                                .id);
                                                        log('liked');
                                                      } else {
                                                        unLikeUserPost(
                                                            postSnapshots
                                                                .data!
                                                                .docs[postIndex]
                                                                .id);
                                                        log('unliked');
                                                      }

                                                      log('message');
                                                    },
                                                    child: likes == 0
                                                        ? const Icon(
                                                            Iconsax.like_1,
                                                            color: Colors.black,
                                                          )
                                                        : const Icon(
                                                            Iconsax.like_15,
                                                            color: Colors.red,
                                                          ),
                                                  ),
                                                  Text(snapshot
                                                          .data?.docs.length
                                                          .toString() ??
                                                      '0')
                                                ],
                                              );
                                            }),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () => AppUtils
                                                  .showCustomModalBottomSheet(
                                                      context, VideoComment(vidoeID: postSnapshots.data!.docs[postIndex].id,)),
                                              child: const Icon(
                                                size: 25,
                                                Iconsax.message,
                                                color: Colors.black,
                                              ),
                                            ),
                                            StreamBuilder(
                                              stream:  FirebaseFirestore.instance
                                                  .collection('video_comments')
                                                  .where('vidoeID', isEqualTo: postSnapshots.data!.docs[postIndex].id,)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                return Text(postSnapshots.data?.docs.length.toString() ?? '0');
                                              }
                                            )
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
                                Positioned(
                                  top: 450,
                                  left: 2,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.withOpacity(0.1),
                                            image:  DecorationImage(
                                                image: NetworkImage(postSnapshots.data!.docs[postIndex].get('userImage')))),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            postSnapshots.data!.docs[postIndex].get('posterName'),
                                            style:const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'Posters Username',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          ),
                        );
                      });
                }),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: darkGrey,
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
                          backgroundColor: darkGrey,
                          child: IconButton(
                              onPressed: () {
                                makeVideoFromCamera();
                                // ImagePicker().pickVideo(
                                //     source: ImageSource.camera);
                              },
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

  Stream<QuerySnapshot<Map<String, dynamic>>> postLikes(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('Videolikes')
        .where('postId', isEqualTo: postId)
        .snapshots();

    return document;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userLikedPost(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('Videolikes')
        .where('postId', isEqualTo: postId)
        .where('Videoliker', isEqualTo: currentUser?.uid)
        .snapshots();

    return document;
  }

  void likeUserPost(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Videolikes').doc().set({
      'postId': postId,
      'Videoliker': currentUser!.uid,
    });
  }

  void unLikeUserPost(String postId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = await FirebaseFirestore.instance
        .collection('Videolikes')
        .where('postId', isEqualTo: postId)
        .where('Videoliker', isEqualTo: currentUser!.uid)
        .get();

    if (document.docs.isNotEmpty) {
      for (var element in document.docs) {
        element.reference.delete();
      }
    }
  }

  Future<void> _pickVideos() async {
    final files = await AppUtils.pickVideo();
    if (files != null && files.isNotEmpty) {
      for (var file in files!) {
        log(file.name);
        uploadToFirebase(
          file.path!,
        );
      }
    }
  }

  Future<FutureOr> uploadToFirebase(String videoFile) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final user =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (user.exists) {
        final Reference storageRef =
            _storage.ref().child('videos/${DateTime.now()}.mp4');
        final UploadTask uploadTask = storageRef.putFile(File(videoFile));

        final TaskSnapshot storageSnapshot = await uploadTask;
        final String downloadURL = await storageSnapshot.ref.getDownloadURL();

        final docRefrence = _firestore.collection('videos');

        // Save the download URL in Firestore
        await docRefrence.add({
          "posterName": user.data()?["name"],
          "userImage": user.data()?["image"],
          "posterID": uid,
          'videorID': docRefrence.path,
          'url': downloadURL
        });

        print('Video uploaded and URL saved: $downloadURL');
      }

      log('uploaded');
    } catch (error) {
      print('Error uploading video: $error');
      log('failed');
    }
  }

  Future<void> makeVideoFromCamera() async {
    final file = ImagePicker().pickVideo(source: ImageSource.camera);
    // if (file != null && file.isNotEmpty) {
    //   for (var file in file!) {
    //     log(file.name);
    //     uploadToFirebase(file.path!);
    //   }
    // }
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
        VideoPlayer(_controller),
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
