import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/infrastructure/datasources/marker_datasource_impl.dart';
import 'package:guatappe/infrastructure/repositories/marker_repository_impl.dart';

//repositorio inmutable
final markerRepositoryProvider = Provider((ref) {
  return MarkerRepositoryImpl(MarkerDataSourceImpl());
});
