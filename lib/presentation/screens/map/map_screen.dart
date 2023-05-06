import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../screens/screens.dart';

class MapScreen extends StatefulWidget {
  static const String name = 'map_screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng center1 = const LatLng(6.233, -75.158);
  late GoogleMapController mapController;
  String googleAPiKey = "AIzaSyCjWxZLRim7FfOWIcDm4h83vOqJHe8rNVw";
  late PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> markers = {};

  void onMapCreated(
      GoogleMapController controller, BuildContext context_) async {
    mapController = controller;
    markers = {
      const MarkerId('value'): Marker(
          markerId: const MarkerId("uno"),
          position: const LatLng(6.234673108822359, -75.16320162604464),
          onTap: () {
            context_.goNamed(LoginScreen.name);
          }),
      const MarkerId("dos"): const Marker(
          markerId: MarkerId("value"),
          position: LatLng(6.232135092314113, -75.1564125818234))
    };
  }

  getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        const PointLatLng(6.234673108822359, -75.16320162604464),
        const PointLatLng(6.232135092314113, -75.1564125818234),
        travelMode: TravelMode.transit);

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: const Color.fromRGBO(6, 1, 167, 0.6),
      width: 8,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 15.5, target: polylineCoordinates[result.points.length ~/ 2])));
    setState(() {});
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
            onMapCreated: (controller) {
              onMapCreated(controller, context);
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            compassEnabled: true,
            markers: Set.of(markers.values),
            initialCameraPosition:
                CameraPosition(target: center1, zoom: 15.5, tilt: 50.0),
            polylines: Set<Polyline>.of(polylines.values)),
        Positioned(
            right: 30,
            top: 50,
            child: FilledButton(
                onPressed: () {
                  getPolyline();
                },
                child: Text('Show Route')))
      ],
    ));
  }
}
