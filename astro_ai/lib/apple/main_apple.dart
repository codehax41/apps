// apple/lib/main_apple.dart
// ASTROAI OS v4.0 - Apple iOS 17+ Target Entrypoint
// Impeller Engine (Metal Shader Pre-compilation), Cupertino Navigation Physics,
// Apple CoreHaptics, StoreKit 2, LocalAuthentication Biometrics, Firebase & Cloudflare Storage.

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'theme/apple_theme.dart';
import 'package:astro_ai/shared/screens/splash/screen_animated_splash.dart';
import 'package:astro_ai/shared/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (Auth & Firestore) for Apple platform
  await FirebaseService.instance.initialize();

  // Configure iOS System UI Overlays for OLED Void immersion
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: CupertinoColors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppleCosmicTheme.oledVoid,
      systemNavigationBarDividerColor: CupertinoColors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Lock to portrait orientation for precision celestial math calculations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const AstroAiAppleApp());
}

class AstroAiAppleApp extends StatelessWidget {
  const AstroAiAppleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'AstroAI - Vedic Astrolabe OS (Apple)',
      theme: AppleCosmicTheme.cupertinoTheme,
      debugShowCheckedModeBanner: false,
      home: const ScreenAnimatedSplash(isApple: true),
    );
  }
}
