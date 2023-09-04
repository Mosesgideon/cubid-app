import 'package:flutter/material.dart';

import 'package:social_media/features/video_tab/presentations/widgets/myuploads.dart';

class Videos extends StatefulWidget {
  final VoidCallback opendrawer;

  const Videos({Key? key, required this.opendrawer}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              "Videos and Reels",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),));

        // body: ListView.builder(itemBuilder: (ctx, index) => Uploads()));
  }
}
