class ModulePost {
  ModulePost(
      {required this.id,
      required this.title,
      required this.idModule,
      required this.image});

  final int id;
  final int idModule;

  final String title;
  final String image;

  ModulePost.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        idModule = map['id_module'],
        image = map['image'],
        title = map['title'];
}
