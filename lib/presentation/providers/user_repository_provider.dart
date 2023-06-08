import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/infrastructure/datasources/user_datasource_impl.dart';
import 'package:guatappe/infrastructure/repositories/user_repository_impl.dart';
import 'package:guatappe/presentation/providers/firebase_provider.dart';

//repositorio inmutable
final userRepositoryProvider = Provider((ref) {
  final _firebaseFiretore = ref.watch(firebaseFirestoreProvider);
  return UserRepositoryImpl(UserDataSourceImpl(_firebaseFiretore));
});
