// shared/models/natal_matrix.dart
// AstroAI OS v4.0 - Core Vedic & Sidereal Ephemeris Models

enum AstrologicalSign {
  aries,
  taurus,
  gemini,
  cancer,
  leo,
  virgo,
  libra,
  scorpio,
  sagittarius,
  capricorn,
  aquarius,
  pisces;

  String get sanskritName {
    switch (this) {
      case AstrologicalSign.aries: return "Mesha";
      case AstrologicalSign.taurus: return "Vrishabha";
      case AstrologicalSign.gemini: return "Mithuna";
      case AstrologicalSign.cancer: return "Karka";
      case AstrologicalSign.leo: return "Simha";
      case AstrologicalSign.virgo: return "Kanya";
      case AstrologicalSign.libra: return "Tula";
      case AstrologicalSign.scorpio: return "Vrischika";
      case AstrologicalSign.sagittarius: return "Dhanu";
      case AstrologicalSign.capricorn: return "Makara";
      case AstrologicalSign.aquarius: return "Kumbha";
      case AstrologicalSign.pisces: return "Meena";
    }
  }

  String get shortCode => name.substring(0, 3).toUpperCase();
}

enum GrahaDignity {
  exalted,
  moolatrikona,
  ownSign,
  greatFriend,
  friend,
  neutral,
  enemy,
  greatEnemy,
  debilitated
}

class GrahaPosition {
  final String id;
  final String name;
  final String sanskritName;
  final String glyph;
  final AstrologicalSign sign;
  final double degree;
  final String degreeDms;
  final String nakshatra;
  final int pada;
  final int house;
  final bool isRetrograde;
  final bool isCombust;
  final GrahaDignity dignity;
  final double shadbalaPercentile;

  const GrahaPosition({
    required this.id,
    required this.name,
    required this.sanskritName,
    required this.glyph,
    required this.sign,
    required this.degree,
    required this.degreeDms,
    required this.nakshatra,
    required this.pada,
    required this.house,
    required this.isRetrograde,
    required this.isCombust,
    required this.dignity,
    required this.shadbalaPercentile,
  });
}

class HousePosition {
  final int houseNumber;
  final String bhavaName;
  final String sanskritDescription;
  final AstrologicalSign rashi;
  final List<String> residentGrahaIds;
  final String activeYoga;
  final String significance;

  const HousePosition({
    required this.houseNumber,
    required this.bhavaName,
    required this.sanskritDescription,
    required this.rashi,
    required this.residentGrahaIds,
    required this.activeYoga,
    required this.significance,
  });
}

class NatalMatrix {
  final String seekerName;
  final DateTime birthTimeUtc;
  final double latitude;
  final double longitude;
  final double altitude;
  final String timezoneIana;
  final double lahiriAyanamsa;
  final Map<String, GrahaPosition> grahas;
  final List<HousePosition> houses;
  final String activeMahadasha;
  final String activeAntardasha;
  final String activePratyantardasha;

  const NatalMatrix({
    required this.seekerName,
    required this.birthTimeUtc,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.timezoneIana,
    required this.lahiriAyanamsa,
    required this.grahas,
    required this.houses,
    required this.activeMahadasha,
    required this.activeAntardasha,
    required this.activePratyantardasha,
  });
}
