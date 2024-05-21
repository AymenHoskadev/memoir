class Module {
  Module(
      {required this.id,
      required this.title,
      required this.idSpeciality,
      required this.semestre});

  /// User ID of the User
  final int id;
  final int idSpeciality;
  final int semestre;

  /// Username of the User
  final String title;

  Module.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        idSpeciality = map['subspeciality_id'],
        semestre = map['semestre'],
        title = map['title'];
}
