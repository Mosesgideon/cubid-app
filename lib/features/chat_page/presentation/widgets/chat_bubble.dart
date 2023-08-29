import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Colors.grey),
          child: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Text(
          time,
          style: const TextStyle(color: Colors.grey,fontSize: 10),
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
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5)),

              color: Colors.grey),
          child: Text(
            message,
            style: const TextStyle(color: Colors.black),

          ),
        ),
        Text(
          time,
          style: const TextStyle(color: Colors.grey,fontSize: 10),

        ),
      ],
    );
  }
}
