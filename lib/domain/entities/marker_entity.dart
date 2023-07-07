import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerEntity {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final List<Image>? imageList;
  final Future<BitmapDescriptor>? iconMarker;
  final LatLng position;

  MarkerEntity(
      {required this.latitude,
      required this.longitude,
      required this.id,
      this.iconMarker,
      required this.name,
      required this.description,
      required this.position,
      this.imageList});
}
