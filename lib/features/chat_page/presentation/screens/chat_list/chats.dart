import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/chat_page/presentation/widgets/chartuserlist.dart';

class UserChats extends StatefulWidget {
  final String recieveremail;
  final String recieverimage;
  final String recieveruid;
  // final String recieverNumber;

  const UserChats({
    Key? key,
    required this.recieveremail,
    required this.recieverimage,
    required this.recieveruid,
  }) : super(key: key);

  @override
  State<UserChats> createState() => _UserChatsState();
}

class _UserChatsState extends State<UserChats> {
  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.video5,
                size: 20,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.call5,
                size: 20,
              ))
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        title: Text(
          widget.recieveremail,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: FriendsChat(
            email: widget.recieveremail,
            currentUserId: widget.recieveruid,
          ),
        ),
      ),
    );
  }
}
