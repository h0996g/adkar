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
    apiKey: 'AIzaSyArWUI-2HbYqZP5TgH1jc1BUzeagxB-DSU',
    appId: '1:835096401918:web:d589629eb6bc92842dd2af',
    messagingSenderId: '835096401918',
    projectId: 'quran-28f24',
    authDomain: 'quran-28f24.firebaseapp.com',
    storageBucket: 'quran-28f24.appspot.com',
    measurementId: 'G-VT4F4Z8F51',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSNczzZZNC9pmDy8WrVwaLy0dgig5FU_o',
    appId: '1:835096401918:android:d2b89b270cf239432dd2af',
    messagingSenderId: '835096401918',
    projectId: 'quran-28f24',
    storageBucket: 'quran-28f24.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC72ixAkKFMjyaDRZ3YtcDg1kM4rlgt-hk',
    appId: '1:835096401918:ios:75d49d6b8c5fe8332dd2af',
    messagingSenderId: '835096401918',
    projectId: 'quran-28f24',
    storageBucket: 'quran-28f24.appspot.com',
    iosBundleId: 'com.h0774g.alhou',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC72ixAkKFMjyaDRZ3YtcDg1kM4rlgt-hk',
    appId: '1:835096401918:ios:75d49d6b8c5fe8332dd2af',
    messagingSenderId: '835096401918',
    projectId: 'quran-28f24',
    storageBucket: 'quran-28f24.appspot.com',
    iosBundleId: 'com.h0774g.alhou',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBzzpnpDD4uMY1bTWnXl8Z9biDpaukDQss',
    appId: '1:835096401918:web:a1838a87e48756692dd2af',
    messagingSenderId: '835096401918',
    projectId: 'quran-28f24',
    authDomain: 'quran-28f24.firebaseapp.com',
    storageBucket: 'quran-28f24.appspot.com',
    measurementId: 'G-751BNLGXZC',
  );

}