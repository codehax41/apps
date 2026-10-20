// android/lib/main.dart
// ASTROAI OS v4.2 - Standalone Android Entry Point (Material 3 + Impeller/Vulkan)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/android_theme.dart';
import 'screens/screen01_welcome_android.dart';
import 'screens/screen02_choose_focus_android.dart';
import 'screens/screen03_birth_details_android.dart';
import 'screens/screen04_birthplace_search_android.dart';
import 'screens/screen05_home_dashboard_android.dart';
import 'screens/screen06_kundali_overview_android.dart';
import 'screens/screen07_planetary_positions_android.dart';
import 'screens/screen08_nakshatra_insight_android.dart';
import 'screens/screen09_daily_guidance_android.dart';
import 'screens/screen10_weekly_forecast_android.dart';
import 'screens/screen11_yearly_transits_android.dart';
import 'screens/screen12_career_reading_android.dart';
import 'screens/screen13_compatibility_intro_android.dart';
import 'screens/screen14_partner_details_android.dart';
import 'screens/screen15_compatibility_report_android.dart';
import 'screens/screen16_devi_live_oracle_android.dart';
import 'screens/screen17_guided_questions_android.dart';
import 'screens/screen18_premium_reports_android.dart';
import 'screens/screen19_career_report_detail_android.dart';
import 'screens/screen20_panchang_calendar_android.dart';
import 'screens/screen21_traditional_practice_android.dart';
import 'screens/screen22_saved_readings_android.dart';
import 'screens/screen23_notification_preferences_android.dart';
import 'screens/screen24_astro_ai_plus_android.dart';
import 'screens/screen25_personal_profile_android.dart';
import 'screens/screen26_privacy_preferences_android.dart';
import 'package:astro_ai/shared/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await FirebaseService.instance.initialize();
  } catch (e) {
    debugPrint("Firebase init note: $e");
  }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const AstroAIAndroidApp());
}

class AstroAIAndroidApp extends StatelessWidget {
  const AstroAIAndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AstroAI OS (Android 13+)',
      theme: AndroidCosmicTheme.materialTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Screen01WelcomeAndroid(),
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
      },
    );
  }
}
