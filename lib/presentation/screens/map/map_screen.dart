import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';

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
  late String _mapStyle;

  final Set<Marker> _markers = {};
  final List<Markers> _markerModels = [];

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2), 'assets/icono.png');
  }

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
    });
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
            title: "Punto: $i",
            snippet: "Ver más Info",
            onTap: () {
              context.goNamed('details_screen');
            },
          ),
          icon: pinLocationIcon));
      _markerModels.add(Markers(
          name: 'name',
          description: 'description',
          marker: _markers.elementAt(i)));
    }
    mapController.setMapStyle(_mapStyle);
    setState(() {});

    //mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition))
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
              markers: _markers,
              initialCameraPosition:
                  CameraPosition(target: center1, zoom: 15.5, tilt: 50.0),
              polylines: Set<Polyline>.of(polylines.values))
        ],
      ),
    );
  }
}
/*   final List list = ['One', 'Two', 'Three', 'Four'];

  Future<void> _showInfoDialog() async { 
    return showGeneralDialog<void>(
      context: context,
      transitionBuilder: (context, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2))),
            title: Stack(children: [
              Image.asset("assets/images/plazoleta.png"),
              Positioned(
                left: 5.0,
                top: 210.0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color.fromRGBO(0, 0, 0, 0.6)),
                  child: const Text(
                    textAlign: TextAlign.start,
                    'Plazoleta del Zócalo',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: IconButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(15),
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(0, 0, 0, 0.6))),
                    iconSize: 22.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                  ))
            ]),
            titlePadding: const EdgeInsets.all(2.0),
            content: const SingleChildScrollView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InfoPopup(),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(0xFF, 0xDB, 0x41, 0x1F),
                      shape: const BeveledRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                  onPressed: () {
                    getPolyline();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Como llegar',
                      style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(0xFF, 0xDB, 0x41, 0x1F),
                      shape: const BeveledRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(2.5)))),
                  onPressed: () {
                    context.goNamed('register_screen');
                  },
                  child: const Text(
                    'Activar AR',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
            actionsAlignment: MainAxisAlignment.spaceAround,
            actionsPadding: const EdgeInsets.only(bottom: 10, top: 0),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, a1, a2) {
        return Container();
      },
    );
  }
}
*/
