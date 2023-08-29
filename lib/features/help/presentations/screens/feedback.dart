import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final feedbackcontroller = TextEditingController();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Send Us FeedBack",
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Text(
            //   "How do we do?",
            //   style: TextStyle(
            //     color: Theme.of(context).colorScheme.onBackground,
            //   ),
            // ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 8,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: OutlinedFormField(
                      maxLine: 7,
                      controller: feedbackcontroller,
                      hint: 'Drop a feedback',
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  // Text(
                  //   "Rate us",
                  //   style: TextStyle(
                  //       color: Theme.of(context).colorScheme.onBackground,
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: 18),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Center(
                  //   child: SmoothStarRating(
                  //     color: Theme
                  //         .of(context)
                  //         .colorScheme
                  //         .secondary,
                  //     borderColor: Theme
                  //         .of(context)
                  //         .colorScheme
                  //         .onBackground,
                  //     allowHalfRating: true,
                  //     rating: 4,
                  //     size: 25,
                  //   ),
                  // ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  CustomButton(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: isloading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(),
                            )
                          : const Text("Publish FeedBack"),
                      onPressed: () {
                        feedbackReport();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Your FeedBack will be reviewed",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> feedbackReport() async {
    CollectionReference report =
        FirebaseFirestore.instance.collection('reports');

    CollectionReference abuse =
        FirebaseFirestore.instance.collection('feedback');
    // Call the user's CollectionReference to add a new report
    return await report
        .add({
          'abusetype': feedbackcontroller,
        })
        .then((value) => print("report added"))
        .catchError((error) => {
              setState(() {
                isloading = false;
              }),
              print('failed')
            });
  }
}
