import '../entities/marker_entity.dart';

abstract class MarkersRepository {
  Future<List<MarkerEntity>> getMarkersList();
}
