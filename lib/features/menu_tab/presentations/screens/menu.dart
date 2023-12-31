import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:social_media/features/chat_page/presentation/screens/chat_list/chat_page.dart';
import 'package:social_media/features/chat_page/presentation/screens/widgets/styles.dart';
import 'package:social_media/features/menu_tab/presentations/screens/privat_userpost.dart';
import 'package:social_media/features/menu_tab/presentations/widgets/menu_widget.dart';
import 'package:social_media/features/notifications/presentations/screens/notifications.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  bool hasImage = false;
  bool isOpen = false;
  bool isonline = false;
  final Stream<QuerySnapshot> _users = FirebaseFirestore.instance
      .collection("users")
      .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  final _listController = ScrollController();

  void scrollListenerController() {
    setState(() {});
  }

  @override
  void initState() {

    _listController.addListener(scrollListenerController);
    super.initState();
  }

  @override
  void dispose() {
    _listController.removeListener(scrollListenerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Cubid',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 18),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [

          IconButton(
            splashRadius: 20,
            icon: const Icon(Iconsax.search_normal_1, size: 20),
            onPressed: () {},
          ),
          StreamBuilder<QuerySnapshot<dynamic>>(
            stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
            builder: ( context, snapshot) =>Stack(clipBehavior: Clip.none,
                children: [
                  IconButton(
                    splashRadius: 20,
                    icon: const Icon(Iconsax.notification, size: 20),
                    onPressed: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (index) =>const NotificationsScreen()));
                    },
                  ),
                   Positioned(
                      bottom: 35,
                      left: 25,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.red,
                        child: Center(child: Text(snapshot.data?.size.toString()??"0",style: const TextStyle(color: Colors.white,fontSize: 6),)),
                      )),
                ]),
          ),
        ],
      ),
      body: NestedScrollView(
          controller: _listController,
          floatHeaderSlivers: true,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // double opacity=0;
            // if(opacity>1.0) opacity=1;
            // if(opacity<0.0) opacity=0;
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const UserPost(),
                        StreamBuilder<QuerySnapshot>(
                            stream: _users,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(child: Text("oops error"));
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: Center(
                                    child: Shimmer(child: Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width,
                                    ),)
                                  ),
                                );
                              }
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) =>
                                      Styles.circleProfile(
                                          widget: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              const Positioned(
                                                  bottom: 8,
                                                  right: 5,
                                                  child: CircleAvatar(radius: 5,)),
                                              Container(
                                                  height: 100,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              snapshot
                                                                  .data!.docs[index]
                                                                  .get("image"))))),
                                            ]
                                          ),
                                          context: context,
                                          // onTap: Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (index)=>Chats())),
                                          text: snapshot.data!.docs[index]
                                              .get("name")));
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: const MenuWidget()),
    );
  }
}
