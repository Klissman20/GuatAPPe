class UserModel {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String gender;
  final String country;
  final int phone;

  UserModel(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      required this.gender,
      required this.country,
      required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      gender: json['genre'],
      country: json['country'],
      phone: json['phone']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "email": email,
        "country": country,
        "gender": gender,
        "phone": phone,
      };
}
