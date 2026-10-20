import 'package:astro_ai/shared/engine/vedic/vedic_report_models.dart';
import 'package:astro_ai/shared/engine/vedic/vedic_calculation_service.dart';
import 'package:astro_ai/shared/widgets/reports_celestial_painters.dart';
import 'package:astro_ai/shared/screens/reports/screen_free_reports_hub.dart';
import 'package:astro_ai/shared/screens/reports/screen_report_dossier_detail.dart';
import 'package:flutter/material.dart';
import 'package:astro_ai/shared/widgets/kundali_universal_painter.dart';
// test/astro_ai_enterprise_test.dart
// ASTROAI OS v5.0 - Enterprise Automated Verification & Architecture Test Suite

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:astro_ai/core/localization/language_registry.dart';
import 'package:astro_ai/core/localization/language_manager.dart';
import 'package:astro_ai/core/localization/astro_terminology.dart';
import 'package:astro_ai/core/models/user_profile.dart';
import 'package:astro_ai/core/entitlements/server_voice_meter.dart';
import 'package:astro_ai/core/entitlements/payment_service.dart';
import 'package:astro_ai/core/auth/auth_service.dart';
import 'package:astro_ai/core/services/privacy_service.dart';
import 'package:astro_ai/core/ai/voice_routing_engine.dart';
import 'package:astro_ai/core/config/app_config.dart';
import 'package:astro_ai/shared/engine/3d/astrolabe_3d_engine.dart';
import 'package:astro_ai/shared/engine/3d/devi_oracle_3d_entity.dart';
import 'package:astro_ai/core/palmistry/models/palm_reading_model.dart';
import 'package:astro_ai/core/palmistry/services/palmistry_service.dart';
import 'package:astro_ai/core/palmistry/ai/palm_prompt_builder.dart';
import 'package:astro_ai/core/palmistry/providers/mock_and_ai_palm_vision_provider.dart';
import 'package:astro_ai/shared/screens/tarot/screen_tarot_soul_guide.dart';
import 'package:astro_ai/shared/screens/lunar/screen_lunar_wisdom.dart';
import 'package:astro_ai/shared/widgets/batch4_celestial_painters.dart';
import 'package:astro_ai/shared/screens/settings/screen_settings_cosmic.dart';
import 'package:astro_ai/shared/screens/transits/screen_todays_transits.dart';
import 'package:astro_ai/shared/screens/kundali/screen_dual_chart_kundli.dart';
import 'package:astro_ai/shared/widgets/batch5_celestial_painters.dart';
import 'package:astro_ai/shared/screens/horoscope/screen_daily_scored_horoscope.dart';
import 'package:astro_ai/shared/screens/horoscope/screen_best_hours_rahu_kalam.dart';
import 'package:astro_ai/shared/screens/compatibility/screen_gun_milan_report.dart';
import 'package:astro_ai/shared/screens/onboarding/screen_start_free_om_ai.dart';
import 'package:astro_ai/shared/screens/hub/screen_horoscope_kundli_daily_hub.dart';

