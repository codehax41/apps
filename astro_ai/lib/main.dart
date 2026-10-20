// lib/main.dart
// ASTROAI OS v4.2 - Master Dual-Platform Entry Point (Android + Apple iOS)
// Auto-detects runtime platform to instantiate Android Material 3 or Apple Cupertino ergonomics.

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// Android Theme & Screens
import 'package:astro_ai/android/theme/android_theme.dart';
import 'package:astro_ai/android/screens/screen01_welcome_android.dart';
import 'package:astro_ai/android/screens/screen02_choose_focus_android.dart';
import 'package:astro_ai/android/screens/screen03_birth_details_android.dart';
import 'package:astro_ai/android/screens/screen04_birthplace_search_android.dart';
import 'package:astro_ai/android/screens/screen05_home_dashboard_android.dart';
import 'package:astro_ai/android/screens/screen06_kundali_overview_android.dart';
import 'package:astro_ai/android/screens/screen07_planetary_positions_android.dart';
import 'package:astro_ai/android/screens/screen08_nakshatra_insight_android.dart';
import 'package:astro_ai/android/screens/screen09_daily_guidance_android.dart';
import 'package:astro_ai/android/screens/screen10_weekly_forecast_android.dart';
import 'package:astro_ai/android/screens/screen11_yearly_transits_android.dart';
import 'package:astro_ai/android/screens/screen12_career_reading_android.dart';
import 'package:astro_ai/android/screens/screen13_compatibility_intro_android.dart';
import 'package:astro_ai/android/screens/screen14_partner_details_android.dart';
import 'package:astro_ai/android/screens/screen15_compatibility_report_android.dart';
import 'package:astro_ai/android/screens/screen16_devi_live_oracle_android.dart';
import 'package:astro_ai/android/screens/screen17_guided_questions_android.dart';
import 'package:astro_ai/android/screens/screen18_premium_reports_android.dart';
import 'package:astro_ai/android/screens/screen19_career_report_detail_android.dart';
import 'package:astro_ai/android/screens/screen20_panchang_calendar_android.dart';
import 'package:astro_ai/android/screens/screen21_traditional_practice_android.dart';
import 'package:astro_ai/android/screens/screen22_saved_readings_android.dart';
import 'package:astro_ai/android/screens/screen23_notification_preferences_android.dart';
import 'package:astro_ai/android/screens/screen24_astro_ai_plus_android.dart';
import 'package:astro_ai/android/screens/screen25_personal_profile_android.dart';
import 'package:astro_ai/android/screens/screen26_privacy_preferences_android.dart';

// Apple Theme & Screens
import 'package:astro_ai/apple/theme/apple_theme.dart';
import 'package:astro_ai/apple/screens/screen01_welcome_apple.dart';
import 'package:astro_ai/apple/screens/screen02_choose_focus_apple.dart';
import 'package:astro_ai/apple/screens/screen03_birth_details_apple.dart';
import 'package:astro_ai/apple/screens/screen04_birthplace_search_apple.dart';
import 'package:astro_ai/apple/screens/screen05_home_dashboard_apple.dart';
import 'package:astro_ai/apple/screens/screen06_kundali_overview_apple.dart';
import 'package:astro_ai/apple/screens/screen07_planetary_positions_apple.dart';
import 'package:astro_ai/apple/screens/screen08_nakshatra_insight_apple.dart';
import 'package:astro_ai/apple/screens/screen09_daily_guidance_apple.dart';
import 'package:astro_ai/apple/screens/screen10_weekly_forecast_apple.dart';
import 'package:astro_ai/apple/screens/screen11_yearly_transits_apple.dart';
import 'package:astro_ai/apple/screens/screen12_career_reading_apple.dart';
import 'package:astro_ai/apple/screens/screen13_compatibility_intro_apple.dart';
import 'package:astro_ai/apple/screens/screen14_partner_details_apple.dart';
import 'package:astro_ai/apple/screens/screen15_compatibility_report_apple.dart';
import 'package:astro_ai/apple/screens/screen16_devi_live_oracle_apple.dart';
import 'package:astro_ai/apple/screens/screen17_guided_questions_apple.dart';
import 'package:astro_ai/apple/screens/screen18_premium_reports_apple.dart';
import 'package:astro_ai/apple/screens/screen19_career_report_detail_apple.dart';
import 'package:astro_ai/apple/screens/screen20_panchang_calendar_apple.dart';
import 'package:astro_ai/apple/screens/screen21_traditional_practice_apple.dart';
import 'package:astro_ai/apple/screens/screen22_saved_readings_apple.dart';
import 'package:astro_ai/apple/screens/screen23_notification_preferences_apple.dart';
import 'package:astro_ai/apple/screens/screen24_astro_ai_plus_apple.dart';
import 'package:astro_ai/apple/screens/screen25_personal_profile_apple.dart';
import 'package:astro_ai/apple/screens/screen26_privacy_preferences_apple.dart';

// Shared Services
import 'package:astro_ai/shared/services/firebase_service.dart';
import 'package:astro_ai/shared/screens/splash/screen_animated_splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Try to safely initialize Firebase (fails gracefully if config is not linked yet)
  try {
    await FirebaseService.instance.initialize();
  } catch (e) {
    debugPrint("AstroAI: Firebase offline initialization fallback -> $e");
  }

  // Set system UI ergonomics: Transparent edge-to-edge for OLED Void #05050A
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const AstroAIMasterApp());
}

