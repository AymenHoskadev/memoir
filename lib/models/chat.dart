class Chat {
  Chat({
    this.id,
    required this.usersID,
    required this.createdAt,
  });

  /// User ID of the User
  final int? id;

  /// Username of the User
  final List<dynamic> usersID;
  final DateTime createdAt;

  Chat.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        usersID = map['users_id'],
        createdAt = DateTime.parse(
          map['created_at'],
        );
}
