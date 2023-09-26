import 'package:flutter/material.dart';
import 'package:social_media/app_constants/theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;

  const ChatBubble({Key? key, required this.message, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
          decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color:Theme.of(context).colorScheme.primary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(color: textcolor,fontSize: 15),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.grey,fontSize: 6,fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),

      ],
    );
  }
}



class ChatBubbleNotUser extends StatelessWidget {
  final String message;
  final String time;
  const ChatBubbleNotUser({Key? key, required this.message, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
          decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),

              color: Theme.of(context).colorScheme.onBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(color: textcolor,fontSize: 15),

              ),
              Text(
                time,
                style: const TextStyle(color: Colors.grey,fontSize: 6,fontWeight: FontWeight.w600),

              ),
            ],
          ),
        ),

      ],
    );
  }
}
