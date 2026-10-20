// android/lib/theme/android_theme.dart
// Google Play Store (Android 13 / API 33+) Target Design System Tokens

import 'package:flutter/material.dart';

class AndroidCosmicTheme {
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

  // Android Ergonomics & Insets
  static const double statusBarTopInset = 24.0;
  static const double gestureBarBottomInset = 16.0;
  static const double vulkanBlurSigma = 20.0;

  // Material 3 Dark Theme Definition
  static ThemeData get materialTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: oledVoid,
      colorScheme: const ColorScheme.dark(
        primary: nebulaViolet,
        secondary: auroraPink,
        surface: oledVoid,
        onSurface: Color(0xFFF8FAFC),
      ),
      fontFamily: 'Plus Jakarta Sans',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Cormorant Garamond',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF8FAFC),
        ),
        titleMedium: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFFF8FAFC),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 13,
          color: Color(0xFF94A3B8),
        ),
        labelSmall: TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 10,
          letterSpacing: 1.2,
          color: champagneGold,
        ),
      ),
    );
  }
}
