import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideDrawerMenuDisplay extends StatefulWidget {
  const SideDrawerMenuDisplay({Key? key}) : super(key: key);

  @override
  State<SideDrawerMenuDisplay> createState() => _SideDrawerMenuDisplayState();
}

class _SideDrawerMenuDisplayState extends State<SideDrawerMenuDisplay> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("opps!,something went wrong"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          } else {
           return ListView.builder(
             itemCount: snapshot.data!.docs.length,
               physics: const NeverScrollableScrollPhysics(),
               itemBuilder: (context, index) {
              return Container(

                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: NetworkImage(
                                  snapshot.data!.docs[index].get('image'),
                                ),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data.docs[index].get('username'),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data.docs[index].get('email'),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.5)),
                          ),
                          const Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 10,
                          )
                        ],
                      ),
                    ],
                  ));
            });
          }
        },
      ),
    );
  }
}