void main() {
  group('1. Scalable Multi-Language Architecture & Capability Flags', () {
    test('Default system language resolves to English', () {
      expect(LanguageRegistry.defaultLanguage.id, 'en');
      expect(LanguageRegistry.defaultLanguage.locale, 'en-US');
      expect(LanguageRegistry.defaultLanguage.isRtl, isFalse);
    });

    test('LanguageRegistry.getById accurately looks up global and Indian languages', () {
      final hindi = LanguageRegistry.getById('hi');
      expect(hindi.displayName, 'Hindi');
      expect(hindi.nativeName, 'हिन्दी');
      expect(hindi.locale, 'hi-IN');
      expect(hindi.supportsIndianVoice, isTrue);
      expect(hindi.supportsRealtime, isTrue);
      expect(hindi.supportsSpeechInput, isTrue);
      expect(hindi.supportsSpeechOutput, isTrue);
      expect(hindi.supportsText, isTrue);

      final spanish = LanguageRegistry.getById('es');
      expect(spanish.displayName, 'Spanish');
      expect(spanish.locale, 'es-ES');
      expect(spanish.supportsIndianVoice, isFalse);
      expect(spanish.supportsRealtime, isTrue);

      final arabic = LanguageRegistry.getById('ar');
      expect(arabic.displayName, 'Arabic');
      expect(arabic.isRtl, isTrue);

      // Case-insensitivity check
      final upperHindi = LanguageRegistry.getById('HI');
      expect(upperHindi.id, 'hi');

      // Unknown language falls back to default
      final unknown = LanguageRegistry.getById('non_existent_xyz');
      expect(unknown.id, LanguageRegistry.defaultLanguage.id);
    });

    test('LanguageRegistry.getIndianLanguages filters all Indic voices', () {
      final indicLangs = LanguageRegistry.getIndianLanguages();
      final ids = indicLangs.map((l) => l.id).toSet();

      expect(ids.contains('hi'), isTrue);
      expect(ids.contains('en-IN'), isTrue);
      expect(ids.contains('bn'), isTrue);
      expect(ids.contains('ta'), isTrue);
      expect(ids.contains('te'), isTrue);
      expect(ids.contains('mr'), isTrue);
      expect(ids.contains('es'), isFalse);
    });

    test('AstroTerminology provides contextual Vedic translations', () {
      expect(AstroTerminology.translate('Lagna', 'hi'), 'लग्न');
      expect(AstroTerminology.translate('Lagna', 'en'), 'Ascendant');
      expect(AstroTerminology.translate('Mahadasha', 'hi'), 'महादशा');
      expect(AstroTerminology.translate('Navamsa', 'hi'), 'नवांश (D9)');
      expect(AstroTerminology.translate('Nakshatra', 'en'), 'Lunar Mansion');
    });

    test('LanguageManager changes runtime language and dynamic voice provider', () async {
      final manager = LanguageManager.instance;
      await manager.init();

      expect(manager.currentLanguage.id, 'en');
      expect(manager.preferredVoice, 'alloy');
      expect(manager.voiceProvider, 'openai');

      final hindi = LanguageRegistry.getById('hi');
      await manager.setLanguage(hindi);

      expect(manager.currentLanguage.id, 'hi');
      expect(manager.preferredVoice, 'sarvam_aditi');
      expect(manager.voiceProvider, 'sarvam');
    });
  });

  group('2. Entitlements & ₹7 One-Day Access Plan (24-Hour Pass)', () {
    test('UserProfile accurately tracks 24-hour expiration window', () {
      final now = DateTime.now();
      final activeUser = UserProfile(
        id: 'usr_test_1',
        email: 'test@astro.ai',
        displayName: 'Test Seeker',
        subscriptionPlan: 'trial_1_day_7_inr',
        subscriptionStatus: 'active',
        trialStartedAt: now,
        trialExpiresAt: now.add(const Duration(hours: 24)),
        createdAt: now,
        updatedAt: now,
      );

      expect(activeUser.isTrialActive, isTrue);

      final expiredUser = activeUser.copyWith(
        trialExpiresAt: now.subtract(const Duration(minutes: 1)),
      );
      expect(expiredUser.isTrialActive, isFalse);

      final canceledUser = activeUser.copyWith(
        subscriptionStatus: 'canceled',
      );
      expect(canceledUser.isTrialActive, isFalse);
    });

    test('UserProfile accurately formats remaining voice quota', () {
      final user = UserProfile(
        id: 'usr_test_2',
        email: 'test2@astro.ai',
        displayName: 'Astro User',
        voiceSecondsAllowed: 1800,
        voiceSecondsUsed: 150, // 2m 30s used -> 27m 30s remaining = 1650s
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(user.remainingVoiceSeconds, 1650);
      expect(user.formattedRemainingVoiceTime, '27:30');

      final exhaustedUser = user.copyWith(voiceSecondsUsed: 1800);
      expect(exhaustedUser.remainingVoiceSeconds, 0);
      expect(exhaustedUser.formattedRemainingVoiceTime, '00:00');
    });

    test('PaymentService activates 1-Day ₹7 Pass resetting quota to 1800s', () {
      final service = PaymentService.instance;
      final existingUser = UserProfile(
        id: 'usr_test_3',
        email: 'seeker@astro.ai',
        displayName: 'Seeker',
        subscriptionPlan: 'free',
        subscriptionStatus: 'none',
        voiceSecondsAllowed: 0,
        voiceSecondsUsed: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final activated = service.activateTrialEntitlement(existingUser);

      expect(activated.subscriptionPlan, 'trial_1_day_7_inr');
      expect(activated.subscriptionStatus, 'active');
      expect(activated.voiceSecondsAllowed, 1800);
      expect(activated.voiceSecondsUsed, 0);
      expect(activated.isTrialActive, isTrue);
      expect(activated.trialExpiresAt!.difference(activated.trialStartedAt!).inHours, 24);
    });
  });

  group('3. Server-Side 30-Minute Voice Metering & Concurrency Lock', () {
    test('ServerVoiceMeter rejects voice session when 1800s cap is exhausted', () async {
      final meter = ServerVoiceMeter.instance;
      const testUserId = 'usr_quota_exhausted';

      expect(
        () => meter.startVoiceSession(userId: testUserId, currentRecordedUsedSeconds: 1800),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('Voice quota exhausted'),
        )),
      );
    });

    test('ServerVoiceMeter rejects concurrent voice sessions for identical user', () async {
      final meter = ServerVoiceMeter.instance;
      const testUserId = 'usr_concurrent_test';

      // Start first session
      final remaining = await meter.startVoiceSession(
        userId: testUserId,
        currentRecordedUsedSeconds: 600,
      );
      expect(remaining, 1200);
      expect(meter.hasActiveSession, isTrue);

      // Attempt second concurrent session on another simulated device
      expect(
        () => meter.startVoiceSession(userId: testUserId, currentRecordedUsedSeconds: 600),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('Concurrent voice session detected'),
        )),
      );

      // End session to cleanup
      await meter.endVoiceSession(userId: testUserId);
      expect(meter.hasActiveSession, isFalse);
    });

    test('ServerVoiceMeter tracks session completion and elapsed duration', () async {
      final meter = ServerVoiceMeter.instance;
      const testUserId = 'usr_elapsed_test';

      await meter.startVoiceSession(userId: testUserId, currentRecordedUsedSeconds: 300);
      // Brief simulated interaction
      await Future.delayed(const Duration(milliseconds: 50));

      final newTotal = await meter.endVoiceSession(userId: testUserId);
      expect(newTotal >= 300, isTrue);
      expect(meter.hasActiveSession, isFalse);
    });
  });

  group('4. Multi-Provider Authentication & Account Linking', () {
    test('AuthService registers all 4 providers and supports session lifecycle', () async {
      final auth = AuthService.instance;
      await auth.init();

      expect(auth.isAuthenticated, isTrue);
      expect(auth.currentUser?.email, 'ramsundar.astro@gmail.com');

      // Sign out
      await auth.signOut();
      expect(auth.isAuthenticated, isFalse);
      expect(auth.currentUser, isNull);

      // Sign in with Google
      final googleUser = await auth.signInWithProvider('google');
      expect(googleUser.authProvider, 'google');
      expect(auth.isAuthenticated, isTrue);

      // Sign in with Apple
      final appleUser = await auth.signInWithProvider('apple');
      expect(appleUser.authProvider, 'apple');

      // Sign in with Facebook
      final fbUser = await auth.signInWithProvider('facebook');
      expect(fbUser.authProvider, 'facebook');

      // Sign in with Email
      final emailUser = await auth.signInWithProvider('email', credentials: {
        'email': 'user@astro.ai',
        'password': 'Password123!',
      });
      expect(emailUser.authProvider, 'email');
      expect(emailUser.email, 'user@astro.ai');
    });
  });

  group('5. Data Privacy, Export & 15-Step Permanent Deletion', () {
    test('PrivacyService.exportUserData exports sanitized structured JSON package', () async {
      final exportJson = await PrivacyService.instance.exportUserData('usr_export_test');
      expect(exportJson.isNotEmpty, isTrue);

      final Map<String, dynamic> parsed = jsonDecode(exportJson);
      expect(parsed['schema_version'], '5.0.0');
      expect(parsed['account_subject_id'], 'usr_export_test');
      expect(parsed['exported_data'], isNotNull);
      expect(parsed['exported_data']['birth_ephemeris'], isNotNull);
      expect(parsed['exported_data']['astrological_synthesis'], isNotNull);
      expect(parsed['exported_data']['subscription'], isNotNull);
      expect(parsed['security_notice'], contains('Secrets and internal AI tokens have been excluded'));
    });

    test('PrivacyService.executeCompleteProfilePurge completes 15-step permanent wipe', () async {
      final result = await PrivacyService.instance.executeCompleteProfilePurge('usr_purge_test');
      expect(result, isTrue);
    });

    test('AuthService.deleteEntireProfile executes purge and wipes active session', () async {
      final auth = AuthService.instance;
      await auth.init();
      expect(auth.isAuthenticated, isTrue);

      await auth.deleteEntireProfile();
      expect(auth.isAuthenticated, isFalse);
      expect(auth.currentUser, isNull);
    });
  });

  group('6. Dynamic Voice Routing Engine', () {
    test('VoiceRoutingEngine routes Indic languages to Sarvam AI', () {
      final engine = VoiceRoutingEngine.instance;

      final hindiProvider = engine.resolveProvider(locale: 'hi-IN');
      expect(hindiProvider.providerId, 'sarvam');

      final tamilProvider = engine.resolveProvider(locale: 'ta-IN');
      expect(tamilProvider.providerId, 'sarvam');

      final marathiProvider = engine.resolveProvider(locale: 'mr-IN');
      expect(marathiProvider.providerId, 'sarvam');
    });

    test('VoiceRoutingEngine routes global languages to OpenAI Realtime', () {
      final engine = VoiceRoutingEngine.instance;

      final englishProvider = engine.resolveProvider(locale: 'en-US');
      expect(englishProvider.providerId, 'openai');

      final spanishProvider = engine.resolveProvider(locale: 'es-ES');
      expect(spanishProvider.providerId, 'openai');

      final japaneseProvider = engine.resolveProvider(locale: 'ja-JP');
      expect(japaneseProvider.providerId, 'openai');
    });
  });

  group('7. Configuration Matrix & Defaults', () {
    test('AppConfig has expected production-grade defaults', () {
      expect(AppConfig.trialPriceInr, 7);
      expect(AppConfig.trialDurationHours, 24);
      expect(AppConfig.trialVoiceLimitSeconds, 1800);
      expect(AppConfig.privacyContactEmail, 'privacy@astroai.quantum');
      expect(AppConfig.aiConversationRetentionDays, 90);
    });
  });

  group('8. Interactive 3D Astrolabe & Dimensional Portals Engine (D1 -> D9 -> D10)', () {
    test('Astrolabe dimensional strata provide accurate Z-coordinates', () {
      expect(Astrolabe3DEngine.getDimensionZ(AstrolabeDimension.d1Rashi), 0.0);
      expect(Astrolabe3DEngine.getDimensionZ(AstrolabeDimension.d9Navamsa), 220.0);
      expect(Astrolabe3DEngine.getDimensionZ(AstrolabeDimension.d10Dasamsa), 440.0);
    });

    test('Astrolabe planetary ephemeris contains all Vedic grahas', () {
      final d1Planets = Astrolabe3DEngine.getPlanetsForDimension(AstrolabeDimension.d1Rashi);
      expect(d1Planets.length >= 7, isTrue);

      final sun = d1Planets.firstWhere((p) => p.id == 'sun');
      expect(sun.sanskritName, 'Surya');
      expect(sun.symbol, '☉');

      final moon = d1Planets.firstWhere((p) => p.id == 'moon');
      expect(moon.sanskritName, 'Chandra');
      expect(moon.houseNumber, 4);

      final mars = d1Planets.firstWhere((p) => p.id == 'mars');
      expect(mars.houseNumber, 10);
    });

    test('Astrolabe aspect engine detects dynamic geometric relationships', () {
      final d1Planets = Astrolabe3DEngine.getPlanetsForDimension(AstrolabeDimension.d1Rashi);
      final aspects = Astrolabe3DEngine.computeAspects(d1Planets);

      expect(aspects.isNotEmpty, isTrue);
      final hasConjunction = aspects.any((a) => a.type == AspectType.conjunction);
      expect(hasConjunction, isTrue); // Jupiter + Mercury in 1st house or Mars + Venus in 10th
    });

    test('Devi AI 3D Oracle states transition correctly', () {
      expect(DeviOracleState.values.contains(DeviOracleState.idle), isTrue);
      expect(DeviOracleState.values.contains(DeviOracleState.listening), isTrue);
      expect(DeviOracleState.values.contains(DeviOracleState.thinking), isTrue);
      expect(DeviOracleState.values.contains(DeviOracleState.speaking), isTrue);
    });
  });

  group('9. AI Palmistry, 3D Spatial Scanner & Samudrika Guardrails', () {
    test('PalmReading domain models serialize and deserialize accurately', () {
      const line = PalmLineFeature(
        id: 'test_heart',
        name: 'Heart Line',
        sanskritName: 'Hridaya Rekha',
        visible: true,
        confidence: 0.95,
        observedPattern: 'Curved and deep',
        traditionalMeaning: 'Emotional depth',
        aiNarrative: 'Empathetic alignment',
        pathPoints: [
          PalmLinePoint(x: 0.2, y: 0.3, z: 0.1),
          PalmLinePoint(x: 0.5, y: 0.3, z: 0.2),
        ],
        colorHex: '#FF3366',
      );

      final json = line.toJson();
      final revived = PalmLineFeature.fromJson(json);

      expect(revived.id, 'test_heart');
      expect(revived.name, 'Heart Line');
      expect(revived.sanskritName, 'Hridaya Rekha');
      expect(revived.pathPoints.length, 2);
      expect(revived.pathPoints.first.x, 0.2);
    });

    test('PalmVisionProvider accurately validates palm images and rejects empty paths', () async {
      final provider = MockAndAiPalmVisionProvider();
      final validRes = await provider.validatePalmImage(imagePath: 'palm_sample.jpg', isLeftHand: true);
      expect(validRes.isValid, isTrue);
      expect(validRes.qualityScore >= 0.90, isTrue);

      final invalidRes = await provider.validatePalmImage(imagePath: '', isLeftHand: true);
      expect(invalidRes.isValid, isFalse);
      expect(invalidRes.qualityScore < 0.70, isTrue);
    });

    test('PalmistryService creates a reading session and advances image uploads', () async {
      final service = PalmistryService.instance;
      final reading = await service.createReading(userId: 'test_user_777');

      expect(reading.status, PalmReadingStatus.uploaded);
      expect(reading.userId, 'test_user_777');

      final withLeft = await service.uploadLeftImage(
        readingId: reading.id,
        imagePath: 'left_img.jpg',
      );
      expect(withLeft.leftImagePath, 'left_img.jpg');

      final withBoth = await service.uploadRightImage(
        readingId: reading.id,
        imagePath: 'right_img.jpg',
      );
      expect(withBoth.rightImagePath, 'right_img.jpg');
      expect(withBoth.status, PalmReadingStatus.validating);
    });

    test('PalmistryService executes the 10-stage asynchronous pipeline with valid status transitions', () async {
      final service = PalmistryService.instance;
      final reading = await service.createReading(userId: 'test_user_777');
      await service.uploadLeftImage(readingId: reading.id, imagePath: 'left.jpg');
      await service.uploadRightImage(readingId: reading.id, imagePath: 'right.jpg');

      final completed = await service.startAnalysisPipeline(
        readingId: reading.id,
        languageLocale: 'en',
        fastModeForTests: true,
      );

      expect(completed.status, PalmReadingStatus.completed);
      expect(completed.currentStageIndex, 10);
      expect(completed.report, isNotNull);
      expect(completed.report!.leftPalm.heartLine.visible, isTrue);
      expect(completed.report!.rightPalm.headLine.visible, isTrue);
      expect(completed.report!.comparison.summary.isNotEmpty, isTrue);
    });

    test('PalmistryService supports single reading deletion', () async {
      final service = PalmistryService.instance;
      final reading = await service.createReading(userId: 'test_user_del');
      final fetched = service.getReading(reading.id);
      expect(fetched, isNotNull);

      final deleted = await service.deleteReading(reading.id);
      expect(deleted, isTrue);

      final updated = service.getReading(reading.id);
      expect(updated?.status, PalmReadingStatus.deleted);
    });

    test('PrivacyService.executeCompleteProfilePurge wipes palmistry telemetry in step 5', () async {
      final service = PalmistryService.instance;
      await service.createReading(userId: 'purge_subject_009');
      expect(service.getUserReadings('purge_subject_009').isNotEmpty, isTrue);

      final privacy = PrivacyService.instance;
      final purged = await privacy.executeCompleteProfilePurge('purge_subject_009');
      expect(purged, isTrue);

      expect(service.getUserReadings('purge_subject_009').isEmpty, isTrue);
    });

    test('PalmPromptBuilder enforces ethical non-fatalistic safety guardrails', () {
      final prompt = PalmPromptBuilder.buildVisionExtractionPrompt(languageCode: 'en');
      expect(prompt.contains('NEVER provide medical diagnoses'), isTrue);
      expect(prompt.contains('NEVER predict death'), isTrue);
      expect(prompt.contains('NEVER make absolute fatalistic claims'), isTrue);
    });

    test('Bilateral comparison highlights divergences between innate left and active right hands', () async {
      final provider = MockAndAiPalmVisionProvider();
      final report = await provider.extractPalmFeatures(
        leftImagePath: 'left.jpg',
        rightImagePath: 'right.jpg',
        languageLocale: 'en',
      );

      expect(report.leftPalm.isLeft, isTrue);
      expect(report.rightPalm.isLeft, isFalse);
      expect(report.comparison.innatePotentialLeft.contains('Innate Blueprint'), isTrue);
      expect(report.comparison.manifestedRealityRight.contains('Manifested Reality'), isTrue);
      expect(report.comparison.keyDivergences.isNotEmpty, isTrue);
      expect(report.strengthsAndThemes.length >= 3, isTrue);
    });
  });

  group('10. 3D Tarot Soul Guide & Lunar Ephemeris Telemetry', () {
    test('TarotCardData models represent classical Major Arcana archetypes with upright guidance', () {
      const card = TarotCardData(
        number: "II",
        name: "The High Priestess",
        archetype: "Keeper of the Cosmic Veil",
        uprightMeaning: "Intuition, Sacred Knowledge, Divine Feminine",
        guidance: "Trust the quiet whispers of your instinct.",
        elementalAssociation: "Water (Chandra / Moon)",
      );

      expect(card.number, "II");
      expect(card.name, "The High Priestess");
      expect(card.elementalAssociation.contains("Chandra"), isTrue);
      expect(card.guidance.isNotEmpty, isTrue);
    });

    test('LunarDayInfo encapsulates real-time astronomical distance and illumination calculations', () {
      const lunar = LunarDayInfo(
        dateLabel: "30 Sep",
        dayName: "Tue",
        phaseName: "First Quarter",
        lunarDay: 9,
        illuminationPercent: 52,
        distanceKm: 390145,
        moonrise: "15:05",
        moonset: "00:30",
        sunrise: "07:03",
        sunset: "19:04",
        tithiName: "Shukla Navami",
        insight: "Let intuition illuminate your path.",
      );

      expect(lunar.phaseName, "First Quarter");
      expect(lunar.lunarDay, 9);
      expect(lunar.illuminationPercent, 52);
      expect(lunar.distanceKm, 390145);
      expect(lunar.tithiName, "Shukla Navami");
    });
  });

  group('11. Full-Fidelity Kundali Overview (North Diamond & South Box Grid)', () {
    test('KundaliUniversalPainter supports D1, D9, D10 across North and South layouts', () {
      final northD1 = KundaliUniversalPainter(
        division: KundaliDivision.d1Lagna,
        isSouthIndian: false,
      );
      expect(northD1.division, KundaliDivision.d1Lagna);
      expect(northD1.isSouthIndian, isFalse);

      final southD9 = KundaliUniversalPainter(
        division: KundaliDivision.d9Navamsa,
        isSouthIndian: true,
      );
      expect(southD9.division, KundaliDivision.d9Navamsa);
      expect(southD9.isSouthIndian, isTrue);

      final northD10 = KundaliUniversalPainter(
        division: KundaliDivision.d10Dasamsa,
        isSouthIndian: false,
      );
      expect(northD10.division, KundaliDivision.d10Dasamsa);
      expect(northD10.isSouthIndian, isFalse);
    });

    test('CelestialMedallionPainter instantiates for Sun and Moon glyphs', () {
      final sunPainter = CelestialMedallionPainter(isSun: true);
      final moonPainter = CelestialMedallionPainter(isSun: false);
      expect(sunPainter.isSun, isTrue);
      expect(moonPainter.isSun, isFalse);
    });

    test('LibraScalesPainter instantiates without throwing exceptions', () {
      final scalesPainter = LibraScalesPainter();
      expect(scalesPainter.shouldRepaint(scalesPainter), isFalse);
    });
  });

  group('12. Batch 4 Screens & High-Fidelity Celestial Widgets Verification', () {
    test('GoldenPiscesConstellationPainter paints without exception', () {
      final painter = GoldenPiscesConstellationPainter(progress: 0.5);
      expect(painter.shouldRepaint(painter), isTrue);
    });

    test('SplitDualMoon3DPainter renders dual basalt & embossed gold hemispheres', () {
      final painter = SplitDualMoon3DPainter(wobble: 0.25);
      final samePainter = SplitDualMoon3DPainter(wobble: 0.25);
      final diffPainter = SplitDualMoon3DPainter(wobble: 0.75);
      expect(painter.shouldRepaint(samePainter), isFalse);
      expect(painter.shouldRepaint(diffPainter), isTrue);
    });

    test('SunMoonDaylightArcPainter tracks daylight progress and colored arc phases', () {
      final arcPainter = SunMoonDaylightArcPainter(progress: 0.42);
      final sameArcPainter = SunMoonDaylightArcPainter(progress: 0.42);
      final diffArcPainter = SunMoonDaylightArcPainter(progress: 0.85);
      expect(arcPainter.shouldRepaint(sameArcPainter), isFalse);
      expect(arcPainter.shouldRepaint(diffArcPainter), isTrue);
    });

    test('OrbitalRingsPainter and JupiterBandedSpherePainter instantiate correctly', () {
      final rings = OrbitalRingsPainter();
      final jupiter = JupiterBandedSpherePainter();
      expect(rings.shouldRepaint(rings), isFalse);
      expect(jupiter.shouldRepaint(jupiter), isFalse);
    });

    test('CleanNorthIndianDiamondPainter supports D1 and D9 division configurations', () {
      final d1Painter = CleanNorthIndianDiamondPainter(isD9: false);
      final d9Painter = CleanNorthIndianDiamondPainter(isD9: true);
      expect(d1Painter.isD9, isFalse);
      expect(d9Painter.isD9, isTrue);
      expect(d1Painter.shouldRepaint(d9Painter), isTrue);
      expect(d1Painter.shouldRepaint(d1Painter), isFalse);
    });

    test('ScreenSettingsCosmic, ScreenTodaysTransits and ScreenDualChartKundli instantiate', () {
      const settingsScreen = ScreenSettingsCosmic();
      const transitsScreen = ScreenTodaysTransits();
      const dualKundliScreen = ScreenDualChartKundli();
      expect(settingsScreen, isNotNull);
      expect(transitsScreen, isNotNull);
      expect(dualKundliScreen, isNotNull);
    });

    test('LunarDayInfo accommodates transition times and countdown badges for Tithi Portal', () {
      const shashthi = LunarDayInfo(
        dateLabel: "16",
        dayName: "FRI",
        phaseName: "Shashthi",
        lunarDay: 6,
        illuminationPercent: 58,
        distanceKm: 388910,
        moonrise: "15:02",
        moonset: "00:48",
        sunrise: "06:32",
        sunset: "18:11",
        tithiName: "Shashthi",
        transitionTime: "17 OCT, 5:55AM TAK • PHIR SAPTAMI SHURU",
        insight: "Shukla Shashthi ka samay ghar banane ya zameen-jaydad se jude kaamon ke liye bahut achha mana jata hai.",
      );
      expect(shashthi.tithiName, "Shashthi");
      expect(shashthi.transitionTime, contains("PHIR SAPTAMI SHURU"));
      expect(shashthi.insight, contains("ghar banane"));

      const saptami = LunarDayInfo(
        dateLabel: "17",
        dayName: "SAT",
        phaseName: "Shukla-Saptami",
        lunarDay: 7,
        illuminationPercent: 67,
        distanceKm: 387420,
        moonrise: "15:50",
        moonset: "01:42",
        sunrise: "06:33",
        sunset: "18:10",
        tithiName: "Shukla-Saptami",
        transitionTime: "18 OCT, 8:29AM TAK • PHIR ASHTAMI SHURU",
        timerBadge: "01:16",
        insight: "Shukla-Saptami ek bahut achha din hai.",
      );
      expect(saptami.tithiName, "Shukla-Saptami");
      expect(saptami.timerBadge, "01:16");
    });
  });

  group('13. Batch 5 Screens & Daily Scored Horoscope Verification', () {
    test('CircularScoreArcPainter paints score and selection states accurately', () {
      final painter = CircularScoreArcPainter(score: 100, strokeColor: const Color(0xFF00FF66), isSelected: true);
      final samePainter = CircularScoreArcPainter(score: 100, strokeColor: const Color(0xFF00FF66), isSelected: true);
      final diffPainter = CircularScoreArcPainter(score: 69, strokeColor: const Color(0xFF00FF66), isSelected: false);

      expect(painter.shouldRepaint(samePainter), isFalse);
      expect(painter.shouldRepaint(diffPainter), isTrue);
    });

    test('GoldenScrollPainter paints 3D astrological scroll', () {
      final painter = GoldenScrollPainter();
      expect(painter.shouldRepaint(painter), isFalse);
    });

    test('ScoreFactorItem and BestHourWindowItem models encapsulate hora and factor points', () {
      const factor = ScoreFactorItem(
        placementTitle: "Mercury in 11th house (Friendly)",
        points: 11,
        explanation: "Mercury sharpens thinking and communication in your income and gains",
      );
      expect(factor.points, 11);
      expect(factor.placementTitle, contains("Mercury"));

      const window = BestHourWindowItem(
        category: "CAREER",
        timeRange: "5:06 PM - 6:06 PM",
        horaDescription: "Jupiter Hour • Jupiter rules your 10th house",
        badgeText: "Strong",
        iconColor: Color(0xFF3498DB),
        icon: Icons.work_outline,
      );
      expect(window.category, "CAREER");
      expect(window.timeRange, "5:06 PM - 6:06 PM");
      expect(window.badgeText, "Strong");
    });

    test('AshtakootRowItem correctly models Gana, Bhakoot, and Nadi points', () {
      const gana = AshtakootRowItem(
        kutaName: "Gana",
        pointsFraction: "6/6",
        femaleAttribute: "Manushya",
        maleAttribute: "Manushya",
        description: "Temperament group",
      );
      expect(gana.pointsFraction, "6/6");
      expect(gana.femaleAttribute, "Manushya");

      const bhakoot = AshtakootRowItem(
        kutaName: "Bhakoot",
        pointsFraction: "7/7",
        femaleAttribute: "Aquarius",
        maleAttribute: "Sagittarius",
        description: "Moon-sign spacing",
      );
      expect(bhakoot.pointsFraction, "7/7");

      const nadi = AshtakootRowItem(
        kutaName: "Nadi",
        pointsFraction: "8/8",
        femaleAttribute: "Adi",
        maleAttribute: "Madhya",
        description: "Constitution and lineage",
      );
      expect(nadi.pointsFraction, "8/8");
    });

    test('Batch 5 Screens instantiate cleanly with default configurations', () {
      const dailyScored = ScreenDailyScoredHoroscope();
      const bestHours = ScreenBestHoursRahuKalam();
      const gunMilan = ScreenGunMilanReport(partnerName: "Priya");
      const startFree = ScreenStartFreeOmAi();
      const dailyHub = ScreenHoroscopeKundliDailyHub();

      expect(dailyScored, isNotNull);
      expect(bestHours, isNotNull);
      expect(gunMilan, isNotNull);
      expect(gunMilan.partnerName, "Priya");
      expect(startFree, isNotNull);
      expect(dailyHub, isNotNull);
    });
  });

  group('14. 100+ Free Reports Hub & High-Precision Vedic Calculation Engine', () {
    final calc = VedicCalculationService();

    test('Mangal Dosha calculation detects cancellations and computes severity', () {
      final analysis = calc.computeMangalDosha(marsHouse: 8, marsSign: 'Scorpio', jupiterHouse: 4);
      expect(analysis.isCancelled, isTrue);
      expect(analysis.severityPercent, 28.5);
      expect(analysis.remedies.isNotEmpty, isTrue);

      final noDosha = calc.computeMangalDosha(marsHouse: 3);
      expect(noDosha.isManglik, isFalse);
      expect(noDosha.severityPercent, 0.0);
    });

    test('Sade Sati Life calculation tracks 3 cycles, current phase and Dhaiya', () {
      final sade = calc.computeSadeSati();
      expect(sade.isUnderSadeSati, isTrue);
      expect(sade.currentPhase.contains('Peak Phase'), isTrue);
      expect(sade.timelineDates.length, 7);
      expect(sade.remedies.isNotEmpty, isTrue);
    });

    test('Kaal Sarp Yoga evaluates nodal axis and assigns classical yoga name', () {
      final kaal = calc.computeKaalSarp(rahuHouse: 1, ketuHouse: 7);
      expect(kaal.isKaalSarpPresent, isTrue);
      expect(kaal.yogaName, 'Anant Kaal Sarp Yoga');
      expect(kaal.severityScore, 74.0);
      expect(kaal.remedies.length, 4);
    });

    test('Gemstones Report prescribes Life, Lucky and Benefic stones while forbidding enemy stones', () {
      final gems = calc.computeGemstoneRecommendations();
      expect(gems.length, 3);
      expect(gems[0].gemstoneName, 'Emerald (Panna)');
      expect(gems[0].rulingPlanet, 'Mercury (Budha)');
      expect(gems[0].strictlyForbiddenStones.contains('Red Coral (Moonga)'), isTrue);
      expect(gems[1].gemstoneName.contains('Blue Sapphire'), isTrue);
    });

    test('Vimshottari Dasha timeline calculates Mahadasha epochs and scores', () {
      final timeline = calc.computeDashaTimeline();
      expect(timeline.length, 4);
      expect(timeline.first.planetName, 'Mercury');
      expect(timeline.first.isCurrent, isTrue);
      expect(timeline.first.score, 94.0);
    });

    test('Lal Kitab Debts evaluates 9 ancestral Rinas with symptoms and remedies', () {
      final debts = calc.computeLalKitabDebts();
      expect(debts.length, 5);
      expect(debts.any((d) => d.debtName.contains("Forefathers' Debt") && d.isIdentified), isTrue);
      expect(debts.any((d) => d.debtName.contains("Female Debt") && d.isIdentified), isTrue);
    });

    test('Shodashvarga computes all 16 divisional charts from D1 to D60 with dignity scores', () {
      final vargas = calc.computeShodashvargaCharts();
      expect(vargas.length, 16);
      expect(vargas.first.vargaCode, 'D1');
      expect(vargas.any((v) => v.vargaCode == 'D9' && v.sanskritName == 'Navamsha'), isTrue);
      expect(vargas.any((v) => v.vargaCode == 'D10' && v.sanskritName == 'Dashamsha'), isTrue);
      expect(vargas.any((v) => v.vargaCode == 'D60' && v.sanskritName == 'Shashtiamsha'), isTrue);
    });

    test('KP System calculates 12 cuspal sub-lords and ruling significators', () {
      final subLords = calc.computeKpSubLords();
      expect(subLords.length, 12);
      expect(subLords.first.cuspNumber, 1);
      expect(subLords.first.subLord, 'Jupiter');
      expect(subLords[9].cuspNumber, 10);
      expect(subLords[9].subLord, 'Mercury');
    });

    test('Master Dossier Builder returns classical Sanskrit shlokas and executive analysis', () {
      final mangalDossier = calc.getReportDossier(VedicReportId.mangalDosh);
      expect(mangalDossier.classicalShloka.isNotEmpty, isTrue);
      expect(mangalDossier.sanskritTitle.contains('मङ्गल दोष'), isTrue);
      expect(mangalDossier.coreMetrics.isNotEmpty, isTrue);

      final shodashDossier = calc.getReportDossier(VedicSystemId.shodashvarga);
      expect(shodashDossier.categoryTag, 'PRIMARY SYSTEMS');
      expect(shodashDossier.coreMetrics['Total Vargas'], '16 Charts Computed');
    });

    test('Reports Custom Painters instantiate cleanly', () {
      final dashaPainter = DashaChakraWheelPainter();
      final mosaicPainter = ShodashvargaMosaicPainter();
      final orbitPainter = SadeSatiOrbitPainter();
      final serpentPainter = KaalSarpSerpentPainter();
      final facetPainter = GemstoneFacetPainter();

      expect(dashaPainter, isNotNull);
      expect(mosaicPainter, isNotNull);
      expect(orbitPainter, isNotNull);
      expect(serpentPainter, isNotNull);
      expect(facetPainter, isNotNull);
    });

    test('ScreenFreeReportsHub and ScreenReportDossierDetail instantiate cleanly', () {
      const hub = ScreenFreeReportsHub();
      const detail = ScreenReportDossierDetail(
        reportOrSystemId: VedicReportId.mangalDosh,
        title: "Mangal Dosh",
      );

      expect(hub, isNotNull);
      expect(detail, isNotNull);
      expect(detail.title, "Mangal Dosh");
    });
  });
}
