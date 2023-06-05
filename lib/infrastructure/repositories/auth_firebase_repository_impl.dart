import 'package:guatappe/domain/datasources/auth_firebase_datasource.dart';
import 'package:guatappe/domain/repositories/auth_firebase_repository.dart';

class AuthFirebaseRepositoryImpl extends AuthFirebaseRepository {
  final AuthFirebaseDataSource datasource;

  AuthFirebaseRepositoryImpl(this.datasource);

  @override
  Future<Map<String, dynamic>> signIn(
      {required String email, required String password}) {
    return datasource.signIn(email: email, password: password);
  }

  @override
  Future<Map<String, dynamic>> signUp(
      {required String email, required String password}) {
    return datasource.signUp(email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return datasource.signOut();
  }

  @override
  Future<Map<String, dynamic>> continueWithGoogle() {
    return datasource.continueWithGoogle();
  }
}
