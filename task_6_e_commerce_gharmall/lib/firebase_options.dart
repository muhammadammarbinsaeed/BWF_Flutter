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
    apiKey: 'AIzaSyAF3EduJc8G8sLHKXbeAUhk8z1NIS3h6dM',
    appId: '1:311197704558:web:f5f3fe4fae3a849cd9a17f',
    messagingSenderId: '311197704558',
    projectId: 'e-commerceapp-6d3cd',
    authDomain: 'e-commerceapp-6d3cd.firebaseapp.com',
    storageBucket: 'e-commerceapp-6d3cd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLztCrijfFLcjhSU-eIyxe7EJL6Jjfy7Q',
    appId: '1:311197704558:android:72588343381f0327d9a17f',
    messagingSenderId: '311197704558',
    projectId: 'e-commerceapp-6d3cd',
    storageBucket: 'e-commerceapp-6d3cd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKYXUYXa3CEzY8yO2mWSoNDPU1DtM6H10',
    appId: '1:311197704558:ios:2280c62d8261fae4d9a17f',
    messagingSenderId: '311197704558',
    projectId: 'e-commerceapp-6d3cd',
    storageBucket: 'e-commerceapp-6d3cd.appspot.com',
    iosBundleId: 'com.example.task6ECommerceGharmall',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKYXUYXa3CEzY8yO2mWSoNDPU1DtM6H10',
    appId: '1:311197704558:ios:2280c62d8261fae4d9a17f',
    messagingSenderId: '311197704558',
    projectId: 'e-commerceapp-6d3cd',
    storageBucket: 'e-commerceapp-6d3cd.appspot.com',
    iosBundleId: 'com.example.task6ECommerceGharmall',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAF3EduJc8G8sLHKXbeAUhk8z1NIS3h6dM',
    appId: '1:311197704558:web:8fc75e114006a9abd9a17f',
    messagingSenderId: '311197704558',
    projectId: 'e-commerceapp-6d3cd',
    authDomain: 'e-commerceapp-6d3cd.firebaseapp.com',
    storageBucket: 'e-commerceapp-6d3cd.appspot.com',
  );
}
