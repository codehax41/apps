// shared/config/firebase_options.dart
// Configured for Daivant AI Astrology (Google Android + Apple iOS)

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  // Google Android Target Options
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBakS4P7qvDNXvsJg8tixW9u1wF8jmMrtQ',
    appId: '1:119282080665:android:0bbc688c5f56422dcf1108',
    messagingSenderId: '119282080665',
    projectId: 'daivant-ai-astrology',
    storageBucket: 'daivant-ai-astrology.firebasestorage.app',
  );

  // Apple iOS Target Options
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6r309dJS-zlh9-jPSInYDbGy6CDpvLpY',
    appId: '1:119282080665:ios:9912c9812a85ab83cf1108',
    messagingSenderId: '119282080665',
    projectId: 'daivant-ai-astrology',
    storageBucket: 'daivant-ai-astrology.firebasestorage.app',
    iosBundleId: 'com.astroai.quantum',
  );

  // Web Fallback Target Options
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBakS4P7qvDNXvsJg8tixW9u1wF8jmMrtQ',
    appId: '1:119282080665:web:0bbc688c5f56422dcf1108',
    messagingSenderId: '119282080665',
    projectId: 'daivant-ai-astrology',
    authDomain: 'daivant-ai-astrology.firebaseapp.com',
    storageBucket: 'daivant-ai-astrology.firebasestorage.app',
  );
}
