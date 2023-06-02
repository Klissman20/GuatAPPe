class UserEntity {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String gender;
  final String country;
  final int phone;

  UserEntity(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      required this.gender,
      required this.country,
      required this.phone});
}
