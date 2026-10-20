// apple/lib/screens/screen07_planetary_positions_apple.dart
// Screen 07: Planetary Positions (Apple iOS Target)
// Features: UIContextMenuInteraction on long-press ("Ask Devi about my Exalted Moon"),
// Accordion 3D Depth Drawer (Shadbala & Ashtakavarga), and Cupertino BouncingScrollPhysics.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen08_nakshatra_insight_apple.dart';
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

class Screen07PlanetaryPositionsApple extends StatefulWidget {
  const Screen07PlanetaryPositionsApple({super.key});

  @override
  State<Screen07PlanetaryPositionsApple> createState() => _Screen07PlanetaryPositionsAppleState();
}

class _Screen07PlanetaryPositionsAppleState extends State<Screen07PlanetaryPositionsApple> {
  int? _expandedIndex;

  final List<GrahaTelemetryItem> _grahas = const [
    GrahaTelemetryItem(
      glyph: "☉",
      name: "Sun (Surya)",
      nakshatra: "Uttara Phalguni • Pada 4",
      degree: "27° 14' VIR",
      dignity: "FRIEND",
      house: "8H",
      dignityColor: AppleCosmicTheme.nebulaViolet,
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
      dignityColor: AppleCosmicTheme.champagneGold,
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
      dignityColor: AppleCosmicTheme.emeraldSync,
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
      dignityColor: AppleCosmicTheme.champagneGold,
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
      dignityColor: AppleCosmicTheme.nebulaViolet,
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
      dignityColor: AppleCosmicTheme.auroraPink,
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
      dignityColor: AppleCosmicTheme.auroraPink,
      shadbala: 1.0,
      ashtakavarga: 4,
    ),
  ];

  void _onExploreNakshatra() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen08NakshatraInsightApple()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                      style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppleCosmicTheme.nebulaViolet.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "LAHIRI SIDEREAL",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AppleCosmicTheme.nebulaViolet),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Today's Transits Sky Orbit Banner
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => const ScreenTodaysTransits()),
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
                      child: const Icon(CupertinoIcons.circle_grid_hex, size: 18, color: Colors.white),
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
                            style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Icon(CupertinoIcons.chevron_right, size: 14, color: Color(0xFFE07A5F)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Ephemeris Stack with iOS Context Menu Interaction
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _grahas.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = _grahas[index];
                final isExpanded = _expandedIndex == index;

                return CupertinoContextMenu(
                  actions: [
                    CupertinoContextMenuAction(
                      onPressed: () {
                        Navigator.pop(context);
                        // Route to Devi with context
                      },
                      trailingIcon: CupertinoIcons.mic,
                      child: Text("Ask Devi about my ${item.name}"),
                    ),
                    CupertinoContextMenuAction(
                      onPressed: () => Navigator.pop(context),
                      trailingIcon: CupertinoIcons.share,
                      child: const Text("Share Graha Card"),
                    ),
                  ],
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
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
                                ? AppleCosmicTheme.champagneGold.withOpacity(0.5)
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
                                            style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                          if (item.isRetrograde) ...[
                                            const SizedBox(width: 4),
                                            const Text("℞", style: TextStyle(fontSize: 12, color: AppleCosmicTheme.champagneGold)),
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
                                        color: (item.dignity == "EXALTED") ? AppleCosmicTheme.champagneGold : Colors.white,
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
                                        Text("${item.shadbala} RUPAS", style: const TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text("ASHTAKAVARGA", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8, color: Colors.white54)),
                                        const SizedBox(height: 2),
                                        Text("${item.ashtakavarga} BINDUS", style: const TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: AppleCosmicTheme.emeraldSync)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Bottom CTA
            GestureDetector(
              onTap: _onExploreNakshatra,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AppleCosmicTheme.nebulaViolet, AppleCosmicTheme.auroraPink],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppleCosmicTheme.nebulaViolet.withOpacity(0.35),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Explore Nakshatra Insight (Screen 8) →",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
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
