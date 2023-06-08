import 'package:guatappe/domain/datasources/markers_datasource.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:guatappe/domain/repositories/markers_repository.dart';

class MarkerRepositoryImpl extends MarkersRepository {
  final MarkersDataSource datasource;

  MarkerRepositoryImpl(this.datasource);

  @override
  Future<List<MarkerEntity>> getMarkersList() {
    return datasource.getMarkersList();
  }
}
