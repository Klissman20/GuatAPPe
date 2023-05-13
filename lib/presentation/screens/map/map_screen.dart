import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/presentation/screens/screens.dart';

List<MarkerModel> markers = [
  MarkerModel(
      name: 'Punto1',
      description: 'description1',
      position: const LatLng(6.23447240858383, -75.16138952194993)),
  MarkerModel(
      name: 'Punto2',
      description: 'description2',
      position: const LatLng(6.232221605334246, -75.15707683829378)),
  MarkerModel(
      name: 'Punto3',
      description: 'description3',
      position: const LatLng(6.233093330814248, -75.15692414269232)),
  MarkerModel(
      name: 'Punto4',
      description: 'description4',
      position: const LatLng(6.235386582227664, -75.16274920989979)),
  MarkerModel(
      name: 'Punto5',
      description: 'description5',
      position: const LatLng(6.2350918057533615, -75.16190866815133)),
  MarkerModel(
      name: 'Punto6',
      description: 'description6',
      position: const LatLng(6.234777081816057, -75.16134013193083)),
  MarkerModel(
      name: 'Punto7',
      description: 'description7',
      position: const LatLng(6.234259319683774, -75.16189149626756)),
  MarkerModel(
      name: 'Punto8',
      description: 'description8',
      position: const LatLng(6.234133893898507, -75.16138409520177)),
];

class MapScreen extends StatefulWidget {
  static const String name = 'map_screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late String mapStyle;
  late BitmapDescriptor pinLocationIcon;
  LatLng center1 = const LatLng(6.233, -75.158);
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  String googleAPiKey = "AIzaSyCjWxZLRim7FfOWIcDm4h83vOqJHe8rNVw";
  late PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  void setCustomMapPin() async {
    if (Platform.isIOS) {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/logo/icono_40x40.png');
    } else if (Platform.isAndroid) {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/logo/icono_150x150.png');
    }
  }

  Future<void> onMapCreated(
      GoogleMapController controller, BuildContext context_) async {
    mapController = controller;
    mapController.setMapStyle(mapStyle);
    for (final marker in markers) {
      _markers.add(Marker(
          markerId: MarkerId(marker.name),
          position: marker.position,
          //infoWindow: InfoWindow(title: marker.name, snippet: 'Ver mas'),
          onTap: () {
            _showMyDialogMarker(markers[0], context_);
          },
          icon: pinLocationIcon));
      setState(() {});
    }
  }

  Future<void> _showMyDialogMarker(
      MarkerModel marker, BuildContext context_) async {
    return showDialog<void>(
      context: context_,
      barrierDismissible: true, // user must tap button!
      builder: (context_) {
        return AlertDialog(
          title: Text(marker.name),
          content: SingleChildScrollView(
            child: Text(marker.description),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Como llegar'),
              onPressed: () {
                getPolyline();
                Navigator.pop(context_);
              },
            ),
            TextButton(
              child: const Text('Ver más'),
              onPressed: () {
                context_.pushNamed(DetailsScreen.name);
              },
            ),
          ],
        );
      },
    );
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
  void initState() {
    rootBundle.loadString('assets/map_style.json').then((string) {
      mapStyle = string;
    });
    setCustomMapPin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
        onMapCreated: (controller) {
          onMapCreated(controller, context);
        },
        markers: _markers,
        initialCameraPosition:
            CameraPosition(target: center1, zoom: 15.5, tilt: 50.0),
      )),
    );
  }
}
