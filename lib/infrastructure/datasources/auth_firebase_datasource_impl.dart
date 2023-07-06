import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guatappe/config/helpers/firebase_options.dart';
import 'package:guatappe/domain/datasources/auth_firebase_datasource.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  Future<Map<String, dynamic>> continueWithGoogle() async {
    try {
      GoogleSignIn googleSignIn;
      if (Platform.isAndroid) {
        googleSignIn = GoogleSignIn(
            clientId: DefaultFirebaseOptions.currentPlatform.androidClientId);
      } else {
        googleSignIn = GoogleSignIn(
            clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);
      }

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);
        final _user = response.user;
        assert(_user?.isAnonymous == false);
        assert(await _user?.getIdToken() != null);
        return {
          'user': (googleUser),
          'state': 'ok',
          'uid': (response.user!.uid)
        };
      } else {
        return {'user': null, 'state': 'failed', 'error': 'unknow'};
      }
    } on FirebaseAuthException catch (e) {
      return {'user': null, 'state': 'failed', 'error': e};
    }
  }

  @override
  Future<Map<String, dynamic>> continueWithApple() async {
    final redirectURL =
        'https://northern-jasper-racer.glitch.me/callbacks/sign_in_with_apple';
    // final redirectURL = 'https://guatappe-com.firebaseapp.com/__/auth/handler';

    final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.tailorsdev.guatappe0',
            redirectUri: Uri.parse(redirectURL)));

    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: appleCredential.identityToken!,
      accessToken: appleCredential.authorizationCode,
    );
    final response = await _firebaseAuth.signInWithCredential(credential);
    final _user = response.user;
    assert(_user?.isAnonymous == false);
    assert(await _user?.getIdToken() != null);
    return {
      'user': (appleCredential),
      'state': 'ok',
      'uid': (response.user!.uid)
    };
  }
}
