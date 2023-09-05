import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MenuBottomItem extends StatefulWidget {
  const MenuBottomItem({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuBottomItem> createState() => _MenuBottomItemState();
}

class _MenuBottomItemState extends State<MenuBottomItem> {
  bool islike = false;
  bool isLoading = false;

  @override
  void initState() {
    // super.initState();
    islike = islike;
    isfollowing = isfollowing;
  }

  bool isfollowing = false;

  // bool isLoading = false;

  Stream<QuerySnapshot<Map<String, dynamic>>> heartIcon(String userId) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = FirebaseFirestore.instance
        .collection('lovers')
        .where('loving', isEqualTo: userId)
        .where('lover', isEqualTo: currentUser!.uid)
        .snapshots();

    return document;
  }

  void followUser(String userId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('lovers').doc().set({
      'loving': userId,
      'lover': currentUser!.uid,
    });
  }

  void unfollowUser(String userId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = await FirebaseFirestore.instance
        .collection('lovers')
        .where('loving', isEqualTo: userId)
        .where('lover', isEqualTo: currentUser!.uid)
        .get();

    if (document.docs.isNotEmpty) {
      for (var element in document.docs) {
        element.reference.delete();
      }
    }
  }

  List<String> location = [
    'Follow',
  ];

  final FirebaseFirestore store = FirebaseFirestore.instance;
  late final String posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 45,
      width: MediaQuery
          .of(context)
          .size
          .width * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.white.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    StreamBuilder(
                      stream: null,
                      // stream:  likePost(widget.snapshot.get('id')),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) =>
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  log('liked');
                                },
                                child: const Icon(
                                  Iconsax.like_1,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text('30')
                            ],
                          ),

                    ),
                  ],
                ),
                StreamBuilder(
                  stream: null,
                    // stream: heartIcon(widget.snapshot.get('id')),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) =>
                        IconButton(
                            onPressed: () {
                              log('favourite');
                            },
                            icon: const Icon(Iconsax.lovely, size: 20)),

                ),
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.message_2,size: 20,)),
                IconButton(
                    onPressed: () {
                      sharePost();
                    }, icon: const Icon(Icons.share, size: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> likePost(String userId) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = FirebaseFirestore.instance
        .collection('likes')
        .where('liking', isEqualTo: userId)
        .where('liker', isEqualTo: currentUser!.uid)
        .snapshots();

    return document;
  }

  void likeUserPost(String userId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('likes').doc().set({
      'liking': userId,
      'liker': currentUser!.uid,
    });
  }

  void unLikeUserPost(String userId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = await FirebaseFirestore.instance
        .collection('likes')
        .where('liking', isEqualTo: userId)
        .where('liker', isEqualTo: currentUser!.uid)
        .get();

    if (document.docs.isNotEmpty) {
      for (var element in document.docs) {
        element.reference.delete();
      }
    }
  }

  void sharePost() {}
}
