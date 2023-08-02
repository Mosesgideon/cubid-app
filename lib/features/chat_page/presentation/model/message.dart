class Message {
  final String senderID;
  final String senderEmail;
  final String recieverID;
  final String message;
  final String time;

  Message(
      {required this.senderID,
      required this.senderEmail,
      required this.recieverID,
      required this.message,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderID,
      'senderEmail': senderEmail,
      'recievreId': recieverID,
      'message': message,
      'time': time
    };
  }
}
