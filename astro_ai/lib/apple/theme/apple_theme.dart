// apple/lib/theme/apple_theme.dart
// Apple iOS 17+ Target Design System Tokens: Ethereal Cyber-Mysticism

import 'package:flutter/cupertino.dart';

class AppleCosmicTheme {
  // OLED Deep Void
  static const Color oledVoid = Color(0xFF05050A);
  static const Color surfaceGlass = Color(0x0AFFFFFF);
  static const Color specularBorder = Color(0x1AFFFFFF);

  // Bioluminescent Accents
  static const Color champagneGold = Color(0xFFE6C687);
  static const Color stellarGold = Color(0xFFE6C687);
  static const Color nebulaViolet = Color(0xFF8B5CF6);
  static const Color auroraPink = Color(0xFFEC4899);
  static const Color emeraldSync = Color(0xFF10B981);
  static const Color roseWarning = Color(0xFFF43F5E);

  // iOS Ergonomics & Insets
  static const double dynamicIslandTopInset = 59.0;
  static const double homeIndicatorBottomInset = 34.0;
  static const double metalBlurSigma = 22.0;

  // Cupertino Theme Definition
  static CupertinoThemeData get cupertinoTheme {
    return const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: nebulaViolet,
      barBackgroundColor: Color(0xD905050A),
      scaffoldBackgroundColor: oledVoid,
      textTheme: CupertinoTextThemeData(
        primaryColor: Color(0xFFF8FAFC),
        textStyle: TextStyle(
          fontFamily: '.SF Pro Text',
          color: Color(0xFFF8FAFC),
          fontSize: 14,
        ),
        navTitleTextStyle: TextStyle(
          fontFamily: '.SF Pro Display',
          color: Color(0xFFF8FAFC),
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        navLargeTitleTextStyle: TextStyle(
          fontFamily: 'Cormorant Garamond',
          color: Color(0xFFF8FAFC),
          fontSize: 34,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
