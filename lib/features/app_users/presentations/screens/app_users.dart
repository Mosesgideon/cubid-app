import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUsers extends StatefulWidget {
  const AppUsers({Key? key}) : super(key: key);

  @override
  State<AppUsers> createState() => _AppUsersState();
}

class _AppUsersState extends State<AppUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text("Opps! somthing went wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => Card(
                color: Theme.of(context).cardColor,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      snapshot.data!.docs[index].get('image'),

                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data.docs[index].get('name'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            Text(
                              snapshot.data.docs[index].get('number'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        }
      },
    ));
  }
}
