// android/lib/screens/screen05_home_dashboard_android.dart
// Screen 05: True 3D Celestial Dashboard (Android iOS Target)
// Features: Hardware-accelerated 3D Metal Viewport, 3D Keplerian orbits, multi-touch orbit/zoom,
// 3D raycast planet selection, floating spatial HUD capsules, and Bento telemetry grid.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'package:astro_ai/shared/engine/3d/cosmic_spatial_view.dart';
import 'package:astro_ai/shared/engine/3d/planet_node_3d.dart';
import 'screen06_kundali_overview_android.dart';
import 'screen13_compatibility_intro_android.dart';
import 'screen16_devi_live_oracle_android.dart';
import 'package:astro_ai/shared/screens/palmistry/screen_palmistry_landing.dart';
import 'package:astro_ai/shared/screens/tarot/screen_tarot_soul_guide.dart';
import 'package:astro_ai/shared/screens/lunar/screen_lunar_wisdom.dart';
import 'package:astro_ai/shared/screens/settings/screen_settings_cosmic.dart';
import 'package:astro_ai/shared/screens/transits/screen_todays_transits.dart';
import 'package:astro_ai/shared/screens/kundali/screen_dual_chart_kundli.dart';
import 'package:astro_ai/shared/screens/horoscope/screen_daily_scored_horoscope.dart';
import 'package:astro_ai/shared/screens/horoscope/screen_best_hours_rahu_kalam.dart';
import 'package:astro_ai/shared/screens/hub/screen_horoscope_kundli_daily_hub.dart';
import 'package:astro_ai/shared/screens/onboarding/screen_start_free_om_ai.dart';
import 'package:astro_ai/shared/screens/reports/screen_free_reports_hub.dart';

class Screen05HomeDashboardAndroid extends StatefulWidget {
  const Screen05HomeDashboardAndroid({super.key});

  @override
  State<Screen05HomeDashboardAndroid> createState() => _Screen05HomeDashboardAndroidState();
}

class _Screen05HomeDashboardAndroidState extends State<Screen05HomeDashboardAndroid> {
  PlanetNode3D? _focusedPlanet;

