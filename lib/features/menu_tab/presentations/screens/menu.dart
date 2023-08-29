import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/chat_page/presentation/screens/chat_list/chat_page.dart';
import 'package:social_media/features/chats_tab/presentations/widgets/styles.dart';
import 'package:social_media/features/menu_tab/presentations/screens/privat_userpost.dart';
import 'package:social_media/features/menu_tab/presentations/widgets/menu_widget.dart';



class UserMenu extends StatefulWidget {


  const UserMenu({Key? key,}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Cubid App',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 18),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Iconsax.add_circle,
                size: 20,
              )),
          IconButton(
              splashRadius: 20,
              icon: const Icon(Iconsax.search_normal_1, size: 20), onPressed: () {  },
              ),
          IconButton(
            splashRadius: 20,
            icon: const Icon(Iconsax.message, size: 20),
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (index) => Chats()));
            },
          ),
        ],
      ),
      body: NestedScrollView(
          floatHeaderSlivers: true,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    height: 100,
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
                                    child: Text(
                                      "updating",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                    ),
                                  ),
                                );
                              }
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) =>
                                      Styles.circleProfile(
                                               widget:Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "image")))
                                                  )),

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
          body:const MenuWidget()),
    );
  }
}



