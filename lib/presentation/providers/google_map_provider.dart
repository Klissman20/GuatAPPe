import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guatappe/presentation/providers/markers_repository_provider.dart';
import '../../domain/entities/marker_entity.dart';

final markersListProvider = StateProvider((ref) async {
  var markers = await ref.watch(markerRepositoryProvider).getMarkersList();
  return markers;
});

final initialCenterProvider = Provider((ref) {
  final LatLng initialMapCenter = const LatLng(6.233, -75.158);
  return initialMapCenter;
});

final userCurrentLocationProvider =
    StateNotifierProvider<UserLocationNotifier, PointLatLng>((ref) {
  return UserLocationNotifier(ref);
});

class UserLocationNotifier extends StateNotifier<PointLatLng> {
  Ref ref;
  UserLocationNotifier(this.ref) : super(PointLatLng(0, 0));

  Future<void> getUserCurrentLocation() async {
    final markers = await ref.read(markersListProvider);
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    await Geolocator.getCurrentPosition().then((position) {
      final newState = PointLatLng(position.latitude, position.longitude);

      if (markers.contains(Marker(markerId: MarkerId('MyLocation')))) {
        markers.remove(Marker(markerId: MarkerId('MyLocation')));
      }
      markers.add(MarkerEntity(
          position: LatLng(position.latitude, position.longitude),
          id: "",
          name: 'myLocation',
          description: 'myLoc',
          latitude: position.latitude,
          longitude: position.longitude));

      state = newState;
    });
  }
}
