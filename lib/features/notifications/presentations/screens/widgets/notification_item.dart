import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  final String tittle;
  final String message;


  const NotificationItem(
      {Key? key,
      required this.tittle,
      required this.message,})
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tittle,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).colorScheme.onBackground),
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
                const Text(
                  '10:45 pm',
                  style: TextStyle(color: Colors.grey),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
