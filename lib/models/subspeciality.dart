class SubSpeciality {
  SubSpeciality(
      {required this.id,
      required this.title,
      required this.branche,
      required this.idSpeciality});

  /// User ID of the User
  final int id;
  final int idSpeciality;

  /// Username of the User
  final String title;
  final String branche;

  SubSpeciality.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        idSpeciality = map['id_speciality'],
        title = map['title'],
        branche = map['branche'];
}
