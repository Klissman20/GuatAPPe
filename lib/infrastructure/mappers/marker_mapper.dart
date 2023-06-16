import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';

class MarkerMapper {
  static MarkerEntity markerFirebaseToEntity(MarkerModel markerfb) =>
      MarkerEntity(
          id: markerfb.id,
          name: markerfb.name,
          description: markerfb.description,
          position: LatLng(markerfb.latitude, markerfb.longitude),
          latitude: markerfb.latitude,
          longitude: markerfb.longitude,
          imageList: List.empty(growable: true));
}
