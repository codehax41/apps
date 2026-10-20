// android/lib/screens/screen12_career_reading_android.dart
// Screen 12: Career Reading (Google Android Target)
// Features: D10 Dasamsa & Jaimini Amatyakaraka analysis, 3D metric card flip (84% Founder breakdown),
// VibrationEffect haptic sync, and Material 3 domain chips.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen13_compatibility_intro_android.dart';
import 'screen19_career_report_detail_android.dart';

class Screen12CareerReadingAndroid extends StatefulWidget {
  const Screen12CareerReadingAndroid({super.key});

  @override
  State<Screen12CareerReadingAndroid> createState() => _Screen12CareerReadingAndroidState();
}

class _Screen12CareerReadingAndroidState extends State<Screen12CareerReadingAndroid>
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
    HapticFeedback.vibrate();
    if (_isFounderFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFounderFlipped = !_isFounderFlipped);
  }

  void _onNavigateToSynastry() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen13CompatibilityIntroAndroid()),
    );
  }

  void _onOpenFullDossier() {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen19CareerReportDetailAndroid()),
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
                      "D10 DASAMSA + 10TH HOUSE",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Vocation & Leadership",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                    "RUCHAKA YOGA",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold),
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
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AndroidCosmicTheme.nebulaViolet, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "☿ MERCURY EXALTED",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold),
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
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12.5, height: 1.45, color: Colors.white.withOpacity(0.85)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 2-Column Executive Metrics (Left Card Flips in 3D)
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
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
                              border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.4)),
                            ),
                            child: isUnder
                                ? Transform(
                                    transform: Matrix4.identity()..rotateY(math.pi),
                                    alignment: Alignment.center,
                                    child: const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("MATHEMATICAL PROOF", style: TextStyle(fontFamily: 'Space Mono', fontSize: 7.5, color: AndroidCosmicTheme.champagneGold)),
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
                                      Text("84% Founder", style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold)),
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
                        Text("NOV 2026", style: TextStyle(fontFamily: 'Space Mono', fontSize: 16, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.emeraldSync)),
                        SizedBox(height: 4),
                        Text("Mercury-Jupiter Conjunction", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 10, color: Colors.white60)),
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
            Center(
              child: TextButton.icon(
                onPressed: _onOpenFullDossier,
                icon: const Icon(Icons.description, size: 16, color: AndroidCosmicTheme.champagneGold),
                label: const Text(
                  "Read Full 42-Page Executive Dossier (Screen 19) →",
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, color: AndroidCosmicTheme.champagneGold),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Bottom CTA
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
                onPressed: _onNavigateToSynastry,
                child: const Text(
                  "Explore Synastry Flow (Screen 13) →",
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
        style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, color: Colors.white),
      ),
    );
  }
}
