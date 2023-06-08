import '../entities/marker_entity.dart';

abstract class MarkersDataSource {
  Future<List<MarkerEntity>> getMarkersList();
}
