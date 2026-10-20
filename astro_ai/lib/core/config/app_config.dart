// lib/core/config/app_config.dart
// ASTROAI OS v5.0 - Typed Configuration & Feature Flags Matrix

class AppConfig {
  // Environment Mode
  static const String appEnv = String.fromEnvironment('APP_ENV', defaultValue: 'development');

  // AI Text & Chat Model Configuration
  static const String textAiProvider = String.fromEnvironment('TEXT_AI_PROVIDER', defaultValue: 'openai');
  static const String textAiModel = String.fromEnvironment('TEXT_AI_MODEL', defaultValue: 'gpt-4o');

  // Realtime Voice Model Configuration
  static const String realtimeAiProvider = String.fromEnvironment('REALTIME_AI_PROVIDER', defaultValue: 'openai');
  static const String realtimeAiModel = String.fromEnvironment('REALTIME_AI_MODEL', defaultValue: 'gpt-4o-realtime-preview');

  // Speech & Voice Provider Options
  static const bool sarvamEnabled = bool.fromEnvironment('SARVAM_ENABLED', defaultValue: true);
  static const String primaryVoiceProvider = String.fromEnvironment('PRIMARY_VOICE_PROVIDER', defaultValue: 'openai');
  static const String fallbackVoiceProvider = String.fromEnvironment('FALLBACK_VOICE_PROVIDER', defaultValue: 'sarvam');

  // Entitlement & Trial Configuration
  static const bool trialPlanEnabled = bool.fromEnvironment('TRIAL_PLAN_ENABLED', defaultValue: true);
  static const int trialPriceInr = int.fromEnvironment('TRIAL_PRICE_INR', defaultValue: 7);
  static const int trialDurationHours = int.fromEnvironment('TRIAL_DURATION_HOURS', defaultValue: 24);
  static const int trialVoiceLimitSeconds = int.fromEnvironment('TRIAL_VOICE_LIMIT_SECONDS', defaultValue: 1800); // 30 mins

  // Feature Flags
  static const bool featureVoiceAi = bool.fromEnvironment('FEATURE_VOICE_AI', defaultValue: true);
  static const bool featureSarvamVoice = bool.fromEnvironment('FEATURE_SARVAM_VOICE', defaultValue: true);
  static const bool featureGoogleLogin = bool.fromEnvironment('FEATURE_GOOGLE_LOGIN', defaultValue: true);
  static const bool featureAppleLogin = bool.fromEnvironment('FEATURE_APPLE_LOGIN', defaultValue: true);
  static const bool featureFacebookLogin = bool.fromEnvironment('FEATURE_FACEBOOK_LOGIN', defaultValue: true);
  static const bool featureEmailLogin = bool.fromEnvironment('FEATURE_EMAIL_LOGIN', defaultValue: true);
  static const bool featureDataExport = bool.fromEnvironment('FEATURE_DATA_EXPORT', defaultValue: true);
  static const bool featureAccountDelete = bool.fromEnvironment('FEATURE_ACCOUNT_DELETE', defaultValue: true);

  // AI Palmistry & Computer Vision Model Configuration
  static const String palmAnalysisProvider = String.fromEnvironment('PALM_ANALYSIS_PROVIDER', defaultValue: 'mock_and_ai');
  static const String palmAnalysisModel = String.fromEnvironment('PALM_ANALYSIS_MODEL', defaultValue: 'gemini-1.5-pro-vision');
  static const String palmVisionModel = String.fromEnvironment('PALM_VISION_MODEL', defaultValue: 'gemini-1.5-pro-vision');
  static const String palmReportModel = String.fromEnvironment('PALM_REPORT_MODEL', defaultValue: 'gpt-4o');
  static const bool featurePalmistry = bool.fromEnvironment('FEATURE_PALMISTRY', defaultValue: true);

  // Legal & Privacy Configuration
  static const String privacyContactEmail = String.fromEnvironment('PRIVACY_CONTACT_EMAIL', defaultValue: 'privacy@astroai.quantum');
  static const int aiConversationRetentionDays = int.fromEnvironment('AI_CONVERSATION_RETENTION_DAYS', defaultValue: 90);
  static const String privacyPolicyUrl = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    defaultValue: 'https://raw.githubusercontent.com/codehax41/apps/main/astro_ai/privacy_policy.html',
  );
  static const String termsAndConditionsUrl = String.fromEnvironment(
    'TERMS_AND_CONDITIONS_URL',
    defaultValue: 'https://raw.githubusercontent.com/codehax41/apps/main/astro_ai/terms_and_conditions.html',
  );
  static const String dataDeletionPolicyUrl = String.fromEnvironment(
    'DATA_DELETION_POLICY_URL',
    defaultValue: 'https://raw.githubusercontent.com/codehax41/apps/main/astro_ai/deletion_policy.html',
  );
}
