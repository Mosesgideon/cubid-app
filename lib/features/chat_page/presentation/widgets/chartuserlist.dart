import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';
import 'package:social_media/features/chat_page/presentation/widgets/chat_bubble.dart';
import 'package:social_media/features/chat_page/presentation/widgets/chat_services.dart';

class FriendsChat extends StatefulWidget {
  final String email;
  final String currentUserId;

  const FriendsChat(
      {Key? key, required this.email, required this.currentUserId})
      : super(key: key);

  @override
  State<FriendsChat> createState() => _FriendsChatState();
}

class _FriendsChatState extends State<FriendsChat> {
  final _controller = TextEditingController();
  final auth = FirebaseAuth.instance;
  final service = ChatServices();

  void SendMessage() async {
    //send message
    if (_controller.text.isNotEmpty) {
      await service.sendMessage(widget.currentUserId, _controller.text);
      //clear message
      _controller.clear();
    }
  }

  void createNotification( String recieverid){

  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        //build message item
        Expanded(child: buildMessageList()),

        //build message input
        buildMessageInput()
      ]),
    );
  }

  ////build message list
  Widget buildMessageList() {
    return StreamBuilder(
        stream:
            service.getMessages(widget.currentUserId, auth.currentUser!.uid),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return const Text("something went wrong");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs
                  .map((document) => buildMessageItem(document))
                  .toList(),
            );
          }
        });
  }

//////MESSAGEINPUT
  Widget buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: OutlinedFormField(
            controller: _controller,
            preffix: const Icon(
              Iconsax.gallery,
              color: Colors.black,
            ),
            suffix: GestureDetector(
                onTap: SendMessage, child: const Icon(Iconsax.send1)),
            hint: 'send message',
          ),
        )
      ],
    );
  }

//build message input
  Widget buildMessageItem(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    var aligment = (data['senderId'] == auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: aligment,
        child: Column(
          children: [
            // Text(snapshot.data().toString()),

            data['senderId'] == auth.currentUser!.uid
                ? ChatBubble(message: data['message'])
                : ChatBubbleNotUser(message: data['message']),
                 // Text(data['date']),
          ],
        ),
      ),
    );
  }
}
