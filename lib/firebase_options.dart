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
    apiKey: 'AIzaSyAI8WcGWLRPGeba7QOR0dDy_N8ngwzfCHg',
    appId: '1:996912599316:web:670d7eaff5fb0ad83e3201',
    messagingSenderId: '996912599316',
    projectId: 'dnd-chat-app-ffaa6',
    authDomain: 'dnd-chat-app-ffaa6.firebaseapp.com',
    storageBucket: 'dnd-chat-app-ffaa6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKk3nSHsJjGA1Wb4bmXlbnlQwanPafBoI',
    appId: '1:996912599316:android:4c73b6625616f04f3e3201',
    messagingSenderId: '996912599316',
    projectId: 'dnd-chat-app-ffaa6',
    storageBucket: 'dnd-chat-app-ffaa6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmwbER7mPXFRv5m9pGaCUYgK5m3pKl8BA',
    appId: '1:996912599316:ios:651255e0026e56c43e3201',
    messagingSenderId: '996912599316',
    projectId: 'dnd-chat-app-ffaa6',
    storageBucket: 'dnd-chat-app-ffaa6.appspot.com',
    iosClientId: '996912599316-q69897ommm0ogs0k778js7rbk8dlumgs.apps.googleusercontent.com',
    iosBundleId: 'com.example.dndChatApp',
  );
}