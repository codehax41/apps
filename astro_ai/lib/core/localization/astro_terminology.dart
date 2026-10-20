// lib/core/localization/astro_terminology.dart
// ASTROAI OS v5.0 - Bilingual Vedic Astrology Terminology & Hinglish Conversational Dictionary

class AstroTerm {
  final String english;
  final String sanskrit;
  final String hindiScript;
  final String hinglishContext;
  final String definition;

  const AstroTerm({
    required this.english,
    required this.sanskrit,
    required this.hindiScript,
    required this.hinglishContext,
    required this.definition,
  });
}

class AstroTerminology {
  static const List<AstroTerm> terms = [
    AstroTerm(
      english: "Ascendant",
      sanskrit: "Lagna",
      hindiScript: "लग्न",
      hinglishContext: "Lagna (Ascendant)",
      definition: "The zodiac degree rising on the eastern horizon at the exact minute of birth.",
    ),
    AstroTerm(
      english: "Sun",
      sanskrit: "Surya",
      hindiScript: "सूर्य",
      hinglishContext: "Surya (Sun)",
      definition: "Soul significator (Atmakaraka), vitality, leadership, and ego structure.",
    ),
    AstroTerm(
      english: "Moon",
      sanskrit: "Chandra",
      hindiScript: "चन्द्र",
      hinglishContext: "Chandra (Moon)",
      definition: "Mind (Manas), emotional stability, perception, and Janma Nakshatra anchor.",
    ),
    AstroTerm(
      english: "Mars",
      sanskrit: "Mangal",
      hindiScript: "मंगल",
      hinglishContext: "Mangal (Mars)",
      definition: "Drive, courage, physical energy, real estate, and strategic execution.",
    ),
    AstroTerm(
      english: "Mercury",
      sanskrit: "Budha",
      hindiScript: "बुध",
      hinglishContext: "Budha (Mercury)",
      definition: "Intellect, business acumen, communication, logic, and analytical wit.",
    ),
    AstroTerm(
      english: "Jupiter",
      sanskrit: "Guru / Brihaspati",
      hindiScript: "गुरु",
      hinglishContext: "Guru (Jupiter)",
      definition: "Wisdom, expansion, dharma, wealth cycles (Dhana Yoga), and higher knowledge.",
    ),
    AstroTerm(
      english: "Venus",
      sanskrit: "Shukra",
      hindiScript: "शुक्र",
      hinglishContext: "Shukra (Venus)",
      definition: "Refinement, aesthetics, romantic synastry, luxury, and devotion.",
    ),
    AstroTerm(
      english: "Saturn",
      sanskrit: "Shani",
      hindiScript: "शनि",
      hinglishContext: "Shani (Saturn)",
      definition: "Discipline, karmic reckoning, time (Kala), perseverance, and career endurance.",
    ),
    AstroTerm(
      english: "North Lunar Node",
      sanskrit: "Rahu",
      hindiScript: "राहु",
      hinglishContext: "Rahu",
      definition: "Material ambition, obsession, disruptive innovation, and unfulfilled desires.",
    ),
    AstroTerm(
      english: "South Lunar Node",
      sanskrit: "Ketu",
      hindiScript: "केतु",
      hinglishContext: "Ketu",
      definition: "Spiritual liberation (Moksha), detachment, past-life mastery, and intuition.",
    ),
    AstroTerm(
      english: "9th Harmonic Divisional Chart",
      sanskrit: "Navamsa / D9",
      hindiScript: "नवांश (D9)",
      hinglishContext: "Navamsa (D9)",
      definition: "The internal chart of the soul's destiny, marriage fruit, and life second half.",
    ),
    AstroTerm(
      english: "10th Harmonic Career Chart",
      sanskrit: "Dasamsa / D10",
      hindiScript: "दशांश (D10)",
      hinglishContext: "Dasamsa (D10)",
      definition: "The divisional matrix governing professional legacy, status, and leadership pivots.",
    ),
    AstroTerm(
      english: "Major Planetary Period",
      sanskrit: "Mahadasha",
      hindiScript: "महादशा",
      hinglishContext: "Mahadasha",
      definition: "Vimshottari primary ruler governing extended 6 to 20 year life arcs.",
    ),
    AstroTerm(
      english: "Sub-Planetary Period",
      sanskrit: "Antardasha",
      hindiScript: "अन्तर्दशा",
      hinglishContext: "Antardasha",
      definition: "Secondary cycle activating granular quarterly events within the Mahadasha.",
    ),
    AstroTerm(
      english: "Lunar Mansion",
      sanskrit: "Nakshatra",
      hindiScript: "नक्षत्र",
      hinglishContext: "Nakshatra",
      definition: "One of the 27 equal 13°20' sectors of the ecliptic governing instinctive mind.",
    ),
  ];

  // Helper to normalize terms across English, Hindi, and Hinglish queries
  static String matchTerm(String query) {
    final lower = query.toLowerCase();
    for (final t in terms) {
      if (lower.contains(t.english.toLowerCase()) ||
          lower.contains(t.sanskrit.toLowerCase()) ||
          lower.contains(t.hindiScript)) {
        return t.hinglishContext;
      }
    }
    return query;
  }

  // Translate or lookup Vedic terminology across English, Hindi, and Sanskrit
  static String translate(String key, String langCode) {
    final lower = key.toLowerCase();
    for (final t in terms) {
      if (t.english.toLowerCase().contains(lower) ||
          t.sanskrit.toLowerCase().contains(lower) ||
          t.hindiScript.contains(key)) {
        if (langCode.toLowerCase().startsWith('hi')) {
          return t.hindiScript;
        } else if (langCode.toLowerCase().startsWith('sa')) {
          return t.sanskrit;
        } else {
          return t.english;
        }
      }
    }
    return key;
  }
}
