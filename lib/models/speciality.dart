class Speciality {
  Speciality({
    required this.id,
    required this.title,
  });

  /// User ID of the User
  final int id;

  /// Username of the User
  final String title;

  Speciality.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'];
}
