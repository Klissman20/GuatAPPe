class MarkerModel {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;

  MarkerModel(
      {required this.id,
      required this.latitude,
      required this.longitude,
      required this.name,
      required this.description});

  factory MarkerModel.fromJson(Map<String, dynamic> json) => MarkerModel(
        id: json['id'] ?? '',
        name: json['name'],
        description: json['description'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
      };
}
