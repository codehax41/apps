// lib/shared/engine/3d/astrolabe_3d_engine.dart
// ASTROAI OS v5.0 - Interactive 3D Astro-Natal Astrolabe & Dimensional Portal Engine (D1 -> D9 -> D10)

import 'package:flutter/material.dart';

enum AstrolabeDimension {
  d1Rashi,
  d9Navamsa,
  d10Dasamsa,
}

enum AspectType {
  conjunction, // 0°
  kendra,      // 90° (Square / 4th, 7th, 10th)
  trikona,     // 120° (Trine / 5th, 9th)
  opposition,  // 180° (Saptama)
}

class AstrolabePlanetNode {
  final String id;
  final String name;
  final String sanskritName;
  final String symbol;
  final double eclipticLongitude; // 0° to 360°
  final int rashiIndex;          // 0 to 11 (Aries to Pisces)
  final String nakshatra;
  final int houseNumber;         // 1 to 12
  final Color baseColor;
  final Color emissiveColor;
  final double radius;
  final bool hasRing;            // For Saturn

  const AstrolabePlanetNode({
    required this.id,
    required this.name,
    required this.sanskritName,
    required this.symbol,
    required this.eclipticLongitude,
    required this.rashiIndex,
    required this.nakshatra,
    required this.houseNumber,
    required this.baseColor,
    required this.emissiveColor,
    this.radius = 8.0,
    this.hasRing = false,
  });
}

class AstrolabeAspectConnection {
  final AstrolabePlanetNode planetA;
  final AstrolabePlanetNode planetB;
  final AspectType type;
  final double angleDifference;

  const AstrolabeAspectConnection({
    required this.planetA,
    required this.planetB,
    required this.type,
    required this.angleDifference,
  });
}

