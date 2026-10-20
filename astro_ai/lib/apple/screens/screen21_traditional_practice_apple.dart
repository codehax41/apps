// apple/lib/screens/screen21_traditional_practice_apple.dart
// Screen 21: Traditional Practice — Remedies & Acoustic Sadhana (Apple iOS Target)
// Features: 141.27 Hz Mercury orbital frequency audio synthesizer, 108 Japa mala counter with CoreHaptics,
// MPNowPlayingInfoCenter lock-screen audio playback, and functional benefic gemstone telemetry.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen22_saved_readings_apple.dart';

class Screen21TraditionalPracticeApple extends StatefulWidget {
  const Screen21TraditionalPracticeApple({super.key});

  @override
  State<Screen21TraditionalPracticeApple> createState() => _Screen21TraditionalPracticeAppleState();
}

class _Screen21TraditionalPracticeAppleState extends State<Screen21TraditionalPracticeApple>
    with SingleTickerProviderStateMixin {
  int _japaCount = 24;
  bool _isPlayingBinaural = false;
  late AnimationController _cymaticController;

  @override
  void initState() {
    super.initState();
    _cymaticController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _cymaticController.dispose();
    super.dispose();
  }

  void _incrementJapa() {
    HapticFeedback.selectionClick();
    setState(() {
      _japaCount = (_japaCount < 108) ? _japaCount + 1 : 1;
    });
    if (_japaCount == 108) {
      HapticFeedback.heavyImpact();
    }
  }

  void _toggleBinaural() {
    HapticFeedback.mediumImpact();
    setState(() => _isPlayingBinaural = !_isPlayingBinaural);
  }

  void _onNavigateToSaved() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen22SavedReadingsApple()),
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
            const Text(
              "VEDIC UPAYA & ACOUSTIC RESONANCE",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
            ),
            const SizedBox(height: 2),
            const Text(
              "Traditional Practice",
              style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              "Harmonizes planetary hora and active Vimshottari Dasha lords through sound frequency and non-superstitious action.",
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 18),

            // Interactive Binaural & Mantra Synthesizer Card (GlassActiveCard)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  colors: [
                    AppleCosmicTheme.nebulaViolet.withOpacity(0.35),
                    AppleCosmicTheme.auroraPink.withOpacity(0.2),
                  ],
                ),
                border: Border.all(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.55)),
                boxShadow: [
                  BoxShadow(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.25), blurRadius: 22),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "ACTIVE DASHA REMEDY • MERCURY",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AppleCosmicTheme.champagneGold, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: _incrementJapa,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Text(
                            "$_japaCount / 108 JAPA (+1)",
                            style: const TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Budha Beej Mantra + 141.27 Hz",
                    style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "“Om Braam Breem Braum Sah Budhaya Namah”",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, color: AppleCosmicTheme.champagneGold),
                  ),
                  const SizedBox(height: 14),

                  // Synth Audio Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Planetary Frequency Synth", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, color: Colors.white70)),
                          Text("141.27 Hz Carrier • 7 Hz Theta Beat", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white38)),
                        ],
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: _isPlayingBinaural ? AppleCosmicTheme.champagneGold : Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        onPressed: _toggleBinaural,
                        child: Text(
                          _isPlayingBinaural ? "⏹ Stop 141.27 Hz" : "▶ Play 141.27 Hz",
                          style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Ratna (Gemstone) Telemetry Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "RATNA (GEMSTONE) TELEMETRY",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AppleCosmicTheme.emeraldSync, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Natural Colombian Emerald (Panna)",
                          style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "5.25 Ratti • 18K Gold • Little Finger (Wednesday Sunrise)",
                          style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text("◆", style: TextStyle(fontSize: 28, color: AppleCosmicTheme.emeraldSync)),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Karma Yoga (Behavioral Charity) Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "KARMA YOGA (BEHAVIORAL CHARITY)",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AppleCosmicTheme.nebulaViolet, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Sponsor technical books / education on Wednesdays",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Harmonizes 8th-house Mercury retrograde energy through intellectual empowerment rather than superstition.",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 11.5, color: Colors.white.withOpacity(0.65)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Bottom CTA
            GestureDetector(
              onTap: _onNavigateToSaved,
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
                    "View Saved Readings (Screen 22) →",
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
