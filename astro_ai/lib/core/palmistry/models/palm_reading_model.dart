// lib/core/palmistry/models/palm_reading_model.dart
// ASTROAI OS v5.0 - Typed AI Palmistry Domain Model & Telemetry Structures

import 'dart:ui' show Offset;

enum PalmReadingStatus {
  uploaded,
  validating,
  validated,
  analyzing,
  scanning,
  comparing,
  generatingReport,
  completed,
  failed,
  deleted;

  static PalmReadingStatus fromString(String val) {
    return PalmReadingStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == val.toLowerCase() ||
             e.name.toLowerCase() == val.replaceAll('_', '').toLowerCase(),
      orElse: () => PalmReadingStatus.uploaded,
    );
  }

  String toDisplayString() {
    switch (this) {
      case PalmReadingStatus.uploaded:
        return 'Images Uploaded';
      case PalmReadingStatus.validating:
        return 'Validating Clarity';
      case PalmReadingStatus.validated:
        return 'Palms Calibrated';
      case PalmReadingStatus.analyzing:
        return 'Analyzing Lines';
      case PalmReadingStatus.scanning:
        return 'Spatial Laser Mapping';
      case PalmReadingStatus.comparing:
        return 'Synchronizing Left & Right';
      case PalmReadingStatus.generatingReport:
        return 'Synthesizing Dossier';
      case PalmReadingStatus.completed:
        return 'Palm Map Complete';
      case PalmReadingStatus.failed:
        return 'Analysis Interrupted';
      case PalmReadingStatus.deleted:
        return 'Purged';
    }
  }
}

class PalmLinePoint {
  final double x; // 0.0 to 1.0 (normalized across palm bounding box)
  final double y; // 0.0 to 1.0
  final double z; // 0.0 to 1.0 depth factor

  const PalmLinePoint({required this.x, required this.y, this.z = 0.0});

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'z': z};

  factory PalmLinePoint.fromJson(Map<String, dynamic> json) => PalmLinePoint(
        x: (json['x'] as num).toDouble(),
        y: (json['y'] as num).toDouble(),
        z: (json['z'] as num?)?.toDouble() ?? 0.0,
      );

  Offset toOffset(double width, double height) => Offset(x * width, y * height);
}

class PalmLineFeature {
  final String id;
  final String name; // e.g., "Heart Line", "Head Line", "Life Line", "Fate Line"
  final String sanskritName; // e.g., "Hridaya Rekha", "Shira Rekha", "Ayur Rekha"
  final bool visible;
  final double confidence; // 0.0 to 1.0
  final String observedPattern;
  final String traditionalMeaning;
  final String aiNarrative;
  final List<PalmLinePoint> pathPoints;
  final String colorHex;

