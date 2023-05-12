import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaCPAb2VrCXcGoLj2RceqEhQrHgxNnm8o',
    appId: '1:30362615042:android:30d8d051581f8ee47b961b',
    messagingSenderId: '30362615042',
    projectId: 'guatappe-com',
    storageBucket: 'guatappe-com.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD325RWf-lmMjBUX-qhHeqEGps33rQhocg',
    appId: '1:30362615042:ios:4ea928fa7a8617a57b961b',
    messagingSenderId: '30362615042',
    projectId: 'guatappe-com',
    storageBucket: 'guatappe-com.appspot.com',
    iosClientId:
        '30362615042-kag0pr7qkflf4ejn2t0olmmass02hiqv.apps.googleusercontent.com',
    iosBundleId: 'com.example.guatappe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD325RWf-lmMjBUX-qhHeqEGps33rQhocg',
    appId: '1:30362615042:ios:4ea928fa7a8617a57b961b',
    messagingSenderId: '30362615042',
    projectId: 'guatappe-com',
    storageBucket: 'guatappe-com.appspot.com',
    iosClientId:
        '30362615042-kag0pr7qkflf4ejn2t0olmmass02hiqv.apps.googleusercontent.com',
    iosBundleId: 'com.example.guatappe',
  );
}
