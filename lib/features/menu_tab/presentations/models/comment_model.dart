
class CommentModel{
  final String comment;
  final String time;
  final String senderID;

  CommentModel({
    required this.comment, required this.time, required this.senderID,
});

  Map<String, dynamic> toMap() {
    return {
      'comment':comment,
      'senderId': senderID,
      'time': time
    };
  }
  }