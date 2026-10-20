// android/lib/screens/screen07_planetary_positions_android.dart
// Screen 07: Planetary Positions (Google Android Target)
// Features: Glassmorphic Modal Bottom Sheet on long-press, Accordion 3D depth expansion,
// Shadbala score & Ashtakavarga bindu drawer, and VibrationEffect haptic sync.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen08_nakshatra_insight_android.dart';
import 'package:astro_ai/shared/screens/transits/screen_todays_transits.dart';

class GrahaTelemetryItem {
  final String glyph;
  final String name;
  final String nakshatra;
  final String degree;
  final String dignity;
  final String house;
  final Color dignityColor;
  final double shadbala;
  final int ashtakavarga;
  final bool isRetrograde;
  final bool isCombust;

  const GrahaTelemetryItem({
    required this.glyph,
    required this.name,
    required this.nakshatra,
    required this.degree,
    required this.dignity,
    required this.house,
    required this.dignityColor,
    required this.shadbala,
    required this.ashtakavarga,
    this.isRetrograde = false,
    this.isCombust = false,
  });
}

class Screen07PlanetaryPositionsAndroid extends StatefulWidget {
  const Screen07PlanetaryPositionsAndroid({super.key});

  @override
  State<Screen07PlanetaryPositionsAndroid> createState() => _Screen07PlanetaryPositionsAndroidState();
}

class _Screen07PlanetaryPositionsAndroidState extends State<Screen07PlanetaryPositionsAndroid> {
  int? _expandedIndex;

  final List<GrahaTelemetryItem> _grahas = const [
    GrahaTelemetryItem(
      glyph: "☉",
      name: "Sun (Surya)",
      nakshatra: "Uttara Phalguni • Pada 4",
      degree: "27° 14' VIR",
      dignity: "FRIEND",
      house: "8H",
      dignityColor: AndroidCosmicTheme.nebulaViolet,
      shadbala: 1.18,
      ashtakavarga: 5,
    ),
    GrahaTelemetryItem(
      glyph: "☽",
      name: "Moon (Chandra)",
      nakshatra: "Rohini • Pada 1",
      degree: "11° 42' TAU",
      dignity: "EXALTED",
      house: "4H",
      dignityColor: AndroidCosmicTheme.champagneGold,
      shadbala: 1.64,
      ashtakavarga: 7,
    ),
    GrahaTelemetryItem(
      glyph: "♂",
      name: "Mars (Mangal)",
      nakshatra: "Anuradha • Pada 2",
      degree: "09° 51' SCO",
      dignity: "OWN SIGN",
      house: "10H",
      dignityColor: AndroidCosmicTheme.emeraldSync,
      shadbala: 1.42,
      ashtakavarga: 6,
    ),
    GrahaTelemetryItem(
      glyph: "☿",
      name: "Mercury (Budha)",
      nakshatra: "Hasta • Pada 3",
      degree: "18° 05' VIR",
      dignity: "EXALTED",
      house: "8H",
      dignityColor: AndroidCosmicTheme.champagneGold,
      shadbala: 1.55,
      ashtakavarga: 6,
      isRetrograde: true,
    ),
    GrahaTelemetryItem(
      glyph: "♃",
      name: "Jupiter (Guru)",
      nakshatra: "Shatabhisha • Pada 2",
      degree: "22° 18' AQU",
      dignity: "FRIEND",
      house: "1H",
      dignityColor: AndroidCosmicTheme.nebulaViolet,
      shadbala: 1.35,
      ashtakavarga: 5,
    ),
    GrahaTelemetryItem(
      glyph: "♀",
      name: "Venus (Shukra)",
      nakshatra: "Jyeshtha • Pada 1",
      degree: "04° 20' SCO",
      dignity: "NEUTRAL",
      house: "10H",
      dignityColor: Colors.white70,
      shadbala: 1.12,
      ashtakavarga: 4,
    ),
    GrahaTelemetryItem(
      glyph: "♄",
      name: "Saturn (Shani)",
      nakshatra: "Uttara Bhadrapada • Pada 1",
      degree: "04° 33' PIS",
      dignity: "NEUTRAL",
      house: "2H",
      dignityColor: Colors.white70,
      shadbala: 1.25,
      ashtakavarga: 5,
      isRetrograde: true,
    ),
    GrahaTelemetryItem(
      glyph: "☊",
      name: "Rahu (North Node)",
      nakshatra: "Ashwini • Pada 2",
      degree: "14° 19' ARI",
      dignity: "KARMIC",
      house: "3H",
      dignityColor: AndroidCosmicTheme.auroraPink,
      shadbala: 1.0,
      ashtakavarga: 4,
    ),
    GrahaTelemetryItem(
      glyph: "☋",
      name: "Ketu (South Node)",
      nakshatra: "Chitra • Pada 4",
      degree: "14° 19' LIB",
      dignity: "MOKSHA",
      house: "9H",
      dignityColor: AndroidCosmicTheme.auroraPink,
      shadbala: 1.0,
      ashtakavarga: 4,
    ),
  ];

