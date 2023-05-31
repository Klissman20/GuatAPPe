class UserModel {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String genre;
  final int phone;

  UserModel(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      required this.genre,
      required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      genre: json['genre'],
      phone: json['phone']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "email": email,
        "phone": phone,
      };
}
