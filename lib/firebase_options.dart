// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAIDSjgg0vMXMpquml2DwMo1dpCmfq4fv0',
    appId: '1:931238830014:web:1c617c799fdc100f2fe3ef',
    messagingSenderId: '931238830014',
    projectId: 'chec-events-584ad',
    authDomain: 'chec-events-584ad.firebaseapp.com',
    storageBucket: 'chec-events-584ad.appspot.com',
    measurementId: 'G-XKCDMFPVFF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwq8Nvf0afcgsrykOfqjJIv7_vTwNbZ0E',
    appId: '1:931238830014:android:a6960f9e8e77772d2fe3ef',
    messagingSenderId: '931238830014',
    projectId: 'chec-events-584ad',
    storageBucket: 'chec-events-584ad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAz_RmBr0x2AuLfcthIwh0dZ2oa6YRII_Y',
    appId: '1:931238830014:ios:db3589b9de8cbcf02fe3ef',
    messagingSenderId: '931238830014',
    projectId: 'chec-events-584ad',
    storageBucket: 'chec-events-584ad.appspot.com',
    iosBundleId: 'com.example.eventsDashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAz_RmBr0x2AuLfcthIwh0dZ2oa6YRII_Y',
    appId: '1:931238830014:ios:db3589b9de8cbcf02fe3ef',
    messagingSenderId: '931238830014',
    projectId: 'chec-events-584ad',
    storageBucket: 'chec-events-584ad.appspot.com',
    iosBundleId: 'com.example.eventsDashboard',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAIDSjgg0vMXMpquml2DwMo1dpCmfq4fv0',
    appId: '1:931238830014:web:1c617c799fdc100f2fe3ef',
    messagingSenderId: '931238830014',
    projectId: 'chec-events-584ad',
    authDomain: 'chec-events-584ad.firebaseapp.com',
    storageBucket: 'chec-events-584ad.appspot.com',
    measurementId: 'G-XKCDMFPVFF',
  );

}