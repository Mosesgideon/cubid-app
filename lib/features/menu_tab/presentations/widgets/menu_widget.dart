import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:social_media/features/menu_tab/presentations/widgets/post_view.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:social_media/features/menu_tab/presentations/widgets/bottom_items.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool isfollowing = false;
  bool isLoading = false;

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

  List<String> location = [
    'Follow',
  ];

  final FirebaseFirestore store = FirebaseFirestore.instance;
  late final String posts;
  final _listController = ScrollController();

  void scrollListenerController() {
    setState(() {});
  }

  @override
  void initState() {
    // super.initState();
    _listController.addListener(scrollListenerController);
    isfollowing = isfollowing;
  }

  @override
  void dispose() {
   _listController.removeListener(scrollListenerController);
    super.dispose();
  }
  // late  int timestamp;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: store.collection("posts").snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Image.asset("assets/png/error.png");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer(
              child: Container(
            height: 100,
          ));
        } else if (snapshot.data == null) {
          return Image.asset(height: 100, width: 100, "assets/png/nodata.png");
        } else {
          return ListView.builder(

            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.04)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: InkWell(
                            onTap: () =>
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => PostView(
                                          userImage: snapshot.data?.docs[index]
                                              .get('images'),
                                          username: snapshot.data?.docs[index]
                                              .get('posterName'),
                                        ))),
                            child: Hero(
                              tag: "images",
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot
                                            .data?.docs[index]
                                            .get('images')))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(CupertinoPageRoute(
                                                    builder: (ctx) => ViewImage(
                                                          image: snapshot
                                                              .data?.docs[index]
                                                              .get('userImage'),
                                                          name: snapshot
                                                              .data?.docs[index]
                                                              .get(
                                                                  'posterName'),
                                                        )));
                                          },
                                          child: Hero(
                                            tag: 'userImage',
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Theme.of(context).cardColor,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data?.docs[index]
                                                      .get('userImage')),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              child: Text(
                                                snapshot.data?.docs[index]
                                                    .get('posterName'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                              ),
                                            ),
                                            Text(
                                              timeAgo.format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                  snapshot.data?.docs[index]
                                                      .get('time'),
                                                ),
                                              ),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Positioned(
                                bottom: 0,
                                child: MenuBottomItem(
                                    // snapshot:
                                    // FirebaseFirestore.instance
                                    //     .collection('users')
                                    //
                                    //     .where('user', isEqualTo: FirebaseAuth.instance.currentUser.uid))
                                    ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

// class PopUp extends StatefulWidget {
//   VoidCallback voidCallback;
//
//   PopUp({Key? key, required this.voidCallback}) : super(key: key);
//
//   @override
//   State<PopUp> createState() => _PopUpState();
// }
// class _PopUpState extends State<PopUp> {
//   List<String> menuItems = ['Item 1', 'Item 2', 'Item 3'];
//
//   void addItem() {
//     setState(() {
//       menuItems.add('New Item');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       icon: Icon(
//         Icons.more_vert_outlined,
//         color: Theme.of(context).colorScheme.onBackground,
//       ),
//       elevation: 0,
//       color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       itemBuilder: (BuildContext context) {
//         return [
//           PopupMenuItem(
//             onTap: widget.voidCallback,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Following',
//                     style: TextStyle(
//                         color: Theme.of(context).colorScheme.onBackground),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ];
//       },
//       onSelected: (value) {},
//     );
//   }
// }

class ViewImage extends StatefulWidget {
  final String image;
  final String name;

  const ViewImage({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Iconsax.arrow_left,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        title: Text(
          widget.name,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          child: Hero(
              tag: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                ),
              )),
        ),
      ),
    );
  }
}
