import 'dart:io';
import 'package:guatappe/presentation/widgets/widgets.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
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
  final SolidController sheetController = SolidController();
  bool showSheet = false;
  bool isSheetLarge = false;

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
  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    controller.setMapStyle(mapStyle);
    for (final marker in markers) {
      _markers.add(Marker(
          markerId: MarkerId(marker.name),
          position: marker.position,
          infoWindow: InfoWindow(
            title: marker.name,
            onTap: () {
                sheetController.height = 500;
            },
          ),
          onTap: () {
            setState(() {
              isSheetLarge = selectedMarker == marker;
              selectedMarker = marker;
            });
          },
          icon: pinLocationIcon));
    }
    getUserCurrentLocation();
    setState(() {});
  }

// getting user current location
  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    await Geolocator.getCurrentPosition().then((position) {
      myLocation = PointLatLng(position.latitude, position.longitude);
      if (_markers.contains(Marker(markerId: MarkerId('MyLocation')))) {
        _markers.remove(Marker(markerId: MarkerId('MyLocation')));
      }
      _markers.add(Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          markerId: MarkerId('MyLocation'),
          position: LatLng(position.latitude, position.longitude)));

      setState(() {});
    });
  }

// Drawing route goto point on map
  Future<void> getPolyline(MarkerModel marker) async {
    PointLatLng destination =
        PointLatLng(marker.position.latitude, marker.position.longitude);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey, myLocation, destination,
        travelMode: TravelMode.walking);
    polylines.clear();
    polylineCoordinates.clear();
    double minLat = 0;
    double minLong = 0;
    double maxLat = 0;
    double maxLong = 0;
    if (result.points.isNotEmpty) {
      minLat = result.points.first.latitude;
      minLong = result.points.first.longitude;
      maxLat = result.points.first.latitude;
      maxLong = result.points.first.longitude;
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      }
    }
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      consumeTapEvents: true,
      onTap: () => mapController.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(minLat, minLong),
              northeast: LatLng(maxLat, maxLong)),
          50)),
      polylineId: id,
      color: AppTheme.colorApp,
      width: 8,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;

    mapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        50));
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
        return SafeArea(
            child: GoogleMap(
          myLocationEnabled: true,
          onMapCreated: onMapCreated,
          markers: _markers,
          polylines: Set.of(polylines.values),
          mapToolbarEnabled: false,
          initialCameraPosition:
              CameraPosition(target: initialMapCenter, zoom: 15.5, tilt: 20.0),
        ));
      }),
      bottomSheet: SolidBottomSheet(
        controller: sheetController,
        toggleVisibilityOnTap: true,
        showOnAppear: false,
        elevation: 2.5,
        headerBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(3)),
                height: 5,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  selectedMarker.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.grey, blurRadius: 2.0)]),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              child: selectedMarker.image,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedMarker.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ]),
        )),
        smoothness: Smoothness.low,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                width: 0.4,
                buttonText: "Cómo llegar",
                onTap: () async {
                  await getPolyline(selectedMarker);
                  setState(() {});
                }),
            CustomButton(
              width: 0.4,
              buttonText: 'Ver más',
              onTap: () {
                sheetController.height = 500;
              },
            )
          ],
        ),
      ),
    );
  }
}
