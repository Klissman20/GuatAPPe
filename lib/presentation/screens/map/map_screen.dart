import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guatappe/config/constants/environment.dart';
import 'package:guatappe/config/theme/app_theme.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';

import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  static const String name = 'map_screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
// Google Maps & Markers
  late String mapStyle;
  late BitmapDescriptor pinLocationIcon;
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  late MarkerModel selectedMarker = markers[0];
  String googleAPiKey = Environment.googleMapApiKey;
// Details View - show BottomSheet
  late PersistentBottomSheetController sheetController;
  bool showSheet = false;
  bool isSheetLarge = false;
  late BuildContext _scaffoldCtx;

// Draw Route GoTo Point
  late PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  late PointLatLng myLocation;

  void setCustomMapPin() async {
    if (Platform.isIOS) {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/logo/icono_40x40.png');
    } else if (Platform.isAndroid) {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/logo/icono_150x150.png');
    }
  }

// Create Map with markers
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
            onTap: () {
              setState(() {
                isSheetLarge = selectedMarker == marker;
              });
              _showSheet(marker);
            },
          ),
          onTap: () {
            setState(() {
              isSheetLarge = selectedMarker == marker;
              selectedMarker = marker;
            });
            _showSheet(marker);
          },
          icon: pinLocationIcon));
    }
    getUserCurrentLocation().then((value) {
      myLocation = PointLatLng(value.latitude, value.longitude);
      _markers.add(Marker(
          markerId: MarkerId('value'),
          position: LatLng(value.latitude, value.longitude)));
    });
    setState(() {});
  }

// getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

// Drawing route goto point on map
  Future<void> getPolyline(MarkerModel marker) async {
    PointLatLng destination =
        PointLatLng(marker.position.latitude, marker.position.longitude);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey, myLocation, destination,
        travelMode: TravelMode.driving);
    polylines.clear();
    polylineCoordinates.clear();
    polylinePoints = PolylinePoints();
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppTheme.colorApp,
      width: 8,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;

    mapController
        .animateCamera(CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(myLocation.latitude, myLocation.longitude),
              northeast: marker.position,
            ),
            50))
        .then((value) {});
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
        body: Builder(builder: (BuildContext ctx) {
          _scaffoldCtx = ctx;
          return SafeArea(
              child: Stack(children: [
            GoogleMap(
              onMapCreated: (controller) {
                onMapCreated(controller, context);
              },
              markers: _markers,
              polylines: Set.of(polylines.values),
              mapToolbarEnabled: false,
              initialCameraPosition:
                  CameraPosition(target: center1, zoom: 15.5, tilt: 20.0),
            ),
          ]));
        }),
        floatingActionButton: isSheetLarge
            ? FloatingActionButton(
                heroTag: "fab",
                mini: true,
                backgroundColor: AppTheme.colorApp,
                elevation: 3,
                child: Icon(Icons.close_rounded,
                    color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  //isSheetLarge = !isSheetLarge;
                  sheetController.close();
                  setState(() {});
                })
            : null);
  }

  void _showSheet(MarkerModel marker) {
    sheetController = showBottomSheet(
        context: _scaffoldCtx,
        builder: (BuildContext bc) {
          return DraggableScrollableSheet(
            minChildSize: 0.0,
            initialChildSize: isSheetLarge ? 0.82 : 0.165,
            maxChildSize: 0.82,
            expand: false,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1.5,
                        color: Colors.grey,
                        blurRadius: 3.0,
                      )
                    ],
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(15)),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  height: double.minPositive,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.vertical,

                        confirmDismiss: (direction) {
                          if (direction == DismissDirection.up) {
                            isSheetLarge = !isSheetLarge;
                            _showSheet(marker);
                          } else {
                            sheetController.close();
                          }
                          setState(() {});
                          return Future.value(
                              false); // always deny the actual dismiss, else it will expect the widget to be removed
                        },
                        child: SizedBox(
                            width: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 2,
                              ),
                              child: Divider(thickness: 5),
                            )),
                      ),
                      Text(
                          textAlign: TextAlign.center,
                          marker.name,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.colorApp,
                              shadows: [
                                Shadow(color: Colors.grey, blurRadius: 2.0)
                              ])),
                      Divider(
                        height: 2.0,
                        color: AppTheme.colorApp,
                        thickness: 1.5,
                      ),
                      //Row(children: [Expanded(child: image)]),
                      isSheetLarge
                          ? Expanded(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5)),
                                    child: marker.image,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      marker.description,
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              icon: Icon(Icons.info,
                                                  color: AppTheme.colorApp,
                                                  size: 50),
                                              actionsPadding: EdgeInsets.all(5),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                      'No estas cerca...'),
                                                  Icon(Icons
                                                      .sentiment_dissatisfied)
                                                ],
                                              ),
                                              content: Text(
                                                'Debes estar cerca de la ubicación ${marker.name} para vivir la experiencia AR',
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                      Container(width: 5),
                                                      Text(
                                                        'Cómo llegar',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    sheetController.close();
                                                    await getPolyline(marker);
                                                    setState(() {});
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(AppTheme
                                                                  .colorApp)),
                                                ),
                                              ]);
                                        },
                                      );

                                      /* getPolyline(marker);
                                  Navigator.pop(context);
                                  sheetController.close();
                                  setState(() {}); */
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        )),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppTheme.colorApp)),
                                    icon: Icon(
                                      size: 35,
                                      Icons.dirty_lens,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Activar AR',
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ])
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  ElevatedButton.icon(
                                      onPressed: () async {
                                        await getPolyline(marker);
                                        setState(() {});
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppTheme.colorApp)),
                                      icon: Icon(
                                        Icons.location_pin,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      label: Text(
                                        'Cómo llegar',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
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
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppTheme.colorApp)),
                                      icon: Icon(
                                        Icons.info_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      label: Text(
                                        'Ver más',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
                                ]),
                      SizedBox(height: 10)
                    ],
                  ));
            },
          );
        });

    sheetController.closed.then((value) {
      // update state to indicate that the sheet is no longer being shown
      setState(() {
        if (isSheetLarge) {
          isSheetLarge = false;
          _showSheet(marker);
        }
      });
    });
  }
}
