import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  String name;
  String description;
  Image image;
  LatLng position;

  MarkerModel(
      {required this.name,
      required this.description,
      required this.position,
      required this.image});
}
