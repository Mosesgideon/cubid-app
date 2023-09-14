import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:social_media/features/chat_page/presentation/screens/chat_list/chats.dart';
import 'package:social_media/features/chat_page/presentation/screens/widgets/chat_list.dart';

class Chats extends StatefulWidget {
  Chats({
    Key? key,
  }) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _searchController=TextEditingController();
  final Stream<QuerySnapshot<Map<String, dynamic>>> _users = FirebaseFirestore
      .instance
      .collection("users")
      .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  late bool open = false;

  String _searchTerm = '';

  // Function to search for users based on the provided search term
  Future<void> _searchUsers() async {
    setState(() {
      _searchTerm = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Users',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Iconsax.message,
              size: 20,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        ],
      ),
      body: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              gapPadding: 2,
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: Colors.grey.withOpacity(0.2),
                          hintText: 'search user',
                          suffixIcon: const Icon(
                            Iconsax.search_normal_1,
                            size: 15,
                          ),
                          iconColor: Colors.grey,
                          prefixIconColor: Colors.grey,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          suffixIconColor:
                              Theme.of(context).colorScheme.primary,
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 13)),
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 0),
                    // decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: StreamBuilder(
                                stream: _users,
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text("something went wrong");
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200]),
                                      ),
                                    );
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder: (context, index) {
                                        return ChatWidgets.card(
                                          title: snapshot.data!.docs[index]
                                              .get("name"),
                                          time: snapshot.data!.docs[index]
                                              .get('number'),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return UserChats(
                                                    recieveremail: snapshot
                                                        .data!.docs[index]
                                                        .get("name"),
                                                    recieverimage: snapshot
                                                        .data!.docs[index]
                                                        .get("image"),
                                                    recieveruid: snapshot
                                                        .data!.docs[index].id,
                                                    // uid: snapshot.data!.docs[index].get(uid),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          context: context,
                                          // voildCallback: Navigator.of(context)
                                          //     .push(CupertinoPageRoute(
                                          //         builder: (ctx) => ViewImage(
                                          //               image: snapshot
                                          //                   .data!.docs[index]
                                          //                   .get("image"),
                                          //             ))),
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]
                                              .get("image")),
                                        );
                                      },
                                    );
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
