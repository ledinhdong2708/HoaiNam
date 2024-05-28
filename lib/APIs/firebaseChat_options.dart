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
class DefaultChatFirebaseOptions {
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
    apiKey: 'AIzaSyDXJ58S6fkTvhNLmskBoQPXt3rNbRY0ftg',
    appId: '1:900299798438:web:06d6ad94fb82d69a700167',
    messagingSenderId: '900299798438',
    projectId: 'groupchatfirebase-ca4c6',
    authDomain: 'groupchatfirebase-ca4c6.firebaseapp.com',
    storageBucket: 'groupchatfirebase-ca4c6.appspot.com',
    measurementId: 'G-4J4FYKL3SF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM7dSwZkvkJnjd-BQUyp_6K2yT5CYzR4k',
    appId: '1:900299798438:android:14ffc7a29bbd8b8b700167',
    messagingSenderId: '900299798438',
    projectId: 'groupchatfirebase-ca4c6',
    storageBucket: 'groupchatfirebase-ca4c6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACu0EEyL9t4Vs7ZubcGrTMYhQNOVdQR7o',
    appId: '1:900299798438:ios:e0d77806b1b03228700167',
    messagingSenderId: '900299798438',
    projectId: 'groupchatfirebase-ca4c6',
    storageBucket: 'groupchatfirebase-ca4c6.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACu0EEyL9t4Vs7ZubcGrTMYhQNOVdQR7o',
    appId: '1:900299798438:ios:e0d77806b1b03228700167',
    messagingSenderId: '900299798438',
    projectId: 'groupchatfirebase-ca4c6',
    storageBucket: 'groupchatfirebase-ca4c6.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXJ58S6fkTvhNLmskBoQPXt3rNbRY0ftg',
    appId: '1:900299798438:web:17f2e96c19abfa52700167',
    messagingSenderId: '900299798438',
    projectId: 'groupchatfirebase-ca4c6',
    authDomain: 'groupchatfirebase-ca4c6.firebaseapp.com',
    storageBucket: 'groupchatfirebase-ca4c6.appspot.com',
    measurementId: 'G-ML93EKVNV8',
  );
}