class Astrolabe3DEngine {
  // Pre-configured Planetary Ephemeris for D1 Rashi Chart
  static const List<AstrolabePlanetNode> d1Planets = [
    AstrolabePlanetNode(
      id: "sun",
      name: "Sun",
      sanskritName: "Surya",
      symbol: "☉",
      eclipticLongitude: 167.4, // Virgo 17°24' (8th House)
      rashiIndex: 5,
      nakshatra: "Hasta Pada 3",
      houseNumber: 8,
      baseColor: Color(0xFFF59E0B),
      emissiveColor: Color(0xFFFDE68A),
      radius: 11.0,
    ),
    AstrolabePlanetNode(
      id: "moon",
      name: "Moon",
      sanskritName: "Chandra",
      symbol: "☽",
      eclipticLongitude: 44.8, // Taurus 14°48' (4th House - Exalted)
      rashiIndex: 1,
      nakshatra: "Rohini Pada 2",
      houseNumber: 4,
      baseColor: Color(0xFFE2E8F0),
      emissiveColor: Color(0xFFFFFFFF),
      radius: 9.5,
    ),
    AstrolabePlanetNode(
      id: "mars",
      name: "Mars",
      sanskritName: "Mangal",
      symbol: "♂",
      eclipticLongitude: 232.1, // Scorpio 22°06' (10th House - Digbala Peak)
      rashiIndex: 7,
      nakshatra: "Jyeshtha Pada 2",
      houseNumber: 10,
      baseColor: Color(0xFFEF4444),
      emissiveColor: Color(0xFFFCA5A5),
      radius: 8.5,
    ),
    AstrolabePlanetNode(
      id: "mercury",
      name: "Mercury",
      sanskritName: "Budha",
      symbol: "☿",
      eclipticLongitude: 312.5, // Aquarius 12°30' (1st House)
      rashiIndex: 10,
      nakshatra: "Shatabhisha Pada 2",
      houseNumber: 1,
      baseColor: Color(0xFF10B981),
      emissiveColor: Color(0xFF6EE7B7),
      radius: 8.0,
    ),
    AstrolabePlanetNode(
      id: "jupiter",
      name: "Jupiter",
      sanskritName: "Guru",
      symbol: "♃",
      eclipticLongitude: 308.2, // Aquarius 08°12' (1st House - Gajakesari)
      rashiIndex: 10,
      nakshatra: "Shatabhisha Pada 1",
      houseNumber: 1,
      baseColor: Color(0xFFFBBF24),
      emissiveColor: Color(0xFFFEF3C7),
      radius: 12.5,
    ),
    AstrolabePlanetNode(
      id: "venus",
      name: "Venus",
      sanskritName: "Shukra",
      symbol: "♀",
      eclipticLongitude: 226.7, // Scorpio 16°42' (10th House)
      rashiIndex: 7,
      nakshatra: "Anuradha Pada 4",
      houseNumber: 10,
      baseColor: Color(0xFFF472B6),
      emissiveColor: Color(0xFFFCE7F3),
      radius: 9.0,
    ),
    AstrolabePlanetNode(
      id: "saturn",
      name: "Saturn",
      sanskritName: "Shani",
      symbol: "♄",
      eclipticLongitude: 12.3, // Aries 12°18' (3rd House)
      rashiIndex: 0,
      nakshatra: "Ashwini Pada 4",
      houseNumber: 3,
      baseColor: Color(0xFF6366F1),
      emissiveColor: Color(0xFFA5B4FC),
      radius: 10.0,
      hasRing: true,
    ),
    AstrolabePlanetNode(
      id: "rahu",
      name: "Rahu",
      sanskritName: "Rahu",
      symbol: "☊",
      eclipticLongitude: 142.1, // Leo 22°06' (7th House Axis)
      rashiIndex: 4,
      nakshatra: "Purva Phalguni",
      houseNumber: 7,
      baseColor: Color(0xFF8B5CF6),
      emissiveColor: Color(0xFFDDD6FE),
      radius: 7.5,
    ),
    AstrolabePlanetNode(
      id: "ketu",
      name: "Ketu",
      sanskritName: "Ketu",
      symbol: "☋",
      eclipticLongitude: 322.1, // Aquarius 22°06' (1st House Axis)
      rashiIndex: 10,
      nakshatra: "Purva Bhadrapada",
      houseNumber: 1,
      baseColor: Color(0xFF06B6D4),
      emissiveColor: Color(0xFFCFFAFE),
      radius: 7.5,
    ),
  ];

