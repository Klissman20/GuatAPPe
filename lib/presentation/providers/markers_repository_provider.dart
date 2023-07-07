import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/infrastructure/datasources/marker_datasource_impl.dart';
import 'package:guatappe/infrastructure/repositories/marker_repository_impl.dart';
import 'package:guatappe/presentation/providers/firebase_provider.dart';

//repositorio inmutable
final markerRepositoryProvider = Provider((ref) {
  final _firebaseFiretore = ref.watch(firebaseFirestoreProvider);
  final _firebaseStorage = ref.watch(firebaseStorageProvider);
  return MarkerRepositoryImpl(MarkerDataSourceImpl(
      firebaseFirestore: _firebaseFiretore, firebaseStorage: _firebaseStorage));
});
