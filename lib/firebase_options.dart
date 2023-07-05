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
    apiKey: 'AIzaSyCCrB2IO97vkGYJT90Yx_Th5sd0WEQf8ek',
    appId: '1:674427696556:web:b3a3b44a63448eb1577609',
    messagingSenderId: '674427696556',
    projectId: 'lista-compras-14098',
    authDomain: 'lista-compras-14098.firebaseapp.com',
    storageBucket: 'lista-compras-14098.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6tcAE706Qbl4JiX29Iu0PyUBifnSdE_0',
    appId: '1:674427696556:android:fbbeca7cb3a7cd2d577609',
    messagingSenderId: '674427696556',
    projectId: 'lista-compras-14098',
    storageBucket: 'lista-compras-14098.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB633FrnOnS09bLPjlg42HEQ3TBN3CW5BA',
    appId: '1:674427696556:ios:a3d925799f401082577609',
    messagingSenderId: '674427696556',
    projectId: 'lista-compras-14098',
    storageBucket: 'lista-compras-14098.appspot.com',
    iosClientId: '674427696556-t6p637s642vjseteujlv14kt46s6q8jd.apps.googleusercontent.com',
    iosBundleId: 'com.example.listaCompras',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB633FrnOnS09bLPjlg42HEQ3TBN3CW5BA',
    appId: '1:674427696556:ios:a3d925799f401082577609',
    messagingSenderId: '674427696556',
    projectId: 'lista-compras-14098',
    storageBucket: 'lista-compras-14098.appspot.com',
    iosClientId: '674427696556-t6p637s642vjseteujlv14kt46s6q8jd.apps.googleusercontent.com',
    iosBundleId: 'com.example.listaCompras',
  );
}
