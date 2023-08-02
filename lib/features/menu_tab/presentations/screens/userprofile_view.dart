import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key, required this.snapshot}) : super(key: key);
  final QueryDocumentSnapshot snapshot;

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  bool isfollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    // super.initState();
    isfollowing = isfollowing;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        title: Text(
          "Profile View",
          style: TextStyle(
              color: Theme
                  .of(context)
                  .colorScheme
                  .onBackground, fontSize: 18),
        ),
      ),
      body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.snapshot.get('image')),
                  fit: BoxFit.cover)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white60.withOpacity(0.2),
                            Colors.white10.withOpacity(0.1),
                          ])),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                widget.snapshot.get('name'),
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                              Text(
                                  widget.snapshot.get('name'),
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey),
                              child: const Column(
                                children: [
                                  Text(
                                    "2.2k",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Followers",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey),
                              child: const Column(
                                children: [
                                  Text(
                                    "2.2k",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Likes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey),
                              child: const Column(
                                children: [
                                  Text(
                                    "2.2k",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Following",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            shrinkWrap: true,
                            // itemCount: widget.snapshot.,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) =>
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image:  DecorationImage(
                                            image: AssetImage(
                                                widget.snapshot.get('itemposted')),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                  ),
                                ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: isFollowing(widget.snapshot.get('id')),
                            builder: (context, snapshot) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                        bgColor: snapshot.data!.docs.isNotEmpty
                                            ? Colors.white
                                            : null,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        isExpanded: false,
                                        child: Text(
                                          snapshot.data!.docs.isNotEmpty
                                              ? "Unfollow"
                                              : "Follow",
                                          style: TextStyle(
                                            color:
                                            snapshot.data!.docs.isNotEmpty
                                                ? Colors.black
                                                : null,
                                          ),
                                        ),
                                        onPressed: () {
                                          followUser(widget.snapshot.get('id'));

                                          snapshot.data!.docs.isNotEmpty
                                              ?
                                          unfollowUser(
                                              widget.snapshot.get('id'))
                                              : followUser(
                                              widget.snapshot.get('id'));
                                          // isfollowing = !isfollowing;

                                        }),
                                    CustomButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        isExpanded: false,
                                        child: const Text("Message"),
                                        onPressed: () {
                                          // Navigator.of(context).push(
                                          //     CupertinoPageRoute(
                                          //         builder: (index) =>
                                          //             UserChats(name: snapshot.data.docs[index].get('name'), email: '',)));
                                        })
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> isFollowing(String userId) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = FirebaseFirestore.instance
        .collection('followers')
        .where('following', isEqualTo: userId)
        .where('follower', isEqualTo: currentUser!.uid)
        .snapshots();

    return document;
  }

  void followUser(String userId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('followers').doc().set({
      'following': userId,
      'follower': currentUser!.uid,
    });
  }

  void unfollowUser(String userId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = await FirebaseFirestore.instance
        .collection('followers')
        .where('following', isEqualTo: userId)
        .where('follower', isEqualTo: currentUser!.uid)
        .get();

    if (document.docs.isNotEmpty) {
      for (var element in document.docs) {
        element.reference.delete();
      }
    }
  }



}
