import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class VideoComment extends StatefulWidget {
  final String vidoeID;
  const VideoComment({super.key, required this.vidoeID});

  @override
  State<VideoComment> createState() => _VideoCommentState();
}

class _VideoCommentState extends State<VideoComment> {
  final fire = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('video_comments')
                    .where('vidoeID', isEqualTo: widget.vidoeID)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Image.asset('assets/png/error.png'),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                              backgroundImage: NetworkImage(snapshot.data!.docs[index]
                                  .get('userImage')),
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
                                    snapshot.data!.docs[index]
                                        .get('posterName'),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          snapshot.data!.docs[index]
                                              .get('comment'),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              fontSize: 10)),
                                      // Text(snapshot.data!.docs[index].get('comment'),
                                      //     style: TextStyle(
                                      //         color: Theme.of(context)
                                      //             .colorScheme
                                      //             .onBackground,
                                      //         fontSize: 10))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
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
                        if (_controller.text.isNotEmpty) {
                          sendComments(widget.vidoeID, _controller.text,
                              auth.currentUser!.uid,auth.currentUser!.uid);
                          _controller.clear();
                        }
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

  void sendComment() async {
    //send message
    if (_controller.text.isNotEmpty) {
      await sendComments(
          widget.vidoeID, _controller.text, auth.currentUser!.uid,auth.currentUser!.uid);
      _controller.clear();
    }
  }

  Future sendComments(String vidoeID, String comment, String user,String posterId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference comments =
    FirebaseFirestore.instance.collection("video_comments");
    DocumentSnapshot<Map<String, dynamic>> users =
    await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return comments.add({
      "posterId":posterId,
      'comment': comment,
      "vidoeID": vidoeID,
      "posterName": users.data()?['name'],
      "userImage": users.data()?['image'],
      "time": DateTime.now().millisecondsSinceEpoch,
    }).whenComplete(() {
      print("comment sent");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 2000), content: Text("commented")));
    });
  }
}
