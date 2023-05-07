import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/presentation/screens/screens.dart';

List<LatLng> referenceLatLng = [
  const LatLng(6.2207260149012455, -75.17947304698288),
  const LatLng(6.229598621338858, -75.1787076388338),
  const LatLng(6.23265236289733, -75.16662940513794),
  const LatLng(6.235386582227664, -75.16274920989979),
  const LatLng(6.235236977647446, -75.1623255947003),
  const LatLng(6.2350918057533615, -75.16190866815133),
  const LatLng(6.234777081816057, -75.16134013193083),
  const LatLng(6.235541727677295, -75.16168794231076),
  const LatLng(6.235086264840695, -75.16137580478286),
  const LatLng(6.234312583116759, -75.15966299669682),
  const LatLng(6.23343118128229, -75.16078372149775),
  const LatLng(6.2327577833006, -75.16103285510259),
  const LatLng(6.2325869733987895, -75.16154961107048),
  const LatLng(6.233056309831474, -75.16168663649425),
  const LatLng(6.23329097788889, -75.16162422887523),
  const LatLng(6.234259319683774, -75.16189149626756),
  const LatLng(6.234133893898507, -75.16138409520177),
  const LatLng(6.234175702496582, -75.1611738086747),
  const LatLng(6.23447240858383, -75.16138952194993),
  const LatLng(6.234556025724918, -75.16122264940549),
  const LatLng(6.233093330814248, -75.15692414269232),
  const LatLng(6.234454448410652, -75.15721275695284),
  const LatLng(6.232221605334246, -75.15707683829378),
  const LatLng(6.231356424733816, -75.15328502323882),
];

class Markers {
  String name;
  String description;
  Image photo = Image.asset("name");
  Marker marker;

  Markers(
      {required this.name, required this.description, required this.marker});

  //Set<Marker> getMarker() {
  //  for (var latlng in referenceLatLng) {
  //    markers.add(Marker(markerId: id, position: latlng));
  //  }
  //  return markers;
  // }
}
