class CustomUser {
  CustomUser(
      {required this.id,
      required this.username,
      required this.createdAt,
      required this.status,
      required this.image,
      required this.role,
      required this.rating,
      required this.ratingNumber});

  final String id;
  final bool status;
  final String username;
  final String image;
  final String role;
  final DateTime createdAt;
  final double rating;
  final int ratingNumber;

  CustomUser.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        status = map['status'],
        image = map['image_url'],
        role = map['role'],
        rating = map['rating'].toDouble(),
        ratingNumber = map['rating_number'],
        createdAt = DateTime.parse(
          map['created_at'],
        );
}