  void _navigateToKundali() {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen06KundaliOverviewAndroid()),
    );
  }

  void _navigateToDevi() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen16DeviLiveOracleAndroid()),
    );
  }

  void _navigateToSynastry() {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen13CompatibilityIntroAndroid()),
    );
  }

  void _navigateToProfile() {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenSettingsCosmic()),
    );
  }

  void _navigateToTransits() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenTodaysTransits()),
    );
  }

  void _navigateToDualKundli() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenDualChartKundli()),
    );
  }

  void _navigateToDailyScoredHoroscope() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenDailyScoredHoroscope()),
    );
  }

  void _navigateToBestHours() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenBestHoursRahuKalam()),
    );
  }

  void _navigateToDailyHub() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenHoroscopeKundliDailyHub()),
    );
  }

  void _navigateToStartFree() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenStartFreeOmAi()),
    );
  }


  void _navigateToTarot() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenTarotSoulGuide()),
    );
  }

  void _navigateToLunarWisdom() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenLunarWisdom()),
    );
  }

  void _navigateToPalmistry() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenPalmistryLanding()),
    );
  }

  void _navigateToFreeReports() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenFreeReportsHub()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      bottomFloatingDock: _buildAndroidFloatingDock(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Sticky Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/daivant_logo.webp', width: 36, height: 36),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DAIVANT AI • ROHINI",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 9,
                            letterSpacing: 1.5,
                            color: AndroidCosmicTheme.champagneGold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Ramsundar",
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AndroidCosmicTheme.champagneGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "☉ 27° VIR",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AndroidCosmicTheme.champagneGold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // -------------------------------------------------------------
            // TRUE 3D SPATIAL CELESTIAL DASHBOARD (Metal GPU Viewport)
            // -------------------------------------------------------------
            Container(
              height: 330,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CosmicSpatialView(
                  height: 330,
                  enableUserInteraction: true,
                  showOrbits: true,
                  showVortex: false,
                  onPlanetSelected: (planet) {
                    setState(() {
                      _focusedPlanet = planet;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Gesture hint
            Center(
              child: Text(
                _focusedPlanet == null
                    ? "DRAG TO ROTATE 3D SYSTEM • PINCH TO ZOOM • TAP PLANET TO INSPECT"
                    : "FOCUS: ${_focusedPlanet!.name.toUpperCase()} • TAP DEEP SPACE TO RESET",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 8,
                  letterSpacing: 1.1,
                  color: Colors.white.withOpacity(0.45),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Contextual Focused Planet Telemetry Card OR Daily Transit Insight
            if (_focusedPlanet != null)
              _buildFocusedPlanetCard(_focusedPlanet!)
            else
              _buildDailyTransitCard(),

            const SizedBox(height: 16),

            // 2-Column Bento Telemetry Grid
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Cosmic Sync",
                              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, color: Colors.white60),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: AndroidCosmicTheme.emeraldSync.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "+14%",
                                style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AndroidCosmicTheme.emeraldSync, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "88%",
                          style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "PEAK: 14:00–17:00",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "10th House",
                              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, color: Colors.white60),
                            ),
                            Text("♂", style: TextStyle(fontSize: 14, color: AndroidCosmicTheme.champagneGold)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Mars Return",
                          style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          "02d : 14h : 22m",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, color: AndroidCosmicTheme.nebulaViolet),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Container(
                            height: 4,
                            color: Colors.white12,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 70,
                                color: AndroidCosmicTheme.nebulaViolet,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Devi Live Voice Banner
            GestureDetector(
              onTap: _navigateToDevi,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AndroidCosmicTheme.nebulaViolet.withOpacity(0.25),
                      AndroidCosmicTheme.auroraPink.withOpacity(0.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AndroidCosmicTheme.nebulaViolet, AndroidCosmicTheme.auroraPink],
                        ),
                      ),
                      child: const Center(
                        child: Text("✦", style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DEVI AI LIVE ORACLE",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 9,
                              letterSpacing: 1.2,
                              color: AndroidCosmicTheme.champagneGold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "“Ask about your 3D transit alignment...”",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 2-Card Row: Today's Transits & Dual-Layered Kundli
            Row(
              children: [
                // Today's Transits Card
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToTransits,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFE07A5F).withOpacity(0.18),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2B1612),
                                ),
                                child: const Center(
                                  child: Icon(Icons.blur_circular, size: 18, color: Color(0xFFE07A5F)),
                                ),
                              ),
                              const Text("ORBIT ✦", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFE07A5F))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Today's Transits",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "See what sky means for you",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Dual-Layered Kundli Card
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToDualKundli,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFD4AF37).withOpacity(0.16),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2A2312),
                                ),
                                child: const Center(
                                  child: Icon(Icons.layers_outlined, size: 18, color: Color(0xFFD4AF37)),
                                ),
                              ),
                              const Text("D1+D9 ✦", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFFFD700))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Your Kundli",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Chart, not your sun sign",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 2-Card Row: Daily Scored Horoscope & Best Hours Today
            Row(
              children: [
                // Scored Horoscope Card
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToDailyScoredHoroscope,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF2ECC71).withOpacity(0.16),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF2ECC71).withOpacity(0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF10281A),
                                ),
                                child: const Center(
                                  child: Text("💯", style: TextStyle(fontSize: 16)),
                                ),
                              ),
                              const Text("100 ✦", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFF00FF66))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Scored Horoscope",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Love, money, career scored",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Best Hours & Rahu Kalam Card
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToBestHours,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFE07A5F).withOpacity(0.18),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2B1612),
                                ),
                                child: const Center(
                                  child: Icon(Icons.schedule, size: 18, color: Color(0xFFE07A5F)),
                                ),
                              ),
                              const Text("HORA ✦", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFE07A5F))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Best Hours Today",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "With Rahu Kalam timings",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 100+ Free Reports Vault (Direct Match for Reference Screenshot)
            GestureDetector(
              onTap: _navigateToFreeReports,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFDB813).withOpacity(0.18),
                      const Color(0xFF8B5CF6).withOpacity(0.15),
                      Colors.black.withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFFDB813).withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFDB813), Color(0xFFD97706)],
                        ),
                      ),
                      child: const Center(
                        child: Text("📜", style: TextStyle(fontSize: 22)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "100+ FREE REPORTS",
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 9,
                                  letterSpacing: 1.2,
                                  color: Color(0xFFFDB813),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                "• VEDIC VAULT",
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 8,
                                  color: Color(0xFFA78BFA),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Text(
                            "KP System, Dasha, Lal Kitab & Sade Sati",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Shodashvarga 16 charts, Mangal Dosh, Gemstones & Varshphal",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 11,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFFDB813)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Bento Hub Banner Card ("Your Horoscope & Kundli - Daily")
            GestureDetector(
              onTap: _navigateToDailyHub,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFD4AF37).withOpacity(0.20),
                      const Color(0xFF1E1D24),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.4)),
                ),
                child: const Row(
                  children: [
                    Text("🪐", style: TextStyle(fontSize: 26)),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DAILY BENTO DISCOVERY HUB",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Your Horoscope & Kundli - Daily Hub →",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFD4AF37)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Start Free ॐ AI Banner ("Your first question is free")
            GestureDetector(
              onTap: _navigateToStartFree,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF261815), Color(0xFF191316)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.4)),
                ),
                child: const Row(
                  children: [
                    Text(
                      "ॐ",
                      style: TextStyle(fontSize: 26, color: Color(0xFFE07A5F), fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "START FREE",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFE07A5F), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Your first question is free on Om.AI →",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFE07A5F)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            const SizedBox(height: 12),

            // 2-Card Row: Lunar Wisdom & Tarot Soul Guide (Android iOS Parity)
            Row(
              children: [
                // Lunar Wisdom
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToLunarWisdom,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00E5FF).withOpacity(0.12),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF0B1938),
                                ),
                                child: const Center(
                                  child: Text("☾", style: TextStyle(color: Color(0xFF00E5FF), fontSize: 18)),
                                ),
                              ),
                              const Text("52% ✦", style: TextStyle(fontFamily: 'SF Mono', fontSize: 9, color: Color(0xFF00E5FF))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Lunar Wisdom",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Day 9 Ephemeris & Telemetry",
                            style: TextStyle(fontFamily: 'SF Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Tarot of Destiny
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToTarot,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF9D4EDD).withOpacity(0.15),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF9D4EDD).withOpacity(0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF220C3B),
                                ),
                                child: const Center(
                                  child: Text("🎴", style: TextStyle(fontSize: 16)),
                                ),
                              ),
                              const Text("3D FLIP ✦", style: TextStyle(fontFamily: 'SF Mono', fontSize: 9, color: Color(0xFFFFD700))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Tarot Soul Guide",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Awaken Sacred Destiny",
                            style: TextStyle(fontFamily: 'SF Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // AI Palmistry 3D Experience Card (Android iOS Parity)
            GestureDetector(
              onTap: _navigateToPalmistry,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00E5FF).withOpacity(0.12),
                      const Color(0xFF9D4EDD).withOpacity(0.18),
                      Colors.black.withOpacity(0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.35)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF00E5FF), Color(0xFF9D4EDD)],
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.pan_tool_outlined, color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "AI PALMISTRY",
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 9,
                                  letterSpacing: 1.2,
                                  color: Color(0xFF00E5FF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                "• 3D SCAN",
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 8,
                                  color: Color(0xFFFFD700),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Discover the story written in your hands.",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 2-Card Row: Today's Transits & Dual-Layered Kundli
            Row(
              children: [
                // Today's Transits Card
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToTransits,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFE07A5F).withOpacity(0.18),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2B1612),
                                ),
                                child: const Center(
                                  child: Icon(Icons.blur_circular, size: 18, color: Color(0xFFE07A5F)),
                                ),
                              ),
                              const Text("ORBIT ✦", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFE07A5F))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Today's Transits",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "See what sky means for you",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Dual-Layered Kundli Card
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToDualKundli,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFD4AF37).withOpacity(0.16),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2A2312),
                                ),
                                child: const Center(
                                  child: Icon(Icons.layers_outlined, size: 18, color: Color(0xFFD4AF37)),
                                ),
                              ),
                              const Text("D1+D9 ✦", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFFFD700))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Your Kundli",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Chart, not your sun sign",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 2-Card Row: Daily Scored Horoscope & Best Hours Today
            Row(
              children: [
                // Scored Horoscope Card
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToDailyScoredHoroscope,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF2ECC71).withOpacity(0.16),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF2ECC71).withOpacity(0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF10281A),
                                ),
                                child: const Center(
                                  child: Text("💯", style: TextStyle(fontSize: 16)),
                                ),
                              ),
                              const Text("100 ✦", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFF00FF66))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Scored Horoscope",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Love, money, career scored",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Best Hours & Rahu Kalam Card
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToBestHours,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFE07A5F).withOpacity(0.18),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2B1612),
                                ),
                                child: const Center(
                                  child: Icon(Icons.schedule, size: 18, color: Color(0xFFE07A5F)),
                                ),
                              ),
                              const Text("HORA ✦", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFE07A5F))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Best Hours Today",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "With Rahu Kalam timings",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Bento Hub Banner Card ("Your Horoscope & Kundli - Daily")
            GestureDetector(
              onTap: _navigateToDailyHub,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFD4AF37).withOpacity(0.20),
                      const Color(0xFF1E1D24),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.4)),
                ),
                child: const Row(
                  children: [
                    Text("🪐", style: TextStyle(fontSize: 26)),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DAILY BENTO DISCOVERY HUB",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Your Horoscope & Kundli - Daily Hub →",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFD4AF37)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Start Free ॐ AI Banner ("Your first question is free")
            GestureDetector(
              onTap: _navigateToStartFree,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF261815), Color(0xFF191316)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.4)),
                ),
                child: const Row(
                  children: [
                    Text(
                      "ॐ",
                      style: TextStyle(fontSize: 26, color: Color(0xFFE07A5F), fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "START FREE",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFE07A5F), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Your first question is free on Om.AI →",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFE07A5F)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusedPlanetCard(PlanetNode3D planet) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: planet.baseColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: planet.baseColor.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    planet.glyph,
                    style: TextStyle(fontSize: 22, color: planet.baseColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    planet.name,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: planet.baseColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  planet.dignity.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: planet.baseColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTelemetryBadge("SIGN", "${planet.sign} ${planet.degreeStr}"),
              _buildTelemetryBadge("BHAVA", planet.house),
              _buildTelemetryBadge("NAKSHATRA", planet.nakshatra),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: BorderSide(color: Colors.white.withOpacity(0.08)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  ),
                  onPressed: _navigateToKundali,
                  child: const Text("View in Kundali →", style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: planet.baseColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  ),
                  onPressed: _navigateToDevi,
                  child: const Text("Ask Devi →", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryBadge(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 8,
            color: Colors.white.withOpacity(0.45),
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyTransitCard() {
    return Column(
      children: [
        const Text(
          "MERCURY TRINE NATAL JUPITER",
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 9,
            letterSpacing: 1.2,
            color: AndroidCosmicTheme.nebulaViolet,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Cormorant Garamond',
              fontSize: 22,
              color: Colors.white,
              height: 1.2,
            ),
            children: [
              TextSpan(text: "“Your intuition is sharper than logic today. "),
              TextSpan(
                text: "Ship the architecture.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AndroidCosmicTheme.champagneGold,
                ),
              ),
              TextSpan(text: "”"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAndroidFloatingDock() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AndroidCosmicTheme.oledVoid.withOpacity(0.88),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Home", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
          GestureDetector(
            onTap: _navigateToKundali,
            child: const Text("Kundali", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, color: Colors.white60)),
          ),
          GestureDetector(
            onTap: _navigateToDevi,
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AndroidCosmicTheme.nebulaViolet, AndroidCosmicTheme.auroraPink],
                ),
              ),
              child: const Center(child: Text("✦", style: TextStyle(color: Colors.white, fontSize: 16))),
            ),
          ),
          GestureDetector(
            onTap: _navigateToSynastry,
            child: const Text("Synastry", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, color: Colors.white60)),
          ),
          GestureDetector(
            onTap: _navigateToProfile,
            child: const Text("Profile", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, color: Colors.white60)),
          ),
        ],
      ),
    );
  }
}
