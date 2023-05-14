import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guatappe/config/constants/environment.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/presentation/screens/screens.dart';

final String lorem =
    'Est in sunt adipisicing elit ipsum cillum et ea ullamco voluptate qui incididunt aute commodo. Deserunt excepteur commodo magna et id consequat sit nostrud. Officia ut cillum veniam est est quis aliquip adipisicing exercitation in.';
List<MarkerModel> markers = [
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'La Piedra',
    position: const LatLng(6.2207260149012455, -75.17947304698288),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Comfama',
    position: const LatLng(6.229598621338858, -75.1787076388338),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Bicentenario',
    position: const LatLng(6.23265236289733, -75.16662940513794),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Plazoleta del Zócalero',
    position: const LatLng(6.235386582227664, -75.16274920989979),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Comando',
    position: const LatLng(6.235236977647446, -75.1623255947003),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Cordero',
    position: const LatLng(6.2350918057533615, -75.16190866815133),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Terminal de Transporte',
    position: const LatLng(6.234777081816057, -75.16134013193083),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Malecón',
    position: const LatLng(6.235541727677295, -75.16168794231076),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Memoria de puertas, ventanas y bocallaves',
    position: const LatLng(6.235086264840695, -75.16137580478286),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Casa del Arriero',
    position: const LatLng(6.234312583116759, -75.15966299669682),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Calle del Recuerdo',
    position: const LatLng(6.23343118128229, -75.16078372149775),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Calle Jiménez',
    position: const LatLng(6.2327577833006, -75.16103285510259),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Callejón Julia Pastusa',
    position: const LatLng(6.2325869733987895, -75.16154961107048),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Mural Enriquetica - Bernardo Arcila',
    position: const LatLng(6.233056309831474, -75.16168663649425),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Zócalo Banda de los Zuluaga',
    position: const LatLng(6.23329097788889, -75.16162422887523),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Parque Principal',
    position: const LatLng(6.234259319683774, -75.16189149626756),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Iglesia y Casa Cural',
    position: const LatLng(6.234133893898507, -75.16138409520177),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Mural de los 200 años',
    position: const LatLng(6.234175702496582, -75.1611738086747),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Alcaldía',
    position: const LatLng(6.23447240858383, -75.16138952194993),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Casa Isidora Urrea',
    position: const LatLng(6.234556025724918, -75.16122264940549),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Hospital la Inmaculada',
    position: const LatLng(6.233093330814248, -75.15692414269232),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Letras Guatapé',
    position: const LatLng(6.234454448410652, -75.15721275695284),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Capilla hermanas de Santa Ana',
    position: const LatLng(6.232221605334246, -75.15707683829378),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/plazoleta.png"),
    name: 'Alto Verde',
    position: const LatLng(6.231356424733816, -75.15328502323882),
  )
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

  String googleAPiKey = Environment.google_api_key;

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
          infoWindow: InfoWindow(
            title: marker.name,
          ),
          onTap: () {
            _showMyDialogMarker(marker, context_);
          },
          icon: pinLocationIcon));
      setState(() {});
    }
  }

  /* Future<void> _showMyDialogMarker(
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
                context_.pushNamed(DetailsScreen.name, extra: marker);
              },
            ),
          ],
        );
      },
    );
  } */

  Future<void> _showMyDialogMarker(
      MarkerModel marker, BuildContext context_) async {
    return showModalBottomSheet(
      context: context_,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      isScrollControlled: true,
      showDragHandle: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: double.infinity, child: marker.image),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  lorem,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  marker.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color(0xFFDB411F)),
                  label: Text(
                    "Como llegar",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    getPolyline();
                    Navigator.pop(context_);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color(0xFFDB411F)),
                  label: Text(
                    "Ver más información",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    context_.pushNamed(DetailsScreen.name, extra: marker);
                  },
                ),
              ),
            ],
          ),
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
