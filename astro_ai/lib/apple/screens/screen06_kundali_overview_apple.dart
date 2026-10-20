// apple/lib/screens/screen06_kundali_overview_apple.dart
// Screen 06: Kundali Overview (Apple iOS Target - Cupertino Ergonomics)
// High-Fidelity Vedic Kundali matching user reference specifications:
// - Header: kanu • 25/08/96 • 12:00pm • Mumbai • Settings gear
// - 3D Golden Libra Scales badge & Lagna: Libra
// - Sun / Moon Dynamic Divisional Badges (D1: Leo/Sag, D9: Gem/Virgo, D10: Libra/Gem)
// - Vedic Disclaimer: "Kundali vedic astrology par aadharit hai"
// - 3-Page Carousel: D1 Lagna, D9 Navamsa, D10 Dasamsa with 3-dot pagination
// - One-Tap North Indian Diamond <-> South Indian Box Grid Layout Switcher

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'package:astro_ai/shared/widgets/kundali_universal_painter.dart';
import 'screen07_planetary_positions_apple.dart';
import 'package:astro_ai/shared/screens/tarot/screen_tarot_soul_guide.dart';
import 'package:astro_ai/shared/screens/lunar/screen_lunar_wisdom.dart';
import 'package:astro_ai/shared/screens/palmistry/screen_palmistry_landing.dart';
import 'package:astro_ai/shared/screens/settings/screen_settings_cosmic.dart';
import 'package:astro_ai/shared/screens/kundali/screen_dual_chart_kundli.dart';

class Screen06KundaliOverviewApple extends StatefulWidget {
  const Screen06KundaliOverviewApple({super.key});

  @override
  State<Screen06KundaliOverviewApple> createState() => _Screen06KundaliOverviewAppleState();
}

