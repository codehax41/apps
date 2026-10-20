// lib/core/palmistry/services/palmistry_service.dart
// ASTROAI OS v5.0 - Palmistry Orchestration Service with Async 10-Stage Pipeline

import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/palm_reading_model.dart';
import '../providers/palm_vision_provider_interface.dart';
import '../providers/mock_and_ai_palm_vision_provider.dart';

class PalmistryService {
  static final PalmistryService instance = PalmistryService._internal();
  PalmistryService._internal();

  IPalmVisionProvider _visionProvider = MockAndAiPalmVisionProvider();
  final Map<String, PalmReading> _readingsStore = {};
  final StreamController<PalmReading> _readingUpdatesController =
      StreamController<PalmReading>.broadcast();

  Stream<PalmReading> get onReadingUpdate => _readingUpdatesController.stream;

  void setVisionProvider(IPalmVisionProvider provider) {
    _visionProvider = provider;
  }

  IPalmVisionProvider get currentProvider => _visionProvider;

  /// Creates a new PalmReading session
  Future<PalmReading> createReading({required String userId}) async {
    final id = 'palm_${DateTime.now().millisecondsSinceEpoch}';
    final reading = PalmReading(
      id: id,
      userId: userId,
      status: PalmReadingStatus.uploaded,
      createdAt: DateTime.now(),
      currentStageIndex: 0,
      currentStageMessage: 'Place hands to initiate cosmic calibration',
    );
    _readingsStore[id] = reading;
    _readingUpdatesController.add(reading);
    return reading;
  }

  /// Registers left palm image
  Future<PalmReading> uploadLeftImage({
    required String readingId,
    required String imagePath,
  }) async {
    final existing = _readingsStore[readingId];
    if (existing == null) throw Exception('Palm reading session not found');

    final updated = existing.copyWith(
      leftImagePath: imagePath,
      status: existing.rightImagePath != null
          ? PalmReadingStatus.validating
          : PalmReadingStatus.uploaded,
    );
    _readingsStore[readingId] = updated;
    _readingUpdatesController.add(updated);
    return updated;
  }

  /// Registers right palm image
  Future<PalmReading> uploadRightImage({
    required String readingId,
    required String imagePath,
  }) async {
    final existing = _readingsStore[readingId];
    if (existing == null) throw Exception('Palm reading session not found');

    final updated = existing.copyWith(
      rightImagePath: imagePath,
      status: existing.leftImagePath != null
          ? PalmReadingStatus.validating
          : PalmReadingStatus.uploaded,
    );
    _readingsStore[readingId] = updated;
    _readingUpdatesController.add(updated);
    return updated;
  }

  /// Validates both images
  Future<PalmValidationResult> validateReadingImages(String readingId) async {
    final reading = _readingsStore[readingId];
    if (reading == null) throw Exception('Reading not found');

    final leftValidation = await _visionProvider.validatePalmImage(
      imagePath: reading.leftImagePath ?? 'mock_left.jpg',
      isLeftHand: true,
    );
    final rightValidation = await _visionProvider.validatePalmImage(
      imagePath: reading.rightImagePath ?? 'mock_right.jpg',
      isLeftHand: false,
    );

    final allValid = leftValidation.isValid && rightValidation.isValid;
    final updated = reading.copyWith(
      status: allValid ? PalmReadingStatus.validated : PalmReadingStatus.validating,
    );
    _readingsStore[readingId] = updated;
    _readingUpdatesController.add(updated);

    return leftValidation;
  }

