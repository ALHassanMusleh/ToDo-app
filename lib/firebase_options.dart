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
    apiKey: 'AIzaSyCGzHXTh1b9_LvYUEcy6MXy0ALnjBluCXk',
    appId: '1:1066555201803:web:14f4bde7c4ede10c106a0e',
    messagingSenderId: '1066555201803',
    projectId: 'todo-app-b086b',
    authDomain: 'todo-app-b086b.firebaseapp.com',
    storageBucket: 'todo-app-b086b.appspot.com',
    measurementId: 'G-GWV7NZM5D7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAknZM--EOadxt6dUQTEknK-6KYS3-EeEY',
    appId: '1:1066555201803:android:cfa48c9228f15cb8106a0e',
    messagingSenderId: '1066555201803',
    projectId: 'todo-app-b086b',
    storageBucket: 'todo-app-b086b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApFYJ79Sa2D6PQDk0IdEjY7_3uXtj8S-Q',
    appId: '1:1066555201803:ios:46dce8a237cd50c6106a0e',
    messagingSenderId: '1066555201803',
    projectId: 'todo-app-b086b',
    storageBucket: 'todo-app-b086b.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyApFYJ79Sa2D6PQDk0IdEjY7_3uXtj8S-Q',
    appId: '1:1066555201803:ios:46dce8a237cd50c6106a0e',
    messagingSenderId: '1066555201803',
    projectId: 'todo-app-b086b',
    storageBucket: 'todo-app-b086b.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCGzHXTh1b9_LvYUEcy6MXy0ALnjBluCXk',
    appId: '1:1066555201803:web:f178e452696d2067106a0e',
    messagingSenderId: '1066555201803',
    projectId: 'todo-app-b086b',
    authDomain: 'todo-app-b086b.firebaseapp.com',
    storageBucket: 'todo-app-b086b.appspot.com',
    measurementId: 'G-H8L1C44KE0',
  );
}
