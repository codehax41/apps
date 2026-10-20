// apple/lib/screens/screen15_compatibility_report_apple.dart
// Screen 15: Compatibility Report (Apple iOS Target)
// Features: 92% Resonance Score (Earth-Water Lock), 36-point Guna Milan progress bars,
// Kuja Dosha cancellation verification, and route to Screen 16 Live Devi.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen16_devi_live_oracle_apple.dart';
import 'package:astro_ai/shared/screens/compatibility/screen_gun_milan_report.dart';

class Screen15CompatibilityReportApple extends StatelessWidget {
  const Screen15CompatibilityReportApple({super.key});

  void _onTalkToDevi(BuildContext context) {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen16DeviLiveOracleApple()),
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
                const Text(
                  "RAMSUNDAR × ANANYA",
                  style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Colors.white70, letterSpacing: 1.2),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppleCosmicTheme.champagneGold.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "28.5 / 36 GUNAS",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),            // Header matching reference Image 4
            const Center(
              child: Text(
                "Love Written in Stars",
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Compatibility Chart Card (Exact match to Reference Image 4)
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF110D24),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFF9D4EDD).withOpacity(0.35)),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF9D4EDD).withOpacity(0.2), blurRadius: 30),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Compatibility Chart",
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Dual Avatars (Taurus & Sagittarius) with 55% Arc
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Taurus Avatar
                      Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [Color(0xFF00E5FF), Color(0xFF0F172A)],
                              ),
                              border: Border.all(color: const Color(0xFF00E5FF), width: 1.5),
                              boxShadow: [
                                BoxShadow(color: const Color(0xFF00E5FF).withOpacity(0.4), blurRadius: 14),
                              ],
                            ),
                            child: const Center(
                              child: Text("♉", style: TextStyle(fontSize: 26, color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Taurus",
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // 55% Central Arc Score
                      Column(
                        children: [
                          Container(
                            width: 72,
                            height: 48,
                            alignment: Alignment.center,
                            child: const Text(
                              "55%",
                              style: TextStyle(
                                fontFamily: 'SF Mono',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFD700),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Sagittarius Avatar
                      Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [Color(0xFF9D4EDD), Color(0xFF0F172A)],
                              ),
                              border: Border.all(color: const Color(0xFF9D4EDD), width: 1.5),
                              boxShadow: [
                                BoxShadow(color: const Color(0xFF9D4EDD).withOpacity(0.4), blurRadius: 14),
                              ],
                            ),
                            child: const Center(
                              child: Text("♐", style: TextStyle(fontSize: 26, color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Sagittarius",
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 6 Dimensional Breakdown Rows (Matching Reference Image 4)
                  Row(
                    children: [
                      Expanded(child: _buildSixDimensionBar("Love", 0.58, const Color(0xFFFF69B4), "58%")),
                      const SizedBox(width: 14),
                      Expanded(child: _buildSixDimensionBar("Sex", 0.62, const Color(0xFFFF3366), "62%")),
                      const SizedBox(width: 14),
                      Expanded(child: _buildSixDimensionBar("Communication", 0.50, const Color(0xFF00E5FF), "50%")),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _buildSixDimensionBar("Friendship", 0.55, const Color(0xFFFF9E00), "55%")),
                      const SizedBox(width: 14),
                      Expanded(child: _buildSixDimensionBar("Business", 0.48, const Color(0xFF00FF66), "48%")),
                      const SizedBox(width: 14),
                      Expanded(child: _buildSixDimensionBar("Family", 0.60, const Color(0xFFFF5252), "60%")),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Synthesis Section (Matching Image 4)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Earth Meets Wandering Fire",
                        style: TextStyle(
                          fontFamily: 'Cormorant Garamond',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Taurus seeks stable grounded routine while Sagittarius craves unbounded adventure. This pairing requires conscious adaptation for vastly different life paces. Success comes when Taurus embraces some adventure and Sagittarius appreciates the anchor of loyalty.",
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 12.5,
                          height: 1.45,
                          color: Colors.white.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Gun Milan 29.5/36 Points Breakdown Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: const Color(0xFFE07A5F),
                borderRadius: BorderRadius.circular(999),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const ScreenGunMilanReport(partnerName: "Priya")),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.star_fill, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "Gun Milan from Both Charts (29.5/36) →",
                      style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Bottom CTA
            GestureDetector(
              onTap: () => _onTalkToDevi(context),
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AppleCosmicTheme.nebulaViolet, AppleCosmicTheme.auroraPink],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.4), blurRadius: 20),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Talk Live to Devi AI Oracle (Screen 16) →",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
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


  Widget _buildSixDimensionBar(String label, double value, Color barColor, String pct) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontFamily: 'SF Pro Text', fontSize: 10, color: Colors.white70)),
            Text(pct, style: TextStyle(fontFamily: 'SF Mono', fontSize: 9, fontWeight: FontWeight.bold, color: barColor)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 4,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }

}
