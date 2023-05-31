import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerEntity {
  final int id;
  final String name;
  final String description;
  final List<Image> image;
  final Future<BitmapDescriptor>? iconMarker;
  final LatLng position;

  MarkerEntity(
      {required this.id,
      required this.iconMarker,
      required this.name,
      required this.description,
      required this.position,
      required this.image});
}
