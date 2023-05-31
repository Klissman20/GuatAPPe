import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:guatappe/presentation/providers/google_map_provider.dart';
import 'package:guatappe/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guatappe/config/constants/environment.dart';
import 'package:guatappe/config/theme/app_theme.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class MapScreen extends ConsumerStatefulWidget {
  static const String name = 'map_screen';
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
// Google Maps & Markers
  late String mapStyle;
  late BitmapDescriptor pinLocationIcon;
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  late List<MarkerEntity> markers;
  late LatLng initialMapCenter;
  late MarkerEntity selectedMarker = markers[0];
  String googleAPiKey = Environment.googleMapApiKey;
  final GlobalKey<ScaffoldState> key = GlobalKey();

// Draw Route GoTo Point
  late PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

// Slide Up Panel
  late final ScrollController scrollController;
  late final PanelController panelController;
  bool isPanelClosed = true;

  @override
  void initState() {
    ref.read(userCurrentLocationProvider.notifier).getUserCurrentLocation();
    markers = ref.read(markersListProvider);
    initialMapCenter = ref.read(initialCenterProvider);
    rootBundle.loadString('assets/map_style.json').then((string) {
      mapStyle = string;
    });
    setCustomMapPin();
    scrollController = ScrollController();
    panelController = PanelController();
    super.initState();
  }

  void setCustomMapPin() async {
    if (Platform.isIOS) {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/logo/icono_40x40.png');
    } else if (Platform.isAndroid) {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/icono.png');
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
              panelController.open();
            },
          ),
          onTap: () {
            if (selectedMarker == marker)
              panelController.open();
            else
              setState(() {
                selectedMarker = marker;
              });
          },
          icon: pinLocationIcon));
    }
    setState(() {});
    Timer(
        const Duration(milliseconds: 1500),
        () => mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: initialMapCenter,
                zoom: 16.5,
                tilt: 70.0,
                bearing: 110))));
  }

// Drawing route goto point on map
  Future<void> getPolyline(MarkerEntity marker) async {
    ref.read(userCurrentLocationProvider.notifier).getUserCurrentLocation();
    final myLocation = ref.read(userCurrentLocationProvider);
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Material(
          child: Stack(
            children: [
              SlidingUpPanel(
                body: Container(
                  margin: EdgeInsets.only(
                      bottom: size.height - size.height * 0.835),
                  color: Colors.white,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    onMapCreated: onMapCreated,
                    markers: _markers,
                    polylines: Set.of(polylines.values),
                    mapToolbarEnabled: false,
                    initialCameraPosition:
                        CameraPosition(target: initialMapCenter, zoom: 13),
                  ),
                ),
                controller: panelController,
                scrollController: scrollController,
                header: Header(selectedMarker: selectedMarker),
                backdropEnabled: true,
                backdropOpacity: 0.4,
                panelBuilder: () => Panel(
                  selectedMarker: selectedMarker,
                  scrollController: scrollController,
                  isPanelClosed: isPanelClosed,
                  panelController: panelController,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                maxHeight: size.height * 0.85,
                footer: Footer(
                    isPanelClosed: isPanelClosed,
                    getPolyline: getPolyline,
                    selectedMarker: selectedMarker,
                    panelController: panelController),
                onPanelSlide: (double pos) {
                  if (pos == 0)
                    setState(() {
                      isPanelClosed = true;
                    });
                  else if (pos == 1) {
                    setState(() {
                      isPanelClosed = false;
                    });
                    if (scrollController.offset > 0)
                      scrollController.animateTo(2,
                          duration: Duration(milliseconds: 350),
                          curve: Curves.fastOutSlowIn);
                  }
                },
              ),
              _PositionedPanel(
                  isPanelClosed: isPanelClosed,
                  panelController: panelController)
            ],
          ),
        ),
      ),
      endDrawer: _Drawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      floatingActionButton: _MenuFloatingButton(),
    );
  }
}

class _MenuFloatingButton extends StatelessWidget {
  const _MenuFloatingButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'fab2',
      backgroundColor: AppTheme.colorApp,
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
      mini: true,
      child: Icon(Icons.menu, color: Colors.white),
    );
  }
}

class _PositionedPanel extends StatelessWidget {
  const _PositionedPanel({
    required this.isPanelClosed,
    required this.panelController,
  });

  final bool isPanelClosed;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 10,
        bottom: MediaQuery.of(context).size.height * 0.82,
        child: AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 250),
          width: isPanelClosed ? 0 : 45,
          height: isPanelClosed ? 0 : 40,
          child: _CloseFloatingButton(
              panelController: panelController, isPanelClosed: isPanelClosed),
        ));
  }
}

class _CloseFloatingButton extends StatelessWidget {
  const _CloseFloatingButton({
    super.key,
    required this.panelController,
    required this.isPanelClosed,
  });

  final PanelController panelController;
  final bool isPanelClosed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppTheme.colorApp,
      onPressed: () {
        panelController.close();
      },
      elevation: 3,
      shape: const CircleBorder(),
      mini: true,
      child: Icon(
        Icons.close_rounded,
        size: isPanelClosed ? 0 : 28,
        color: Colors.white,
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('David Román'),
          accountEmail: Text(
            'roman.david@gmail.com',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          currentAccountPicture: Image.asset('assets/logo/logo_guatappe.png'),
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text('Mi Cuenta'),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Mis Favoritos'),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Salir'),
        ),
      ],
    ));
  }
}
