class UserEntity {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String genre;
  final int phone;

  UserEntity(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      required this.genre,
      required this.phone});
}
