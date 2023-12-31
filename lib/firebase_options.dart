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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCWrOzkwUCUmRZZpaOCkGnhfTsYgo99c18',
    appId: '1:808233820484:web:dbbc3496187f3bfcbff711',
    messagingSenderId: '808233820484',
    projectId: 'noderestapi-542f5',
    authDomain: 'noderestapi-542f5.firebaseapp.com',
    storageBucket: 'noderestapi-542f5.appspot.com',
    measurementId: 'G-NV831SY5VH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYg8EP-QT_DldHs1blsqAgpmdo87_SOmc',
    appId: '1:808233820484:android:1a4b95a02d09c029bff711',
    messagingSenderId: '808233820484',
    projectId: 'noderestapi-542f5',
    storageBucket: 'noderestapi-542f5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCJ5O5Phx2pKfffms4AI3h-QZ05QnFuaY',
    appId: '1:808233820484:ios:ac9eb997a289bee0bff711',
    messagingSenderId: '808233820484',
    projectId: 'noderestapi-542f5',
    storageBucket: 'noderestapi-542f5.appspot.com',
    iosClientId: '808233820484-dtddh3mt76vi7e734jnaa43f8v7t3usk.apps.googleusercontent.com',
    iosBundleId: 'com.example.servicesJoined',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCJ5O5Phx2pKfffms4AI3h-QZ05QnFuaY',
    appId: '1:808233820484:ios:ac9eb997a289bee0bff711',
    messagingSenderId: '808233820484',
    projectId: 'noderestapi-542f5',
    storageBucket: 'noderestapi-542f5.appspot.com',
    iosClientId: '808233820484-dtddh3mt76vi7e734jnaa43f8v7t3usk.apps.googleusercontent.com',
    iosBundleId: 'com.example.servicesJoined',
  );
}