  void _showAndroidPlanetActions(GrahaTelemetryItem item) {
    HapticFeedback.heavyImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: AndroidCosmicTheme.oledVoid,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item.glyph, style: TextStyle(fontSize: 24, color: item.dignityColor)),
                const SizedBox(width: 10),
                Text(
                  item.name,
                  style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.mic, color: AndroidCosmicTheme.champagneGold),
              title: Text("Ask Devi about my ${item.name}", style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Trigger Devi consultation
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: AndroidCosmicTheme.nebulaViolet),
              title: const Text("Share Graha Dignity Card", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onExploreNakshatra() {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen08NakshatraInsightAndroid()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EPHEMERIS TABLE",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Graha Telemetry & Dignities",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "LAHIRI SIDEREAL",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.nebulaViolet),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Today's Transits Sky Orbit Banner
            GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScreenTodaysTransits()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFE07A5F).withOpacity(0.25),
                      const Color(0xFFC75D43).withOpacity(0.12),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE07A5F),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.blur_circular, size: 18, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TODAY'S TRANSITS",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Color(0xFFE07A5F), fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "See what today's sky means for you",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFE07A5F)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Ephemeris Stack with Android Long-Press Bottom Sheet
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _grahas.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = _grahas[index];
                final isExpanded = _expandedIndex == index;

                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onLongPress: () => _showAndroidPlanetActions(item),
                  onTap: () {
                    HapticFeedback.vibrate();
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.035),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (item.dignity == "EXALTED")
                            ? AndroidCosmicTheme.champagneGold.withOpacity(0.5)
                            : Colors.white.withOpacity(0.08),
                        width: (item.dignity == "EXALTED") ? 1.5 : 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: item.dignityColor.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: item.dignityColor.withOpacity(0.4)),
                              ),
                              child: Center(
                                child: Text(item.glyph, style: TextStyle(fontSize: 18, color: item.dignityColor)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      if (item.isRetrograde) ...[
                                        const SizedBox(width: 4),
                                        const Text("℞", style: TextStyle(fontSize: 12, color: AndroidCosmicTheme.champagneGold)),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.nakshatra,
                                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Colors.white.withOpacity(0.55)),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item.degree,
                                  style: TextStyle(
                                    fontFamily: 'Space Mono',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: (item.dignity == "EXALTED") ? AndroidCosmicTheme.champagneGold : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: item.dignityColor.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "${item.dignity} • ${item.house}",
                                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: item.dignityColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Accordion 3D Depth Drawer (Shadbala & Ashtakavarga)
                        if (isExpanded) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Text("SHADBALA SCORE", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8, color: Colors.white54)),
                                    const SizedBox(height: 2),
                                    Text("${item.shadbala} RUPAS", style: const TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text("ASHTAKAVARGA", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8, color: Colors.white54)),
                                    const SizedBox(height: 2),
                                    Text("${item.ashtakavarga} BINDUS", style: const TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.emeraldSync)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Bottom CTA (Material 3 ElevatedButton)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AndroidCosmicTheme.nebulaViolet,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  elevation: 6,
                ),
                onPressed: _onExploreNakshatra,
                child: const Text(
                  "Explore Nakshatra Insight (Screen 8) →",
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13.5, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
