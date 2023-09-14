import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/menu_tab/presentations/screens/userprofile_view.dart';

class UserPosts extends StatefulWidget {
  final String name;
  final String text;
  final Widget? image_text;
  Widget? widget;
  VoidCallback voidCallback;
  VoidCallback onpressed;

  UserPosts(
      {Key? key,
      required this.name,
      this.widget,
      required this.image_text,
      required this.voidCallback,
      required this.onpressed,
      required this.text})
      : super(key: key);

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  bool liked = false;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreamenttCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  void initState() {
    liked = liked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 10),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: Center(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: widget.voidCallback,

                      //   Navigator.of(context).push(CupertinoPageRoute(
                      //       builder: (index) => const UserProfileView()));

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2),
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey,
                            ),
                            child: widget.widget,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "2hrs ago",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.more_vert_outlined,
                      color: Theme.of(context).colorScheme.onBackground,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // image:  DecorationImage(
                //
                //     // image: AssetImage("assets/jpg/person3.jpeg"),
                //     fit: BoxFit.cover),
              ),
              child: widget.image_text,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.text,
                // ,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.message,
                        color: Theme.of(context).colorScheme.onBackground,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        "3k",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          liked ? _decreamenttCounter() : _incrementCounter();
                          setState(() {
                            liked = !liked;
                          });
                        },
                        child: liked
                            ? const Icon(
                                Icons.favorite_outlined,
                                size: 20,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                                size: 20,
                                color: Colors.red,
                              ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "$_counter",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}
// firestore
//     .collection("chatroom")
// .doc(chatroomId)
// .collection("messages").add(newmessage.toMap());

class _PostsState extends State<Posts> {
  final Stream<QuerySnapshot> _users = FirebaseFirestore.instance
      .collection("userposts")
      .snapshots();

  // bool hasImage = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _users,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => UserPosts(
                    widget: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                snapshot.data!.docs[index].get("image"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                    name: snapshot.data!.docs[index].get("username"),
                    voidCallback: () {
                      // Navigator.of(context).push(CupertinoPageRoute(
                      //     builder: (context) => UserProfileView(
                      //           snapshot: snapshot.data!.docs[index],
                      //         )));
                    },
                    onpressed: () {},
                    text: snapshot.data!.docs[index].get('comment'),
                    // name: '',
                    image_text: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: NetworkImage(
                              snapshot.data!.docs[index].get("itemposted"),
                            ),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ));
        });
  }
}
