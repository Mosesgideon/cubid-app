import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  final String title;
  final String message;
  final String image;

  const NotificationItem(
      {Key? key,
      required this.title,
      required this.message,
      required this.image})
      : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Card(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
        elevation: 0,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Message from ${widget.title}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        const Text(
                          '10:45 pm',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.message,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
