// android/lib/main_android.dart
// ASTROAI OS v4.0 - Google Play Store (Android 13 / API 33+) Target Entrypoint
// Impeller Engine (Vulkan Hardware Acceleration), Material 3 Dark Palette,
// Android 14+ Predictive Back, Google Play Billing v7, Firebase & Cloudflare Storage.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/android_theme.dart';
import 'package:astro_ai/shared/screens/splash/screen_animated_splash.dart';
import 'package:astro_ai/shared/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (Auth & Firestore) for Android platform
  await FirebaseService.instance.initialize();

  // Enable Android Edge-to-Edge System UI Mode (API 33+)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Lock to portrait orientation for precision celestial math calculations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const AstroAiAndroidApp());
}

class AstroAiAndroidApp extends StatelessWidget {
  const AstroAiAndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AstroAI - Vedic Astrolabe OS (Android)',
      theme: AndroidCosmicTheme.materialTheme,
      debugShowCheckedModeBanner: false,
      home: const ScreenAnimatedSplash(isApple: false),
    );
  }
}