  const PalmLineFeature({
    required this.id,
    required this.name,
    required this.sanskritName,
    required this.visible,
    required this.confidence,
    required this.observedPattern,
    required this.traditionalMeaning,
    required this.aiNarrative,
    required this.pathPoints,
    this.colorHex = '#FF69B4',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sanskritName': sanskritName,
        'visible': visible,
        'confidence': confidence,
        'observedPattern': observedPattern,
        'traditionalMeaning': traditionalMeaning,
        'aiNarrative': aiNarrative,
        'pathPoints': pathPoints.map((p) => p.toJson()).toList(),
        'colorHex': colorHex,
      };

  factory PalmLineFeature.fromJson(Map<String, dynamic> json) => PalmLineFeature(
        id: json['id'] as String? ?? 'line',
        name: json['name'] as String? ?? 'Line',
        sanskritName: json['sanskritName'] as String? ?? '',
        visible: json['visible'] as bool? ?? true,
        confidence: (json['confidence'] as num?)?.toDouble() ?? 0.85,
        observedPattern: json['observedPattern'] as String? ?? '',
        traditionalMeaning: json['traditionalMeaning'] as String? ?? '',
        aiNarrative: json['aiNarrative'] as String? ?? '',
        pathPoints: (json['pathPoints'] as List<dynamic>?)
                ?.map((e) => PalmLinePoint.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        colorHex: json['colorHex'] as String? ?? '#FF69B4',
      );
}

class PalmMount {
  final String name; // e.g. "Mount of Jupiter", "Mount of Venus"
  final String planetVedic; // "Guru (Brihaspati)", "Shukra"
  final String prominence; // "Prominent & Elevated", "Balanced", "Understated"
  final String traditionalSignificance;
  final PalmLinePoint centerPoint;

  const PalmMount({
    required this.name,
    required this.planetVedic,
    required this.prominence,
    required this.traditionalSignificance,
    required this.centerPoint,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'planetVedic': planetVedic,
        'prominence': prominence,
        'traditionalSignificance': traditionalSignificance,
        'centerPoint': centerPoint.toJson(),
      };

  factory PalmMount.fromJson(Map<String, dynamic> json) => PalmMount(
        name: json['name'] as String? ?? 'Mount',
        planetVedic: json['planetVedic'] as String? ?? '',
        prominence: json['prominence'] as String? ?? 'Balanced',
        traditionalSignificance: json['traditionalSignificance'] as String? ?? '',
        centerPoint: json['centerPoint'] != null
            ? PalmLinePoint.fromJson(json['centerPoint'] as Map<String, dynamic>)
            : const PalmLinePoint(x: 0.5, y: 0.5),
      );
}

class PalmSideAnalysis {
  final bool isLeft;
  final double qualityScore; // 0.0 to 1.0
  final String palmElement; // Fire, Earth, Air, Water
  final String fingerProportions;
  final PalmLineFeature heartLine;
  final PalmLineFeature headLine;
  final PalmLineFeature lifeLine;
  final PalmLineFeature fateLine;
  final PalmLineFeature? sunLine;
  final List<PalmMount> mounts;

  const PalmSideAnalysis({
    required this.isLeft,
    required this.qualityScore,
    required this.palmElement,
    required this.fingerProportions,
    required this.heartLine,
    required this.headLine,
    required this.lifeLine,
    required this.fateLine,
    this.sunLine,
    required this.mounts,
  });

  Map<String, dynamic> toJson() => {
        'isLeft': isLeft,
        'qualityScore': qualityScore,
        'palmElement': palmElement,
        'fingerProportions': fingerProportions,
        'heartLine': heartLine.toJson(),
        'headLine': headLine.toJson(),
        'lifeLine': lifeLine.toJson(),
        'fateLine': fateLine.toJson(),
        if (sunLine != null) 'sunLine': sunLine!.toJson(),
        'mounts': mounts.map((m) => m.toJson()).toList(),
      };

  factory PalmSideAnalysis.fromJson(Map<String, dynamic> json) => PalmSideAnalysis(
        isLeft: json['isLeft'] as bool? ?? false,
        qualityScore: (json['qualityScore'] as num?)?.toDouble() ?? 0.9,
        palmElement: json['palmElement'] as String? ?? 'Earth',
        fingerProportions: json['fingerProportions'] as String? ?? 'Balanced and conical',
        heartLine: PalmLineFeature.fromJson(json['heartLine'] as Map<String, dynamic>),
        headLine: PalmLineFeature.fromJson(json['headLine'] as Map<String, dynamic>),
        lifeLine: PalmLineFeature.fromJson(json['lifeLine'] as Map<String, dynamic>),
        fateLine: PalmLineFeature.fromJson(json['fateLine'] as Map<String, dynamic>),
        sunLine: json['sunLine'] != null
            ? PalmLineFeature.fromJson(json['sunLine'] as Map<String, dynamic>)
            : null,
        mounts: (json['mounts'] as List<dynamic>?)
                ?.map((e) => PalmMount.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

class PalmComparison {
  final String summary;
  final String innatePotentialLeft;
  final String manifestedRealityRight;
  final List<String> keyDivergences;
  final List<String> harmonicAlignments;

  const PalmComparison({
    required this.summary,
    required this.innatePotentialLeft,
    required this.manifestedRealityRight,
    required this.keyDivergences,
    required this.harmonicAlignments,
  });

  Map<String, dynamic> toJson() => {
        'summary': summary,
        'innatePotentialLeft': innatePotentialLeft,
        'manifestedRealityRight': manifestedRealityRight,
        'keyDivergences': keyDivergences,
        'harmonicAlignments': harmonicAlignments,
      };

  factory PalmComparison.fromJson(Map<String, dynamic> json) => PalmComparison(
        summary: json['summary'] as String? ?? '',
        innatePotentialLeft: json['innatePotentialLeft'] as String? ?? '',
        manifestedRealityRight: json['manifestedRealityRight'] as String? ?? '',
        keyDivergences: (json['keyDivergences'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        harmonicAlignments: (json['harmonicAlignments'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      );
}

class PalmReadingReport {
  final String title;
  final String overview;
  final PalmSideAnalysis leftPalm;
  final PalmSideAnalysis rightPalm;
  final PalmComparison comparison;
  final List<String> strengthsAndThemes;
  final List<String> areasOfReflection;
  final String overallSummary;
  final String disclaimer;

  const PalmReadingReport({
    required this.title,
    required this.overview,
    required this.leftPalm,
    required this.rightPalm,
    required this.comparison,
    required this.strengthsAndThemes,
    required this.areasOfReflection,
    required this.overallSummary,
    this.disclaimer = 'This AI palmistry report offers reflective traditional interpretations based on classical Vedic Samudrika Shastra. It does not provide medical, diagnostic, or fatalistic predictions.',
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'overview': overview,
        'leftPalm': leftPalm.toJson(),
        'rightPalm': rightPalm.toJson(),
        'comparison': comparison.toJson(),
        'strengthsAndThemes': strengthsAndThemes,
        'areasOfReflection': areasOfReflection,
        'overallSummary': overallSummary,
        'disclaimer': disclaimer,
      };

  factory PalmReadingReport.fromJson(Map<String, dynamic> json) => PalmReadingReport(
        title: json['title'] as String? ?? 'Your Palm Map',
        overview: json['overview'] as String? ?? '',
        leftPalm: PalmSideAnalysis.fromJson(json['leftPalm'] as Map<String, dynamic>),
        rightPalm: PalmSideAnalysis.fromJson(json['rightPalm'] as Map<String, dynamic>),
        comparison: PalmComparison.fromJson(json['comparison'] as Map<String, dynamic>),
        strengthsAndThemes: (json['strengthsAndThemes'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        areasOfReflection: (json['areasOfReflection'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        overallSummary: json['overallSummary'] as String? ?? '',
        disclaimer: json['disclaimer'] as String? ?? '',
      );
}

class PalmReading {
  final String id;
  final String userId;
  final String? leftImagePath;
  final String? rightImagePath;
  final PalmReadingStatus status;
  final String analysisVersion;
  final PalmReadingReport? report;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? deletedAt;
  final int currentStageIndex;
  final String currentStageMessage;

  const PalmReading({
    required this.id,
    required this.userId,
    this.leftImagePath,
    this.rightImagePath,
    required this.status,
    this.analysisVersion = 'v5.0-spatial',
    this.report,
    required this.createdAt,
    this.completedAt,
    this.deletedAt,
    this.currentStageIndex = 0,
    this.currentStageMessage = 'Ready to scan',
  });

  PalmReading copyWith({
    String? id,
    String? userId,
    String? leftImagePath,
    String? rightImagePath,
    PalmReadingStatus? status,
    String? analysisVersion,
    PalmReadingReport? report,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? deletedAt,
    int? currentStageIndex,
    String? currentStageMessage,
  }) {
    return PalmReading(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      leftImagePath: leftImagePath ?? this.leftImagePath,
      rightImagePath: rightImagePath ?? this.rightImagePath,
      status: status ?? this.status,
      analysisVersion: analysisVersion ?? this.analysisVersion,
      report: report ?? this.report,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      currentStageIndex: currentStageIndex ?? this.currentStageIndex,
      currentStageMessage: currentStageMessage ?? this.currentStageMessage,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'leftImagePath': leftImagePath,
        'rightImagePath': rightImagePath,
        'status': status.name,
        'analysisVersion': analysisVersion,
        if (report != null) 'report': report!.toJson(),
        'createdAt': createdAt.toIso8601String(),
        if (completedAt != null) 'completedAt': completedAt!.toIso8601String(),
        if (deletedAt != null) 'deletedAt': deletedAt!.toIso8601String(),
        'currentStageIndex': currentStageIndex,
        'currentStageMessage': currentStageMessage,
      };

  factory PalmReading.fromJson(Map<String, dynamic> json) => PalmReading(
        id: json['id'] as String,
        userId: json['userId'] as String? ?? 'usr_default',
        leftImagePath: json['leftImagePath'] as String?,
        rightImagePath: json['rightImagePath'] as String?,
        status: PalmReadingStatus.fromString(json['status'] as String? ?? 'uploaded'),
        analysisVersion: json['analysisVersion'] as String? ?? 'v5.0-spatial',
        report: json['report'] != null
            ? PalmReadingReport.fromJson(json['report'] as Map<String, dynamic>)
            : null,
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
        completedAt: json['completedAt'] != null ? DateTime.tryParse(json['completedAt'] as String) : null,
        deletedAt: json['deletedAt'] != null ? DateTime.tryParse(json['deletedAt'] as String) : null,
        currentStageIndex: (json['currentStageIndex'] as num?)?.toInt() ?? 0,
        currentStageMessage: json['currentStageMessage'] as String? ?? '',
      );
}

class PalmValidationResult {
  final bool isValid;
  final bool isClear;
  final bool isLightingGood;
  final bool areFingersVisible;
  final double qualityScore; // 0.0 to 1.0
  final String feedbackMessage;
  final List<String> tips;

  const PalmValidationResult({
    required this.isValid,
    required this.isClear,
    required this.isLightingGood,
    required this.areFingersVisible,
    required this.qualityScore,
    required this.feedbackMessage,
    required this.tips,
  });

  Map<String, dynamic> toJson() => {
        'isValid': isValid,
        'isClear': isClear,
        'isLightingGood': isLightingGood,
        'areFingersVisible': areFingersVisible,
        'qualityScore': qualityScore,
        'feedbackMessage': feedbackMessage,
        'tips': tips,
      };
}