class _Screen06KundaliOverviewAppleState extends State<Screen06KundaliOverviewApple> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isSouthIndian = false;
  final int _selectedHouse = 1;

  // Divisional Chart Metadata matching screenshots 1-5
  final List<Map<String, dynamic>> _chartPages = [
    {
      "division": KundaliDivision.d1Lagna,
      "title": "D1: Lagna",
      "subtitle": "Life Overview",
      "sunRashi": "Leo",
      "moonRashi": "Sagittarius",
      "lagna": "Libra",
    },
    {
      "division": KundaliDivision.d9Navamsa,
      "title": "D9: Navamsa",
      "subtitle": "Marriage and Dharma",
      "sunRashi": "Gemini",
      "moonRashi": "Virgo",
      "lagna": "Libra",
    },
    {
      "division": KundaliDivision.d10Dasamsa,
      "title": "D10: Dasamsa",
      "subtitle": "Career",
      "sunRashi": "Libra",
      "moonRashi": "Gemini",
      "lagna": "Libra",
    },
  ];

  final Map<int, Map<String, String>> _houseInsights = {
    1: {
      "title": "1ST HOUSE — TANU BHAVA (SELF)",
      "yoga": "RUCHAKA YOGA",
      "details": "Governed by Venus in Libra. Bestows magnetic charm, diplomatic brilliance, aesthetic perception, and physical grace.",
    },
    2: {
      "title": "2ND HOUSE — DHANA BHAVA (WEALTH)",
      "yoga": "DHANA YOGA",
      "details": "Scorpio cusp. Governs accumulated liquid wealth, family lineage speech, and resource synthesis.",
    },
    7: {
      "title": "7TH HOUSE — KALATRA BHAVA (PARTNERSHIP)",
      "yoga": "DHARMA-KARMA",
      "details": "Aries cusp with Venus & Mars aspects. Magnetizes ambitious, high-agency life & business partners.",
    },
    10: {
      "title": "10TH HOUSE — KARMA BHAVA (CAREER)",
      "yoga": "KULADEEPAKA YOGA",
      "details": "Cancer cusp. High executive influence, innovative leadership in AI & frontier tech systems.",
    },
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _currentPage = index;
    });
  }

  void _toggleGrid() {
    HapticFeedback.selectionClick();
    setState(() {
      _isSouthIndian = !_isSouthIndian;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeData = _chartPages[_currentPage];

    return ApplePlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Bar: Back | User Birth Telemetry | Settings Gear
            _buildTopBar(),

            const SizedBox(height: 12),

            // 2. Hero Kundali Card with Libra Scales & Interactive Chart
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF13111C),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: Colors.white.withOpacity(0.09)),
                boxShadow: [
                  BoxShadow(
                    color: AppleCosmicTheme.nebulaViolet.withOpacity(0.18),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 3D Golden Libra Scales Emblem (Top Right)
                  const Positioned(
                    top: -6,
                    right: 8,
                    child: IgnorePointer(
                      child: LibraScalesWidget(width: 105, height: 115),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Header: Kundali & Lagna
                        const Text(
                          "Kundali",
                          style: TextStyle(
                            fontFamily: '.SF Pro Display',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Lagna: ${activeData['lagna']}",
                          style: TextStyle(
                            fontFamily: '.SF Pro Text',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.70),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Dual Sun & Moon Badges (Dynamically changes with D1/D9/D10)
                        Row(
                          children: [
                            _buildCelestialBadge(
                              isSun: true,
                              label: "Sun",
                              rashi: activeData['sunRashi'],
                            ),
                            const SizedBox(width: 28),
                            _buildCelestialBadge(
                              isSun: false,
                              label: "Moon",
                              rashi: activeData['moonRashi'],
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Vedic Astrology Notice Row
                        Row(
                          children: [
                            Icon(CupertinoIcons.info, size: 14, color: Colors.white.withOpacity(0.40)),
                            const SizedBox(width: 6),
                            Text(
                              "Kundali vedic astrology par aadharit hai",
                              style: TextStyle(
                                fontFamily: '.SF Pro Text',
                                fontSize: 11.5,
                                color: Colors.white.withOpacity(0.45),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // 3. Main Chart Viewport (Swipeable PageView)
                        SizedBox(
                          height: 280,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            itemCount: _chartPages.length,
                            itemBuilder: (context, index) {
                              final div = _chartPages[index]['division'] as KundaliDivision;
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                child: CustomPaint(
                                  size: const Size(double.infinity, 280),
                                  painter: KundaliUniversalPainter(
                                    division: div,
                                    isSouthIndian: _isSouthIndian,
                                    selectedHouse: _selectedHouse,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 12),

                        // 4. Card Bottom Bar: Division Title & One-Tap North/South Grid Toggle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activeData['title'],
                                  style: const TextStyle(
                                    fontFamily: 'Space Mono',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  activeData['subtitle'],
                                  style: TextStyle(
                                    fontFamily: '.SF Pro Text',
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.55),
                                  ),
                                ),
                              ],
                            ),

                            // North Indian Diamond <-> South Indian Grid Toggle Pill
                            _buildNorthSouthToggle(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 5. Centered 3-Dot Pagination Carousel Indicator
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_chartPages.length, (idx) {
                  final isActive = _currentPage == idx;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isActive ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFFD4AF37) : Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            // 6. House & Planetary Telemetry Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.035),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _houseInsights[1]!["title"]!,
                        style: const TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFD700),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00FF66).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.35)),
                        ),
                        child: Text(
                          _houseInsights[1]!["yoga"]!,
                          style: const TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 8.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00FF66),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _houseInsights[1]!["details"]!,
                    style: TextStyle(
                      fontFamily: '.SF Pro Text',
                      fontSize: 12.5,
                      height: 1.45,
                      color: Colors.white.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 7. Navigation Actions: Dual-Layered Kundli & Full Planetary Degrees
            SizedBox(
              width: double.infinity,
              height: 48,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: const Color(0xFFE07A5F),
                borderRadius: BorderRadius.circular(999),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const ScreenDualChartKundli()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.square_stack_3d_up, size: 16, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Dual-Layered Kundli (Rasi + Navamsa)",
                      style: TextStyle(
                        fontFamily: '.SF Pro Text',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(CupertinoIcons.chevron_right, size: 14, color: Colors.white),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(999),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const Screen07PlanetaryPositionsApple()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View Full Planetary Degrees (Screen 7)",
                      style: TextStyle(
                        fontFamily: '.SF Pro Text',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(CupertinoIcons.chevron_right, size: 14, color: Color(0xFFFFD700)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 8. Quick Discovery Row: Lunar Wisdom, Tarot, Palmistry
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    title: "Lunar Wisdom",
                    subtitle: "3D Moon Phase",
                    icon: CupertinoIcons.moon_stars,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const ScreenLunarWisdom()));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildQuickActionCard(
                    title: "Tarot Soul",
                    subtitle: "Destiny Flip",
                    icon: CupertinoIcons.sparkles,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const ScreenTarotSoulGuide()));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildQuickActionCard(
                    title: "AI Palmistry",
                    subtitle: "3D Laser Scan",
                    icon: CupertinoIcons.hand_raised,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const ScreenPalmistryLanding()));
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1824),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: const Icon(CupertinoIcons.chevron_back, size: 16, color: Colors.white70),
          ),
        ),

        // Centered User Birth Metadata (Exact to Reference Screenshots)
        Column(
          children: [
            const Text(
              "kanu",
              style: TextStyle(
                fontFamily: '.SF Pro Text',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "25/08/96",
                  style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, color: Colors.white.withOpacity(0.55)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text("•", style: TextStyle(fontSize: 10, color: const Color(0xFFFFD700).withOpacity(0.7))),
                ),
                Text(
                  "12:00pm",
                  style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, color: Colors.white.withOpacity(0.55)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text("•", style: TextStyle(fontSize: 10, color: const Color(0xFFFFD700).withOpacity(0.7))),
                ),
                Text(
                  "Mumbai",
                  style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white.withOpacity(0.55)),
                ),
              ],
            ),
          ],
        ),

        // Settings Gear Icon Button
        GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => const ScreenSettingsCosmic()),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1824),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: const Icon(CupertinoIcons.gear, size: 18, color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildCelestialBadge({
    required bool isSun,
    required String label,
    required String rashi,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Golden Medallion
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Color(0xFF2C2738), Color(0xFF15131C)],
            ),
            border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.40), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.12),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: CustomPaint(
              size: const Size(24, 24),
              painter: CelestialMedallionPainter(isSun: isSun),
            ),
          ),
        ),
        const SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 10.5,
                color: Colors.white.withOpacity(0.48),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              rashi,
              style: const TextStyle(
                fontFamily: '.SF Pro Text',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNorthSouthToggle() {
    return Container(
      height: 36,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0D17),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // North Indian Diamond Icon Button
          GestureDetector(
            onTap: () {
              if (_isSouthIndian) _toggleGrid();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 38,
              height: 28,
              decoration: BoxDecoration(
                color: !_isSouthIndian ? const Color(0xFFD4AF37) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.diamond_outlined,
                  size: 16,
                  color: !_isSouthIndian ? const Color(0xFF121018) : const Color(0xFFD4AF37),
                ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          // South Indian Square Box Grid Icon Button
          GestureDetector(
            onTap: () {
              if (!_isSouthIndian) _toggleGrid();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 38,
              height: 28,
              decoration: BoxDecoration(
                color: _isSouthIndian ? const Color(0xFFD4AF37) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.grid_view,
                  size: 16,
                  color: _isSouthIndian ? const Color(0xFF121018) : const Color(0xFFD4AF37),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.07)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: const Color(0xFFFFD700)),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontFamily: '.SF Pro Text',
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 8.5,
                color: Colors.white.withOpacity(0.4),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
