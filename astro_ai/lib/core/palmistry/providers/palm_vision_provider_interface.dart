// lib/core/palmistry/providers/palm_vision_provider_interface.dart
// ASTROAI OS v5.0 - Vision Provider Interface for AI Palmistry Line Extraction

import '../models/palm_reading_model.dart';

abstract class IPalmVisionProvider {
  String get providerId;
  String get modelName;

  /// Validates the uploaded palm image for clarity, lighting, orientation, and finger visibility.
  Future<PalmValidationResult> validatePalmImage({
    required String imagePath,
    required bool isLeftHand,
  });

  /// Extracts palm lines, mounts, element classifications, and comparative synthesis.
  Future<PalmReadingReport> extractPalmFeatures({
    required String leftImagePath,
    required String rightImagePath,
    required String languageLocale,
  });
}
