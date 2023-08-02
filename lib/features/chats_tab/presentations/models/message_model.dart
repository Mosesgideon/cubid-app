


import 'package:social_media/features/chats_tab/presentations/models/user_model.dart';

class Message{
 late final User sender;
 late final String time;
 late final String text;
 late final bool unRead;

 Message({
  required this.sender, required this.time, required this.text, required this.unRead
});
}
List<Message>chats=[

];