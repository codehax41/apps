// apple/lib/main.dart
// ASTROAI OS v4.2 - Standalone Apple iOS Entry Point (Cupertino + Metal Shaders)

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'theme/apple_theme.dart';
import 'screens/screen01_welcome_apple.dart';
import 'screens/screen02_choose_focus_apple.dart';
import 'screens/screen03_birth_details_apple.dart';
import 'screens/screen04_birthplace_search_apple.dart';
import 'screens/screen05_home_dashboard_apple.dart';
import 'screens/screen06_kundali_overview_apple.dart';
import 'screens/screen07_planetary_positions_apple.dart';
import 'screens/screen08_nakshatra_insight_apple.dart';
import 'screens/screen09_daily_guidance_apple.dart';
import 'screens/screen10_weekly_forecast_apple.dart';
import 'screens/screen11_yearly_transits_apple.dart';
import 'screens/screen12_career_reading_apple.dart';
import 'screens/screen13_compatibility_intro_apple.dart';
import 'screens/screen14_partner_details_apple.dart';
import 'screens/screen15_compatibility_report_apple.dart';
import 'screens/screen16_devi_live_oracle_apple.dart';
import 'screens/screen17_guided_questions_apple.dart';
import 'screens/screen18_premium_reports_apple.dart';
import 'screens/screen19_career_report_detail_apple.dart';
import 'screens/screen20_panchang_calendar_apple.dart';
import 'screens/screen21_traditional_practice_apple.dart';
import 'screens/screen22_saved_readings_apple.dart';
import 'screens/screen23_notification_preferences_apple.dart';
import 'screens/screen24_astro_ai_plus_apple.dart';
import 'screens/screen25_personal_profile_apple.dart';
import 'screens/screen26_privacy_preferences_apple.dart';
import 'package:astro_ai/shared/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await FirebaseService.instance.initialize();
  } catch (e) {
    debugPrint("Firebase init note: $e");
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: CupertinoColors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const AstroAIAppleApp());
}

class AstroAIAppleApp extends StatelessWidget {
  const AstroAIAppleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'AstroAI Cosmic (iOS 17+)',
      theme: AppleCosmicTheme.cupertinoTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Screen01WelcomeApple(),
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
      },
    );
  }
}
