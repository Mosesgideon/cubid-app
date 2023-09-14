import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:social_media/features/notifications/presentations/screens/widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(icon: Icon(Iconsax.arrow_left,size: 20,color: Theme.of(context).colorScheme.onBackground,), onPressed: () {
          Navigator.pop(context);
          },),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Notifications',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Iconsax.notification,size: 20,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<dynamic>>(
              stream: FirebaseFirestore.instance
                  .collection("notifications")
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Image.asset("assets/png/error.png"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Shimmer(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                    ),
                  );
                } else if (snapshot.data == null && snapshot.data != null) {
                  return Center(
                      child: Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                        height: 100, width: 100, "assets/png/nodata.png"),
                  ));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationItem(
                        tittle: snapshot.data.docs[index].get('tittle'),
                        message: snapshot.data.docs[index].get('body'),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
