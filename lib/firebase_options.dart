// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCj37bQPItZeasnpXTqhGbxNoxGZ5TxQCQ',
    appId: '1:594441871055:web:b5715d66c012331188a1ba',
    messagingSenderId: '594441871055',
    projectId: 'fit-generation-app',
    authDomain: 'fit-generation-app.firebaseapp.com',
    storageBucket: 'fit-generation-app.appspot.com',
    measurementId: 'G-F2BB1TVRWW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA304FsZ29v0Hx5iLRrp1pqHR4F0YxnEOE',
    appId: '1:594441871055:android:31c2ce96f24ed23288a1ba',
    messagingSenderId: '594441871055',
    projectId: 'fit-generation-app',
    storageBucket: 'fit-generation-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_ydyWB25xyE-SNlPg4W_cNf34RZU7vr8',
    appId: '1:594441871055:ios:7b01abdb42f7856d88a1ba',
    messagingSenderId: '594441871055',
    projectId: 'fit-generation-app',
    storageBucket: 'fit-generation-app.appspot.com',
    androidClientId: '594441871055-5fvt20fvr1lhatbvi9pm7j0cnd38brmu.apps.googleusercontent.com',
    iosClientId: '594441871055-7rjveiutj8i54to4pamvfft7agsfrqtm.apps.googleusercontent.com',
    iosBundleId: 'app.fitgeneration.fitGeneration',
  );
}