class AstroAIMasterApp extends StatefulWidget {
  const AstroAIMasterApp({super.key});

  @override
  State<AstroAIMasterApp> createState() => _AstroAIMasterAppState();
}

class _AstroAIMasterAppState extends State<AstroAIMasterApp> {
  // Allows testing either platform mode even on web or single OS
  late bool _isAppleTarget;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _isAppleTarget = false;
    } else {
      _isAppleTarget = Platform.isIOS || Platform.isMacOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAppleTarget) {
      return CupertinoApp(
        title: 'Daivant AI Astrology (Apple iOS)',
        theme: AppleCosmicTheme.cupertinoTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: _appleRoutes(),
      );
    } else {
      return MaterialApp(
        title: 'Daivant AI Astrology (Android)',
        theme: AndroidCosmicTheme.materialTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: _androidRoutes(),
      );
    }
  }

  Map<String, WidgetBuilder> _androidRoutes() {
    return {
      '/': (context) => const ScreenAnimatedSplash(isApple: false),
      '/splash': (context) => const ScreenAnimatedSplash(isApple: false),
      '/screen01': (context) => const Screen01WelcomeAndroid(),
      '/screen02': (context) => const Screen02ChooseFocusAndroid(),
      '/screen03': (context) => const Screen03BirthDetailsAndroid(),
      '/screen04': (context) => const Screen04BirthplaceSearchAndroid(),
      '/screen05': (context) => const Screen05HomeDashboardAndroid(),
      '/screen06': (context) => const Screen06KundaliOverviewAndroid(),
      '/screen07': (context) => const Screen07PlanetaryPositionsAndroid(),
      '/screen08': (context) => const Screen08NakshatraInsightAndroid(),
      '/screen09': (context) => const Screen09DailyGuidanceAndroid(),
      '/screen10': (context) => const Screen10WeeklyForecastAndroid(),
      '/screen11': (context) => const Screen11YearlyTransitsAndroid(),
      '/screen12': (context) => const Screen12CareerReadingAndroid(),
      '/screen13': (context) => const Screen13CompatibilityIntroAndroid(),
      '/screen14': (context) => const Screen14PartnerDetailsAndroid(),
      '/screen15': (context) => const Screen15CompatibilityReportAndroid(),
      '/screen16': (context) => const Screen16DeviLiveOracleAndroid(),
      '/screen17': (context) => const Screen17GuidedQuestionsAndroid(),
      '/screen18': (context) => const Screen18PremiumReportsAndroid(),
      '/screen19': (context) => const Screen19CareerReportDetailAndroid(),
      '/screen20': (context) => const Screen20PanchangCalendarAndroid(),
      '/screen21': (context) => const Screen21TraditionalPracticeAndroid(),
      '/screen22': (context) => const Screen22SavedReadingsAndroid(),
      '/screen23': (context) => const Screen23NotificationPreferencesAndroid(),
      '/screen24': (context) => const Screen24AstroAiPlusAndroid(),
      '/screen25': (context) => const Screen25PersonalProfileAndroid(),
      '/screen26': (context) => const Screen26PrivacyPreferencesAndroid(),
    };
  }

  Map<String, WidgetBuilder> _appleRoutes() {
    return {
      '/': (context) => const ScreenAnimatedSplash(isApple: true),
      '/splash': (context) => const ScreenAnimatedSplash(isApple: true),
      '/screen01': (context) => const Screen01WelcomeApple(),
      '/screen02': (context) => const Screen02ChooseFocusApple(),
      '/screen03': (context) => const Screen03BirthDetailsApple(),
      '/screen04': (context) => const Screen04BirthplaceSearchApple(),
      '/screen05': (context) => const Screen05HomeDashboardApple(),
      '/screen06': (context) => const Screen06KundaliOverviewApple(),
      '/screen07': (context) => const Screen07PlanetaryPositionsApple(),
      '/screen08': (context) => const Screen08NakshatraInsightApple(),
      '/screen09': (context) => const Screen09DailyGuidanceApple(),
      '/screen10': (context) => const Screen10WeeklyForecastApple(),
      '/screen11': (context) => const Screen11YearlyTransitsApple(),
      '/screen12': (context) => const Screen12CareerReadingApple(),
      '/screen13': (context) => const Screen13CompatibilityIntroApple(),
      '/screen14': (context) => const Screen14PartnerDetailsApple(),
      '/screen15': (context) => const Screen15CompatibilityReportApple(),
      '/screen16': (context) => const Screen16DeviLiveOracleApple(),
      '/screen17': (context) => const Screen17GuidedQuestionsApple(),
      '/screen18': (context) => const Screen18PremiumReportsApple(),
      '/screen19': (context) => const Screen19CareerReportDetailApple(),
      '/screen20': (context) => const Screen20PanchangCalendarApple(),
      '/screen21': (context) => const Screen21TraditionalPracticeApple(),
      '/screen22': (context) => const Screen22SavedReadingsApple(),
      '/screen23': (context) => const Screen23NotificationPreferencesApple(),
      '/screen24': (context) => const Screen24AstroAiPlusApple(),
      '/screen25': (context) => const Screen25PersonalProfileApple(),
      '/screen26': (context) => const Screen26PrivacyPreferencesApple(),
    };
  }
}
