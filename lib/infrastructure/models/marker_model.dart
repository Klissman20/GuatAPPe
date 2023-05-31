import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  final int id;
  final String name;
  final String description;
  List<Image>? image;
  final String latitude;
  final Future<BitmapDescriptor>? iconMarker;
  final String longitude;

  MarkerModel(
      {required this.id,
      required this.latitude,
      this.iconMarker,
      required this.longitude,
      required this.name,
      required this.description,
      this.image});

  factory MarkerModel.fromJson(Map<String, dynamic> json) => MarkerModel(
        id: json['id'],
        name: json['name'],
        description: json['decription'],
        latitude: json['latitude'],
        longitude: json['logitude'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
      };
}
