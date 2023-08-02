import 'package:flutter/material.dart';
import 'package:social_media/app_constants/theme/app_colors.dart';
import 'package:social_media/features/chats_tab/presentations/widgets/search_animated_container.dart';
import 'package:social_media/features/chats_tab/presentations/widgets/styles.dart';

class ChatWidgets {
  bool isdark = false;

  static Widget card({
    voildCallback,
    title,
    time,
    subtitle,
    onTap,
    image,
    required BuildContext context,
  }) {
    return ListTile(

      onTap: onTap,
      contentPadding: const EdgeInsets.all(5),
      leading: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          height: 50,width: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(image: image,fit: BoxFit.cover)
            ),
        )
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onBackground),
      ),

      subtitle: Text(
        time,
        style: const TextStyle(color: darkGrey),
      ),


    );
  }

  static Widget circleProfile({onTap, name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
                width: 50,
                child: Center(
                    child: Text(
                  name,
                  style: const TextStyle(
                      height: 1.5, fontSize: 12, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                )))
          ],
        ),
      ),
    );
  }

  static Widget messagesCard(i, message, time, bool check) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (check) const Spacer(),
          if (!check)
            const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 10,
              child: Icon(
                Icons.person,
                size: 13,
                color: Colors.white,
              ),
            ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   margin: const EdgeInsets.all(8),
                //   padding: const EdgeInsets.all(10),
                //   child: Text(
                //     '$message',
                //     style: TextStyle(color: check ? Colors.white : Colors.black),
                //   ),
                //   decoration: Styles.messagesCardStyle(check),
                // ),
              ],
            ),
          ),
          if (check)
            const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 13,
                color: Colors.white,
              ),
              backgroundColor: Colors.grey,
              radius: 10,
            ),
          if (!check) const Spacer(),
        ],
      ),
    );
  }

  static messagesCardStyle(check) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: check ? Colors.indigo.shade300 : Colors.grey.shade300,
    );
  }

  static messageFieldCardStyle() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo),
        borderRadius: BorderRadius.circular(10));
  }

  static messageField({required onSubmit}) {
    final con = TextEditingController();
    // return Container(
    //   margin: const EdgeInsets.all(5),
    //   child: TextField(
    //     controller: con,
    //     decoration: Styles.messageTextFieldStyle(onSubmit: () {
    //       onSubmit(con);
    //     }),
    //   ),
    //   decoration: Styles.messageFieldCardStyle(),
    // );
  }

  static searchBar(
    bool open,
  ) {
    return AnimatedDialog(
      height: open ? 800 : 0,
      width: open ? 400 : 0,
    );
  }

  static searchField({Function(String)? onChange}) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: Styles.messageFieldCardStyle(),
      child: TextField(
        onChanged: onChange,
        decoration: Styles.searchTextFieldStyle(),
      ),
    );
  }
}
