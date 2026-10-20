// lib/core/entitlements/entitlement_model.dart
// ASTROAI OS v5.0 - Plan Specifications & Entitlement Architecture

enum PlanTier {
  free,
  trial1Day7Inr,
  monthlyPro,
  yearlyVip,
}

class PlanDefinition {
  final PlanTier tier;
  final String id;
  final String name;
  final int priceInr;
  final int durationHours;
  final int voiceLimitSeconds; // 1800 for 1-day pass (30 mins)
  final List<String> features;

  const PlanDefinition({
    required this.tier,
    required this.id,
    required this.name,
    required this.priceInr,
    required this.durationHours,
    required this.voiceLimitSeconds,
    required this.features,
  });
}

class EntitlementCatalog {
  static const PlanDefinition freePlan = PlanDefinition(
    tier: PlanTier.free,
    id: "plan_free",
    name: "Free Cosmologist",
    priceInr: 0,
    durationHours: 0,
    voiceLimitSeconds: 0,
    features: [
      "Basic Vedic Natal Chart (D1)",
      "Daily Transit Highlights",
      "Standard Text AI Divination",
    ],
  );

  static const PlanDefinition trial1Day7Inr = PlanDefinition(
    tier: PlanTier.trial1Day7Inr,
    id: "trial_1_day_7_inr",
    name: "1-Day Astro AI Pass",
    priceInr: 7,
    durationHours: 24,
    voiceLimitSeconds: 1800, // 30 minutes hard server cap
    features: [
      "Full 24-Hour 3D Cosmic System Access",
      "30 Minutes Real-Time AI Voice with Devi",
      "Vedic Kundali, Navamsa (D9) & Dasamsa (D10)",
      "Ashtakoota 36-Point Karmic Synastry",
      "Precision Muhurta & Panchang Telemetry",
    ],
  );

  static const PlanDefinition monthlyPro = PlanDefinition(
    tier: PlanTier.monthlyPro,
    id: "plan_monthly_pro",
    name: "AstroAI Plus Monthly",
    priceInr: 499,
    durationHours: 720,
    voiceLimitSeconds: 18000, // 300 minutes
    features: [
      "300 Minutes Real-Time AI Voice",
      "Full 3D Planetary Ephemeris Suite",
      "Unlimited Kundali & Synastry Reports",
      "Priority Devi Oracle Neural Route",
    ],
  );
}
