import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/infrastructure/datasources/auth_firebase_datasource_impl.dart';
import 'package:guatappe/presentation/providers/firebase_provider.dart';
import 'package:guatappe/infrastructure/repositories/auth_firebase_repository_impl.dart';

//repositorio inmutable
final authRepositoryProvider = Provider((ref) {
  final _firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthFirebaseRepositoryImpl(AuthFirebaseDataSourceImpl(_firebaseAuth));
});