  // Pre-configured Planetary Ephemeris for D9 Navamsa Chart
  static const List<AstrolabePlanetNode> d9Planets = [
    AstrolabePlanetNode(
      id: "sun",
      name: "Sun (D9)",
      sanskritName: "Surya",
      symbol: "☉",
      eclipticLongitude: 66.6, // Gemini Navamsa (5th)
      rashiIndex: 2,
      nakshatra: "Punarvasu",
      houseNumber: 5,
      baseColor: Color(0xFFF59E0B),
      emissiveColor: Color(0xFFFDE68A),
      radius: 11.0,
    ),
    AstrolabePlanetNode(
      id: "moon",
      name: "Moon (D9)",
      sanskritName: "Chandra",
      symbol: "☽",
      eclipticLongitude: 44.8, // Taurus Navamsa (Vargottama)
      rashiIndex: 1,
      nakshatra: "Rohini",
      houseNumber: 4,
      baseColor: Color(0xFFE2E8F0),
      emissiveColor: Color(0xFFFFFFFF),
      radius: 9.5,
    ),
    AstrolabePlanetNode(
      id: "mars",
      name: "Mars (D9)",
      sanskritName: "Mangal",
      symbol: "♂",
      eclipticLongitude: 278.8, // Capricorn Navamsa (Exalted)
      rashiIndex: 9,
      nakshatra: "Uttara Ashadha",
      houseNumber: 12,
      baseColor: Color(0xFFEF4444),
      emissiveColor: Color(0xFFFCA5A5),
      radius: 8.5,
    ),
    AstrolabePlanetNode(
      id: "mercury",
      name: "Mercury (D9)",
      sanskritName: "Budha",
      symbol: "☿",
      eclipticLongitude: 152.5, // Virgo Navamsa (Exalted)
      rashiIndex: 5,
      nakshatra: "Hasta",
      houseNumber: 8,
      baseColor: Color(0xFF10B981),
      emissiveColor: Color(0xFF6EE7B7),
      radius: 8.0,
    ),
    AstrolabePlanetNode(
      id: "jupiter",
      name: "Jupiter (D9)",
      sanskritName: "Guru",
      symbol: "♃",
      eclipticLongitude: 98.2, // Cancer Navamsa (Exalted)
      rashiIndex: 3,
      nakshatra: "Pushya",
      houseNumber: 6,
      baseColor: Color(0xFFFBBF24),
      emissiveColor: Color(0xFFFEF3C7),
      radius: 12.5,
    ),
    AstrolabePlanetNode(
      id: "saturn",
      name: "Saturn (D9)",
      sanskritName: "Shani",
      symbol: "♄",
      eclipticLongitude: 188.0, // Libra Navamsa (Exalted)
      rashiIndex: 6,
      nakshatra: "Swati",
      houseNumber: 9,
      baseColor: Color(0xFF6366F1),
      emissiveColor: Color(0xFFA5B4FC),
      radius: 10.0,
      hasRing: true,
    ),
  ];

  // Pre-configured Planetary Ephemeris for D10 Dasamsa Chart
  static const List<AstrolabePlanetNode> d10Planets = [
    AstrolabePlanetNode(
      id: "sun",
      name: "Sun (D10)",
      sanskritName: "Surya",
      symbol: "☉",
      eclipticLongitude: 10.0, // Aries 10th House
      rashiIndex: 0,
      nakshatra: "Ashwini",
      houseNumber: 10,
      baseColor: Color(0xFFF59E0B),
      emissiveColor: Color(0xFFFDE68A),
      radius: 11.0,
    ),
    AstrolabePlanetNode(
      id: "mars",
      name: "Mars (D10)",
      sanskritName: "Mangal",
      symbol: "♂",
      eclipticLongitude: 280.0, // Capricorn (Karma Ruler)
      rashiIndex: 9,
      nakshatra: "Shravana",
      houseNumber: 10,
      baseColor: Color(0xFFEF4444),
      emissiveColor: Color(0xFFFCA5A5),
      radius: 8.5,
    ),
    AstrolabePlanetNode(
      id: "jupiter",
      name: "Jupiter (D10)",
      sanskritName: "Guru",
      symbol: "♃",
      eclipticLongitude: 100.0, // Cancer 10th House
      rashiIndex: 3,
      nakshatra: "Pushya",
      houseNumber: 1,
      baseColor: Color(0xFFFBBF24),
      emissiveColor: Color(0xFFFEF3C7),
      radius: 12.5,
    ),
    AstrolabePlanetNode(
      id: "mercury",
      name: "Mercury (D10)",
      sanskritName: "Budha",
      symbol: "☿",
      eclipticLongitude: 160.0, // Virgo (Systems Master)
      rashiIndex: 5,
      nakshatra: "Chitra",
      houseNumber: 3,
      baseColor: Color(0xFF10B981),
      emissiveColor: Color(0xFF6EE7B7),
      radius: 8.0,
    ),
  ];

