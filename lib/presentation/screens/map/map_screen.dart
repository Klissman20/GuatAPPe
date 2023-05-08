import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:guatappe/presentation/screens/screens.dart';
import '../../../infrastructure/models/marker_model.dart';
//import '../../screens/screens.dart';

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
  late BitmapDescriptor pinLocationIcon;

  final Set<Marker> _markers = {};
  final List<Markers> _markerModels = [];

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), 'assets/icono.png');
  }

  @override
  void initState() {
    setCustomMapPin();
    super.initState();
  }

  void onMapCreated(
      GoogleMapController controller, BuildContext context_) async {
    mapController = controller;
    for (var i = 0; i < referenceLatLng.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId('id-$i'),
          position: referenceLatLng[i],
          infoWindow: InfoWindow(
            title: "Marcador:$i",
            snippet: "Snippet",
            onTap: () {
              context.goNamed(PopupScreen.name);
            },
          ),
          icon: pinLocationIcon));
      _markerModels.add(Markers(
          name: 'name',
          description: 'description',
          marker: _markers.elementAt(i)));
    }
  }

  /* getPolyline() async {
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
  } */

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
            markers: _markers,
            initialCameraPosition:
                CameraPosition(target: center1, zoom: 15.5, tilt: 50.0),
            polylines: Set<Polyline>.of(polylines.values)),
        Positioned(
            right: 30,
            top: 50,
            child: FilledButton(
                onPressed: () {
                  //getPolyline();
                  setState(() {});
                },
                child: const Text('Show Route')))
      ],
    ));
  }
}
