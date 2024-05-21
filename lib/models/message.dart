class Message {
  Message({
    this.id,
    required this.senderID,
    required this.chatID,
    required this.createdAt,
    required this.content,
  });

  /// User ID of the User
  final int? id;
  final int chatID;

  /// Username of the User
  final String senderID;
  final DateTime createdAt;
  final String content;

  Message.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        senderID = map['sender_id'],
        chatID = map['chat_id'],
        createdAt = DateTime.parse(
          map['created_at'],
        ),
        content = map['content'];

/*  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderID,
      'receiver_id': receiverID,
      'content': content,
    };
  }*/
}
