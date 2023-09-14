import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final fire = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Moses Gideon",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                            Text("ahswear bro,it has been terrible 😂",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Moses Gideon",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                            Text("ahswear bro,it has been terrible 😂",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom,
                  left: 10,
                  right: 10),
              child: TextFormField(
                controller: _controller,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        SendMessage();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    border: OutlineInputBorder(
                        gapPadding: 2,
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey.withOpacity(0.2),
                    hintText: 'comment',
                    iconColor: Colors.grey,
                    prefixIconColor: Colors.grey,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 13)),
              )),
        ],
      ),
    );
  }

  void SendMessage() async {
    //send message
    if (_controller.text.isNotEmpty) {
      // await service.sendMessage(widget.currentUserId, _controller.text);
      //clear message
      _controller.clear();
    }
  }

  Future<DocumentReference<Object?>> comments(
      String comment, String id, String image) async {
    CollectionReference comment =
        FirebaseFirestore.instance.collection('comments');
    return await comment.add({
      'comment': comment,
      'id': id,
      'image': image,
    });
  }

// Stream<QuerySnapshot<Map<String, dynamic>>> userLikedPost(String postId) {
//   User? currentUser = FirebaseAuth.instance.currentUser;
//   final document = FirebaseFirestore.instance
//       .collection('comments')
//       .where('postId', isEqualTo: postId)
//       .where('commenter', isEqualTo: currentUser?.uid).snapshots();
//
//   return document.;
// }
}
