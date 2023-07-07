import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:guatappe/domain/entities/user_entity.dart';
import 'package:guatappe/presentation/providers/initial_loading_provider.dart';
import 'package:guatappe/presentation/providers/providers.dart';
import 'package:guatappe/presentation/screens/screens.dart';
import 'package:guatappe/presentation/widgets/full_screen_loader.dart';
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
  List<MarkerEntity> markers = [];
  late LatLng initialMapCenter;
  MarkerEntity? selectedMarker;
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
  String distance = '';
  UserEntity? userData;

  @override
  void initState() {
    getUserData();
    initialMapCenter = ref.read(initialCenterProvider);
    rootBundle.loadString('assets/map_style.json').then((string) {
      mapStyle = string;
    });
    setCustomMapPin();
    scrollController = ScrollController();
    panelController = PanelController();
    ref.read(userCurrentLocationProvider.notifier).getUserCurrentLocation();
    super.initState();
  }

  void getUserData() async {
    userData = await ref.read(userDataProvider);
    markers = await ref.read(markersListProvider);
    setState(() {});
  }

  Future<MarkerEntity> getMarkerImages(MarkerEntity marker) async {
    return await ref.watch(markerRepositoryProvider).getMarkerImages(marker);
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
  void onMapCreated(GoogleMapController controller) async {
    markers = await ref.read(markersListProvider);
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
          onTap: () async {
            if (selectedMarker == marker) {
              selectedMarker = await getMarkerImages(marker);
              panelController.open();
            } else {
              selectedMarker = marker;
              selectedMarker = await getMarkerImages(marker);
              setState(() {});
            }
          },
          icon: pinLocationIcon));
    }
    setState(() {});
    Timer(
        const Duration(milliseconds: 800),
        () => mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: initialMapCenter,
                zoom: 16.5,
                tilt: 70.0,
                bearing: 110))));
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
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
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    distance = totalDistance < 1
        ? (totalDistance * 1000).round().toString() + ' mts.'
        : totalDistance.toStringAsFixed(2) + ' Kms.';
    LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(minLat, minLong), northeast: LatLng(maxLat, maxLong));
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      consumeTapEvents: true,
      onTap: () {
        mapController.animateCamera(cameraUpdate);
        mapController.showMarkerInfoWindow(MarkerId('Distance'));
      },
      polylineId: id,
      color: AppTheme.colorApp,
      width: 8,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;
    mapController.animateCamera(cameraUpdate);
    _markers.add(Marker(
        markerId: MarkerId('Distance'),
        alpha: 0,
        infoWindow: InfoWindow(
            title: 'Distancia: $distance',
            anchor: Offset(0.5, 0.9),
            onTap: () {
              panelController.open();
            }),
        position:
            polylineCoordinates[(polylineCoordinates.length / 2).floor()]));
    setState(() {});
    Timer(Duration(milliseconds: 150),
        () => mapController.showMarkerInfoWindow(MarkerId('Distance')));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    return Scaffold(
      body: Container(
        color: AppTheme.colorApp,
        child: SafeArea(
          child: Material(
            color: AppTheme.colorApp,
            child: Stack(
              children: [
                SlidingUpPanel(
                  body: Container(
                    margin: EdgeInsets.only(
                        bottom: size.height - size.height * 0.85),
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
                  parallaxEnabled: true,
                  parallaxOffset: 0.45,
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
                  maxHeight: size.height * 0.84,
                  footer: Footer(
                      isPanelClosed: isPanelClosed,
                      getPolyline: getPolyline,
                      selectedMarker: selectedMarker,
                      panelController: panelController),
                  onPanelClosed: () => setState(() {
                    isPanelClosed = true;
                  }),
                  onPanelOpened: () {
                    setState(() {
                      isPanelClosed = false;
                    });
                    if (scrollController.offset > 0)
                      scrollController.animateTo(2,
                          duration: Duration(milliseconds: 350),
                          curve: Curves.fastOutSlowIn);
                  },
                ),
                _PositionedPanel(
                    isPanelClosed: isPanelClosed,
                    panelController: panelController)
              ],
            ),
          ),
        ),
      ),
      endDrawer: _Drawer(userData),
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

class _Drawer extends ConsumerWidget {
  final UserEntity? userData;
  const _Drawer(this.userData);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: AppTheme.colorApp),
          accountName: Text('${userData?.name} ${userData?.lastName}'),
          accountEmail: Text(
            '${userData?.email}',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          currentAccountPicture: Image.asset('assets/logo/logo_guatappe.png'),
        ),
        ExpansionTile(
          childrenPadding: EdgeInsets.only(left: 16),
          leading: Icon(Icons.route),
          title: Text("Explorar Rutas"),
          children: [
            ListTile(
              onTap: () {
                context.pop();
              },
              leading: Icon(Icons.emoji_nature_outlined),
              title: Text('Naturaleza'),
            ),
            ListTile(
              leading: Icon(Icons.meeting_room_outlined),
              title: Text('Historia'),
            ),
            ListTile(
              leading: Icon(Icons.keyboard_command_key_sharp),
              title: Text('Cultura'),
            ),
            ListTile(
              leading: Icon(Icons.sports_handball_sharp),
              title: Text('Diversión'),
            )
          ],
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text('Mi Cuenta'),
          onTap: () => showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: '',
              pageBuilder: (BuildContext context, a1, a2) {
                return Container();
              },
              transitionBuilder: (context, a1, a2, child) {
                return FadeTransition(
                  opacity: a1,
                  child: RegisterScreen(user: userData!),
                );
              }),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Mis Favoritos'),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Salir'),
          onTap: () async {
            await ref.read(authRepositoryProvider).signOut();
            context.goNamed(LoginScreen.name);
          },
        ),
      ],
    ));
  }
}