  // Zodiac Sector Metadata (12 Signs, 30° each)
  static const List<Map<String, dynamic>> zodiacSectors = [
    {"name": "Aries", "sanskrit": "Mesha", "symbol": "♈", "element": "Fire", "color": Color(0xFFEF4444)},
    {"name": "Taurus", "sanskrit": "Vrishabha", "symbol": "♉", "element": "Earth", "color": Color(0xFF10B981)},
    {"name": "Gemini", "sanskrit": "Mithuna", "symbol": "♊", "element": "Air", "color": Color(0xFFFBBF24)},
    {"name": "Cancer", "sanskrit": "Karka", "symbol": "♋", "element": "Water", "color": Color(0xFF38BDF8)},
    {"name": "Leo", "sanskrit": "Simha", "symbol": "♌", "element": "Fire", "color": Color(0xFFF59E0B)},
    {"name": "Virgo", "sanskrit": "Kanya", "symbol": "♍", "element": "Earth", "color": Color(0xFF10B981)},
    {"name": "Libra", "sanskrit": "Tula", "symbol": "♎", "element": "Air", "color": Color(0xFFF472B6)},
    {"name": "Scorpio", "sanskrit": "Vrishchika", "symbol": "♏", "element": "Water", "color": Color(0xFFDC2626)},
    {"name": "Sagittarius", "sanskrit": "Dhanu", "symbol": "♐", "element": "Fire", "color": Color(0xFF8B5CF6)},
    {"name": "Capricorn", "sanskrit": "Makara", "symbol": "♑", "element": "Earth", "color": Color(0xFF6366F1)},
    {"name": "Aquarius", "sanskrit": "Kumbha", "symbol": "♒", "element": "Air", "color": Color(0xFF06B6D4)},
    {"name": "Pisces", "sanskrit": "Meena", "symbol": "♓", "element": "Water", "color": Color(0xFFA855F7)},
  ];

  // Computes Dynamic Aspect Connections across planets
  static List<AstrolabeAspectConnection> computeAspects(List<AstrolabePlanetNode> planets) {
    final List<AstrolabeAspectConnection> aspects = [];
    for (int i = 0; i < planets.length; i++) {
      for (int j = i + 1; j < planets.length; j++) {
        final pA = planets[i];
        final pB = planets[j];
        double diff = (pA.eclipticLongitude - pB.eclipticLongitude).abs();
        if (diff > 180.0) diff = 360.0 - diff;

        // Conjunction (0° ± 8°)
        if (diff <= 8.0) {
          aspects.add(AstrolabeAspectConnection(planetA: pA, planetB: pB, type: AspectType.conjunction, angleDifference: diff));
        }
        // Kendra / Square (90° ± 6°)
        else if ((diff - 90.0).abs() <= 6.0) {
          aspects.add(AstrolabeAspectConnection(planetA: pA, planetB: pB, type: AspectType.kendra, angleDifference: diff));
        }
        // Trikona / Trine (120° ± 6°)
        else if ((diff - 120.0).abs() <= 6.0) {
          aspects.add(AstrolabeAspectConnection(planetA: pA, planetB: pB, type: AspectType.trikona, angleDifference: diff));
        }
        // Saptama / Opposition (180° ± 7°)
        else if ((diff - 180.0).abs() <= 7.0) {
          aspects.add(AstrolabeAspectConnection(planetA: pA, planetB: pB, type: AspectType.opposition, angleDifference: diff));
        }
      }
    }
    return aspects;
  }

  // Gets Z-height for a given dimensional stratum
  static double getDimensionZ(AstrolabeDimension dimension) {
    switch (dimension) {
      case AstrolabeDimension.d1Rashi:
        return 0.0;
      case AstrolabeDimension.d9Navamsa:
        return 220.0;
      case AstrolabeDimension.d10Dasamsa:
        return 440.0;
    }
  }

  // Gets planetary list for a given dimension
  static List<AstrolabePlanetNode> getPlanetsForDimension(AstrolabeDimension dimension) {
    switch (dimension) {
      case AstrolabeDimension.d1Rashi:
        return d1Planets;
      case AstrolabeDimension.d9Navamsa:
        return d9Planets;
      case AstrolabeDimension.d10Dasamsa:
        return d10Planets;
    }
  }
}