  /// Executes the 10-Stage Cinematic Analysis Pipeline
  Future<PalmReading> startAnalysisPipeline({
    required String readingId,
    String languageLocale = 'en',
    bool fastModeForTests = false,
  }) async {
    final initialReading = _readingsStore[readingId];
    if (initialReading == null) throw Exception('Reading session not found');
    PalmReading activeReading = initialReading;

    final stages = [
      'Mapping palm surface grid...',
      'Tracing primary lines and dermal contours...',
      'Following the heart line (Hridaya Rekha)...',
      'Following the head line (Shira Rekha)...',
      'Following the life line (Ayur Rekha)...',
      'Exploring the fate line (Bhagya Rekha)...',
      'Mapping planetary mounts and energy centers...',
      'Comparing left and right palms (Innate vs Manifested)...',
      'Synthesizing multi-dimensional palm profile...',
      'Generating your personalized Cosmic Palm Map...',
    ];

    for (int i = 0; i < stages.length; i++) {
      PalmReadingStatus status;
      if (i < 2) {
        status = PalmReadingStatus.analyzing;
      } else if (i < 7) {
        status = PalmReadingStatus.scanning;
      } else if (i == 7) {
        status = PalmReadingStatus.comparing;
      } else {
        status = PalmReadingStatus.generatingReport;
      }

      activeReading = activeReading.copyWith(
        status: status,
        currentStageIndex: i + 1,
        currentStageMessage: stages[i],
      );
      _readingsStore[readingId] = activeReading;
      _readingUpdatesController.add(activeReading);

      if (!fastModeForTests) {
        await Future.delayed(const Duration(milliseconds: 700));
      }
    }

    // Call vision provider for the full report synthesis
    final report = await _visionProvider.extractPalmFeatures(
      leftImagePath: activeReading.leftImagePath ?? 'mock_left.jpg',
      rightImagePath: activeReading.rightImagePath ?? 'mock_right.jpg',
      languageLocale: languageLocale,
    );

    final completed = activeReading.copyWith(
      status: PalmReadingStatus.completed,
      report: report,
      completedAt: DateTime.now(),
      currentStageIndex: 10,
      currentStageMessage: 'Your Palm Map is Ready',
    );

    _readingsStore[readingId] = completed;
    _readingUpdatesController.add(completed);
    return completed;
  }

  /// Fetch single reading by ID
  PalmReading? getReading(String readingId) {
    return _readingsStore[readingId];
  }

  /// Fetch all active readings for a user (excluding deleted)
  List<PalmReading> getUserReadings(String userId) {
    return _readingsStore.values
        .where((r) => r.userId == userId && r.status != PalmReadingStatus.deleted)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Delete a single reading irreversibly
  Future<bool> deleteReading(String readingId) async {
    final existing = _readingsStore[readingId];
    if (existing == null) return false;

    // Purge cached references and mark deleted
    final purged = existing.copyWith(
      status: PalmReadingStatus.deleted,
      deletedAt: DateTime.now(),
      leftImagePath: null,
      rightImagePath: null,
      report: null,
    );
    _readingsStore[readingId] = purged;
    _readingUpdatesController.add(purged);
    return true;
  }

  /// Purge all user Palmistry data (Hooked to GDPR / Privacy 15-step wipe)
  Future<int> purgeAllUserData(String userId) async {
    int purgedCount = 0;
    final keys = _readingsStore.keys.toList();
    for (final k in keys) {
      if (_readingsStore[k]?.userId == userId) {
        _readingsStore.remove(k);
        purgedCount++;
      }
    }
    debugPrint('[PalmistryService] Purged $purgedCount palmistry records for $userId');
    return purgedCount;
  }

  /// Seed initial reading if empty so user has instant testable data
  void seedSampleReadingIfEmpty(String userId) {
    if (getUserReadings(userId).isEmpty) {
      const sampleId = 'palm_sample_cosmic_01';
      final sampleSide = _visionProvider is MockAndAiPalmVisionProvider
          ? (_visionProvider as MockAndAiPalmVisionProvider)
          : MockAndAiPalmVisionProvider();

      sampleSide.extractPalmFeatures(
        leftImagePath: 'sample_left.jpg',
        rightImagePath: 'sample_right.jpg',
        languageLocale: 'en',
      ).then((rep) {
        _readingsStore[sampleId] = PalmReading(
          id: sampleId,
          userId: userId,
          status: PalmReadingStatus.completed,
          report: rep,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          completedAt: DateTime.now().subtract(const Duration(days: 1, minutes: 2)),
          currentStageIndex: 10,
          currentStageMessage: 'Your Palm Map is Ready',
        );
      });
    }
  }
}
