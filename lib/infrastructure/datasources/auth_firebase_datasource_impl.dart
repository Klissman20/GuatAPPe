import 'package:firebase_auth/firebase_auth.dart';
import 'package:guatappe/domain/datasources/auth_firebase_datasource.dart';

class AuthFirebaseDataSourceImpl extends AuthFirebaseDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthFirebaseDataSourceImpl(this._firebaseAuth);

  @override
  Future<Map<String, dynamic>> signUp(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return {
        'user': (response.user),
        'state': 'ok',
        'uid': (response.user!.uid)
      };
    } on FirebaseAuthException catch (e) {
      return {'user': null, 'state': 'failed', 'error': e};
    }
  }

  @override
  Future<Map<String, dynamic>> signIn(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {'user': (response.user), 'state': 'ok'};
    } on FirebaseAuthException catch (e) {
      return {'user': null, 'state': 'failed', 'error': e};
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Future<Either<String, User>> continueWithGoogle() async {
  //   try {
  //     final googleSignIn =
  //         GoogleSignIn(clientId: DefaultFirebaseOptions.ios.iosClientId);
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       final response = await _firebaseAuth.signInWithCredential(credential);
  //       return right(response.user!);
  //     } else {
  //       return left('Unknown Error');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return left(e.message ?? 'Unknow Error');
  //   }
  // }
}
