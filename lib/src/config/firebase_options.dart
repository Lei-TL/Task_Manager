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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBtBG7hnxMzqTkBoTz9nbYRDT_1oEyrC7c",
    authDomain: "task-manager-115d0.firebaseapp.com",
    projectId: "task-manager-115d0",
    storageBucket: "task-manager-115d0.firebasestorage.app",
    messagingSenderId: "41817558476",
    appId: "1:41817558476:web:daeae3b927a2a5e142a169",
    measurementId: "G-NJW6253C4E",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBtBG7hnxMzqTkBoTz9nbYRDT_1oEyrC7c",
    appId:
        "1:41817558476:android:daeae3b927a2a5e142a169", // Giả định dựa trên web ID
    messagingSenderId: "41817558476",
    projectId: "task-manager-115d0",
    storageBucket: "task-manager-115d0.firebasestorage.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
    iosBundleId: 'com.qly.qly',
  );
}
