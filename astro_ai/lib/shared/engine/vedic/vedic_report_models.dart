// lib/shared/engine/vedic/vedic_report_models.dart
// AstroAI OS v4.2 - Comprehensive Vedic Models for 100+ Free Reports

enum VedicSystemId {
  basic,
  dasha,
  kpSystem,
  shodashvarga,
  lalKitab,
  varshphal,
}

enum VedicReportId {
  lifePredictions,
  monthlyPredictions,
  dailyPredictions,
  mangalDosh,
  sadeSatiLifeReport,
  kaalSarpDosha,
  lalKitabDebt,
  lalKitabTevaType,
  lalKitabRemedies,
  ascendantPrediction,
  planetConsideration,
  gemstonesReport,
  transitToday,
  mahadashaPhala,
}

class VedicSystemTileModel {
  final VedicSystemId id;
  final String title;
  final String subtitle;
  final String iconGlyph;
  final String categoryTag;

  const VedicSystemTileModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconGlyph,
    required this.categoryTag,
  });
}

class VedicReportItemModel {
  final VedicReportId id;
  final String title;
  final String category;
  final String shortDescription;
  final String badgeText;
  final bool isFree;

  const VedicReportItemModel({
    required this.id,
    required this.title,
    required this.category,
    required this.shortDescription,
    this.badgeText = "FREE",
    this.isFree = true,
  });
}

// Vimshottari Dasha Model
class DashaPeriodInfo {
  final String planetName;
  final String sanskritName;
  final DateTime startDate;
  final DateTime endDate;
  final double score;
  final String lifeFocus;
  final String keyPrediction;
  final bool isCurrent;

  const DashaPeriodInfo({
    required this.planetName,
    required this.sanskritName,
    required this.startDate,
    required this.endDate,
    required this.score,
    required this.lifeFocus,
    required this.keyPrediction,
    this.isCurrent = false,
  });
}

// Mangal Dosha Model
class MangalDoshaAnalysis {
  final bool isManglik;
  final String doshaType; // Anshik (Partial), Purna (Complete), or Nirvikara (No Dosha)
  final int marsHouse;
  final double severityPercent;
  final bool isCancelled;
  final List<String> cancellationReasons;
  final String marriageImpact;
  final List<String> remedies;

  const MangalDoshaAnalysis({
    required this.isManglik,
    required this.doshaType,
    required this.marsHouse,
    required this.severityPercent,
    required this.isCancelled,
    required this.cancellationReasons,
    required this.marriageImpact,
    required this.remedies,
  });
}

// Sade Sati Model
class SadeSatiAnalysis {
  final bool isUnderSadeSati;
  final String currentPhase; // Rising (Chadhti), Peak (Madhyama), Setting (Utarti), or Non-active
  final String dhaiyaStatus; // Ashtama Shani, Kantaka Shani, or None
  final String saturnCurrentSign;
  final String moonSign;
  final String cycleNumber; // 1st Cycle, 2nd Cycle, 3rd Cycle
  final List<Map<String, String>> timelineDates;
  final String lifeImpactSummary;
  final List<String> remedies;

  const SadeSatiAnalysis({
    required this.isUnderSadeSati,
    required this.currentPhase,
    required this.dhaiyaStatus,
    required this.saturnCurrentSign,
    required this.moonSign,
    required this.cycleNumber,
    required this.timelineDates,
    required this.lifeImpactSummary,
    required this.remedies,
  });
}

// Kaal Sarp Dosha Model
class KaalSarpAnalysis {
  final bool isKaalSarpPresent;
  final String yogaName; // Anant, Kulik, Vasuki, Shankhpal, Padma, Mahapadma, Takshak, Karkotak, Shankhachood, Ghatak, Vishdhar, Sheshnag
  final int rahuHouse;
  final int ketuHouse;
  final String direction; // Udit (Ascending) or Anudit (Descending)
  final double severityScore;
  final String impactDomain;
  final List<String> remedies;

  const KaalSarpAnalysis({
    required this.isKaalSarpPresent,
    required this.yogaName,
    required this.rahuHouse,
    required this.ketuHouse,
    required this.direction,
    required this.severityScore,
    required this.impactDomain,
    required this.remedies,
  });
}

// Gemstone Recommendation Model
class GemstonePrescription {
  final String stoneType; // Life Stone (Lagnesha), Lucky Stone (Bhagyesh), Benefic Stone (Panchmesh)
  final String gemstoneName;
  final String hindiName;
  final String rulingPlanet;
  final String recommendedWeight;
  final String idealMetal;
  final String fingerToWear;
  final String auspiciousDayAndTime;
  final String activationMantra;
  final String primaryBenefits;
  final List<String> strictlyForbiddenStones;

  const GemstonePrescription({
    required this.stoneType,
    required this.gemstoneName,
    required this.hindiName,
    required this.rulingPlanet,
    required this.recommendedWeight,
    required this.idealMetal,
    required this.fingerToWear,
    required this.auspiciousDayAndTime,
    required this.activationMantra,
    required this.primaryBenefits,
    required this.strictlyForbiddenStones,
  });
}

// Lal Kitab Debt (Rina) Model
class LalKitabDebtItem {
  final String debtName;
  final String sanskritName;
  final String causePlanet;
  final bool isIdentified;
  final String ancestralCause;
  final String lifeSymptoms;
  final String remedyInstruction;

  const LalKitabDebtItem({
    required this.debtName,
    required this.sanskritName,
    required this.causePlanet,
    required this.isIdentified,
    required this.ancestralCause,
    required this.lifeSymptoms,
    required this.remedyInstruction,
  });
}

// Shodashvarga Chart Model
class ShodashvargaChartItem {
  final String vargaCode; // D1, D2, D3, D4, D7, D9, D10, D12, D16, D20, D24, D27, D30, D40, D45, D60
  final String sanskritName;
  final String divisionalTitle;
  final String primarySignificance;
  final String lagnaSign;
  final Map<String, String> planetHouseMap;
  final double dignityScore;

  const ShodashvargaChartItem({
    required this.vargaCode,
    required this.sanskritName,
    required this.divisionalTitle,
    required this.primarySignificance,
    required this.lagnaSign,
    required this.planetHouseMap,
    required this.dignityScore,
  });
}

// KP System Model
class KpSubLordItem {
  final int cuspNumber;
  final String zodiacSign;
  final double cuspDegree;
  final String signLord;
  final String nakshatraLord;
  final String subLord;
  final String subSubLord;

  const KpSubLordItem({
    required this.cuspNumber,
    required this.zodiacSign,
    required this.cuspDegree,
    required this.signLord,
    required this.nakshatraLord,
    required this.subLord,
    required this.subSubLord,
  });
}

// Unified Dossier Data for Detail Screen
class VedicReportDossierData {
  final String reportTitle;
  final String sanskritTitle;
  final String categoryTag;
  final String classicalShloka;
  final String shlokaMeaning;
  final String executiveSummary;
  final Map<String, String> coreMetrics;
  final List<String> detailedSections;
  final List<String> recommendations;
  final List<String> omAiPrompts;

  const VedicReportDossierData({
    required this.reportTitle,
    required this.sanskritTitle,
    required this.categoryTag,
    required this.classicalShloka,
    required this.shlokaMeaning,
    required this.executiveSummary,
    required this.coreMetrics,
    required this.detailedSections,
    required this.recommendations,
    required this.omAiPrompts,
  });
}
