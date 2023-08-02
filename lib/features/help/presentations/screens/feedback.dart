import 'package:flutter/material.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title:  Text(
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
            const Expanded(
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
                      child: const Text("Publish FeedBack"), onPressed: () {}),
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
}
