import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guatappe/config/constants/environment.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';

import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  static const String name = 'map_screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late String mapStyle;
  late BitmapDescriptor pinLocationIcon;
  late GoogleMapController mapController;

  final Set<Marker> _markers = {};
  late MarkerModel selectedMarker = markers[0];

  String googleAPiKey = Environment.googleMapApiKey;

  late PersistentBottomSheetController sheetController;
  bool showSheet = false;
  bool isSheetLarge = false;
  late BuildContext _scaffoldCtx;

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
    controller.setMapStyle(mapStyle);
    for (final marker in markers) {
      _markers.add(Marker(
          markerId: MarkerId(marker.name),
          position: marker.position,
          infoWindow: InfoWindow(
            title: marker.name,
            onTap: () {},
          ),
          onTap: () {
            _showSheet(marker);
          },
          icon: pinLocationIcon));
    }
    setState(() {});
  }

  // void animatedShow(double toSize) {
  //   controller.animateTo(toSize,
  //       duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  // }

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
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

/*   Future<void> _showMyDialogMarker(
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
 */

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
        extendBodyBehindAppBar: true,
        body: Builder(builder: (BuildContext ctx) {
          _scaffoldCtx = ctx;
          return SafeArea(
              child: Stack(children: [
            GoogleMap(
              onMapCreated: (controller) {
                onMapCreated(controller, context);
              },
              markers: _markers,
              mapToolbarEnabled: false,
              initialCameraPosition:
                  CameraPosition(target: center1, zoom: 15.5, tilt: 20.0),
            ),
          ]));
        }),
        floatingActionButton: isSheetLarge
            ? FloatingActionButton(
                heroTag: "fab",
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 3,
                child: Icon(Icons.close_rounded,
                    color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  isSheetLarge = !isSheetLarge;
                  sheetController.close();
                  setState(() {});
                })
            : null);
  }

  void _showSheet(MarkerModel marker) {
    sheetController = showBottomSheet(
        context: _scaffoldCtx,
        builder: (BuildContext bc) {
          return Container(
              color: Colors.white,
              width: double.infinity,
              height:
                  isSheetLarge ? MediaQuery.sizeOf(context).height - 200 : null,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      marker.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Row(children: [Expanded(child: image)]),
                  isSheetLarge
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              image,
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(marker.description),
                              ),
                            ]),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),

                  isSheetLarge
                      ? Row(children: [
                          Expanded(
                            child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.gif_box_outlined),
                                label: Text('Activar AR')),
                          ),
                        ])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.location_pin),
                                  label: Text('Como llegar')),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      isSheetLarge = !isSheetLarge;
                                      _showSheet(marker);
                                    });
                                  },
                                  icon: Icon(Icons.info_rounded),
                                  label: Text('Ver mas')),
                            ])
                ],
              ));
        });

    sheetController.closed.then((value) {
      // update state to indicate that the sheet is no longer being shown
      setState(() {
        isSheetLarge = false;
        _showSheet(marker);
      });
    });
  }
}
