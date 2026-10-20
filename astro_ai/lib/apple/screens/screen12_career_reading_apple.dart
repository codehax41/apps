// apple/lib/screens/screen12_career_reading_apple.dart
// Screen 12: Career Reading (Apple iOS Target)
// Features: D10 Dasamsa & Jaimini Amatyakaraka analysis, 3D metric card flip (84% Founder breakdown),
// Ruchaka Yoga badges, and Cupertino navigation into Synastry or Full Dossier.

import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen13_compatibility_intro_apple.dart';
import 'screen19_career_report_detail_apple.dart';

class Screen12CareerReadingApple extends StatefulWidget {
  const Screen12CareerReadingApple({super.key});

  @override
  State<Screen12CareerReadingApple> createState() => _Screen12CareerReadingAppleState();
}

class _Screen12CareerReadingAppleState extends State<Screen12CareerReadingApple>
    with SingleTickerProviderStateMixin {
  bool _isFounderFlipped = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFounderFlip() {
    HapticFeedback.selectionClick();
    if (_isFounderFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFounderFlipped = !_isFounderFlipped);
  }

  void _onNavigateToSynastry() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen13CompatibilityIntroApple()),
    );
  }

  void _onOpenFullDossier() {
    HapticFeedback.selectionClick();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen19CareerReportDetailApple()),
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
                      "D10 DASAMSA + 10TH HOUSE",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Vocation & Leadership",
                      style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppleCosmicTheme.champagneGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "RUCHAKA YOGA",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Amatyakaraka Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AMATYAKARAKA (CAREER SIGNIFICATOR)",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AppleCosmicTheme.nebulaViolet, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "☿ MERCURY EXALTED",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "AI Systems & Quantitative Architecture",
                    style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Exalted Mercury in Virgo trining your 10th-house Mars produces a rare synthesis: deep architectural rigour combined with decisive, uncompromising product execution.",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, height: 1.45, color: Colors.white.withOpacity(0.85)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 2-Column Executive Metrics (Left Card Flips in 3D)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _toggleFounderFlip,
                    child: AnimatedBuilder(
                      animation: _flipAnimation,
                      builder: (context, child) {
                        final angle = _flipAnimation.value * math.pi;
                        final isUnder = angle > (math.pi / 2);
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(angle),
                          alignment: Alignment.center,
                          child: Container(
                            height: 110,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.4)),
                            ),
                            child: isUnder
                                ? Transform(
                                    transform: Matrix4.identity()..rotateY(math.pi),
                                    alignment: Alignment.center,
                                    child: const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("MATHEMATICAL PROOF", style: TextStyle(fontFamily: 'Space Mono', fontSize: 7.5, color: AppleCosmicTheme.champagneGold)),
                                        SizedBox(height: 3),
                                        Text("Sun Shadbala: 1.42\nMars in Digbala Peak\n10th Lord in D10", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white70)),
                                      ],
                                    ),
                                  )
                                : const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("FOUNDER VS EXEC", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white54)),
                                      SizedBox(height: 4),
                                      Text("84% Founder", style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold)),
                                      SizedBox(height: 2),
                                      Text("Tap to inspect proof →", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8, color: Colors.white38)),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 110,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("NEXT BREAKOUT", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white54)),
                        SizedBox(height: 4),
                        Text("NOV 2026", style: TextStyle(fontFamily: 'Space Mono', fontSize: 16, fontWeight: FontWeight.bold, color: AppleCosmicTheme.emeraldSync)),
                        SizedBox(height: 4),
                        Text("Mercury-Jupiter Conjunction", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 10, color: Colors.white60)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Recommended Domains Pill Cloud
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("RECOMMENDED DOMAINS", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white54)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildDomainChip("Agentic AI Systems"),
                      _buildDomainChip("Quantitative Finance"),
                      _buildDomainChip("Consumer Product Ventures"),
                      _buildDomainChip("Autonomous Robotics"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Read Full 42-Page Dossier Link
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _onOpenFullDossier,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.doc_text, size: 14, color: AppleCosmicTheme.champagneGold),
                  SizedBox(width: 6),
                  Text(
                    "Read Full 42-Page Executive Dossier (Screen 19) →",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, color: AppleCosmicTheme.champagneGold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Bottom CTA
            GestureDetector(
              onTap: _onNavigateToSynastry,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AppleCosmicTheme.nebulaViolet, AppleCosmicTheme.auroraPink],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.35), blurRadius: 18),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Explore Synastry Flow (Screen 13) →",
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

  Widget _buildDomainChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white),
      ),
    );
  }
}
