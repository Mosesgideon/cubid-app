import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/app_utils/app_utils.dart';
import 'package:social_media/features/menu_tab/presentations/widgets/comment_widget.dart';


class MenuBottomItem extends StatefulWidget {
  const MenuBottomItem({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final String postId;

  @override
  State<MenuBottomItem> createState() => _MenuBottomItemState();
}

class _MenuBottomItemState extends State<MenuBottomItem> {
  bool islike = false;
  bool isLoading = false;

  // bool herat = false;

  @override
  void initState() {
    // super.initState();
    islike = islike;
    isfollowing = isfollowing;
  }

  bool isfollowing = false;

  // bool isLoading = false;


  final FirebaseFirestore store = FirebaseFirestore.instance;
  late final String posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 45,
      width: MediaQuery.of(context).size.width * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder(
                  stream: userLikedPost(widget.postId),
                  builder: (BuildContext context, snapshot) {
                    int likes = 0;

                    if (snapshot.hasData) {
                      likes = snapshot.data!.docs.length;
                      log(snapshot.data!.docs.length.toString());
                    }

                    return Row(
                      children: [
                        InkWell(
                          onTap: (){
                            if (likes == 0) {
                              likeUserPost(widget.postId);
                              log('liked');
                            } else {
                              unLikeUserPost(widget.postId);
                              log('unliked');
                            }

                            log('message');
                          },
                          child:  likes == 0?Icon(Icons.thumb_up_off_alt,
                          size: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground):const Icon(Icons.thumb_up,
                              size: 20,
                              color: Colors.blue),
                        ),
                        const SizedBox(width: 5.0),
                        StreamBuilder(
                            stream: postLikes(widget.postId),
                            builder: (context, snapshot) {
                              return Text(
                                  snapshot.data?.docs.length.toString() ?? '0');
                            })
                      ],
                    );
                  },
                ),
                StreamBuilder(
                  stream: heartIconLikes(widget.postId),
                  builder: (BuildContext context, snapshot) {
                    int hearts = 0;
                    if (snapshot.hasData) {
                      hearts = snapshot.data!.docs.length;
                    }
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (hearts == 0) {
                              heartUserPost(widget.postId);
                              log('heart');
                            } else {
                              unheartUserPost(widget.postId);
                              log('unheart');
                            }

                            log('message');
                          },
                          child: hearts == 0
                              ? Icon(Iconsax.heart,
                                  size: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground)
                              : const Icon(Iconsax.heart_add,
                                  size: 20, color: Colors.red),
                        ),
                        const SizedBox(width: 5.0),
                        StreamBuilder(
                            stream: heartIconLikes(widget.postId),
                            builder: (context, snapshot) {
                              return Text(
                                  snapshot.data?.docs.length.toString() ?? '0');
                            })
                      ],
                    );
                  },
                ),
                InkWell(
                  onTap: () {
                    AppUtils.showCustomModalBottomSheet(context,  Comments(postId: widget.postId,));
                  },
                  child: Icon(Iconsax.message,
                      size: 20,
                      color:
                      Theme.of(context).colorScheme.onBackground),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> postLikes(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .snapshots();

    return document;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userLikedPost(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .where('liker', isEqualTo: currentUser?.uid)
        .snapshots();

    return document;
  }

  void likeUserPost(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('likes').doc().set({
      'postId': postId,
      'liker': currentUser!.uid,
    });
  }

  void unLikeUserPost(String postId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = await FirebaseFirestore.instance
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .where('liker', isEqualTo: currentUser!.uid)
        .get();

    if (document.docs.isNotEmpty) {
      for (var element in document.docs) {
        element.reference.delete();
      }
    }
  }

  Future<void> shareFile() async {
    // List<dynamic> docs = await DocumentsPicker.pickDocuments;
    // if (docs == null || docs.isEmpty) return null;
    //
    // await FlutterShare.shareFile(
    //   title: 'Example share',
    //   text: 'Example share text',
    //   filePath: docs[0] as String,
    // );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> heartIconLikes(String postID) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = FirebaseFirestore.instance
        .collection('lovers')
        .where('postID', isEqualTo: postID)
        .where('lover', isEqualTo: currentUser!.uid)
        .snapshots();

    return document;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userheartIconLike(String postID) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = FirebaseFirestore.instance
        .collection('lovers')
        .where('postID', isEqualTo: postID)
        .where('lover', isEqualTo: currentUser!.uid)
        .snapshots();

    return document;
  }

  void heartUserPost(String postID) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('lovers').doc().set({
      'postID': postID,
      'lover': currentUser!.uid,
    });
  }

  void unheartUserPost(String postID) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = await FirebaseFirestore.instance
        .collection('lovers')
        .where('postID', isEqualTo: postID)
        .where('lover', isEqualTo: currentUser!.uid)
        .get();

    if (document.docs.isNotEmpty) {
      for (var element in document.docs) {
        element.reference.delete();
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userPostComment(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .where('commenter', isEqualTo: currentUser?.uid)
        .snapshots();
    return document;
  }

  void commentPost(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('comments').doc().set({
      'postId': postId,
      'commenter': currentUser!.uid,
    });
  }

}
