// apple/lib/screens/screen11_yearly_transits_apple.dart
// Screen 11: Yearly Transits (Macro Gochara) (Apple iOS Target)
// Features: Orbital Time-Scrubber (2026/2027/2028), Jupiter/Saturn/Rahu transit cards,
// Sade Sati status badge, and Cupertino BouncingScrollPhysics.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen12_career_reading_apple.dart';

class Screen11YearlyTransitsApple extends StatefulWidget {
  const Screen11YearlyTransitsApple({super.key});

  @override
  State<Screen11YearlyTransitsApple> createState() => _Screen11YearlyTransitsAppleState();
}

class _Screen11YearlyTransitsAppleState extends State<Screen11YearlyTransitsApple> {
  int _selectedYear = 2026;

  void _onSelectYear(int year) {
    if (_selectedYear != year) {
      HapticFeedback.selectionClick();
      setState(() => _selectedYear = year);
    }
  }

  void _onNavigateToCareer() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen12CareerReadingApple()),
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
            // Top Bar with Year Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MACRO GOCHARA 2026–2028",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Yearly Planetary Shifts",
                      style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [2026, 2027, 2028].map((y) {
                      final isSelected = _selectedYear == y;
                      return GestureDetector(
                        onTap: () => _onSelectYear(y),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? AppleCosmicTheme.nebulaViolet : Colors.transparent,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            "$y",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 9,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.white60,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Macro Transit Card 1: Jupiter (Guru Gochara)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    AppleCosmicTheme.nebulaViolet.withOpacity(0.35),
                    AppleCosmicTheme.auroraPink.withOpacity(0.2),
                  ],
                ),
                border: Border.all(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.5)),
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppleCosmicTheme.champagneGold.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          "JUPITER EXALTATION TRANSIT",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                        ),
                      ),
                      const Text(
                        "JUN 2026 – JUL 2027",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Guru in 6th/11th Axis",
                    style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Once-in-12-year expansion of professional authority, technical executive ownership, and equity liquidity. Overcomes organizational friction with ease.",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, height: 1.45, color: Colors.white.withOpacity(0.85)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Macro Transit Card 2: Saturn (Shani Gochara & Sade Sati)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.09)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "♄ SATURN IN PISCES (2ND HOUSE)",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AppleCosmicTheme.nebulaViolet, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppleCosmicTheme.emeraldSync.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "SADE SATI: EXEMPT",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 8, fontWeight: FontWeight.bold, color: AppleCosmicTheme.emeraldSync),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Disciplined Wealth Accumulation",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Restructures long-term asset diversification and family capital foundations through late 2027.",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 12),
                  // Progress Bar 66%
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      height: 5,
                      color: Colors.white12,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          color: AppleCosmicTheme.nebulaViolet,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text("66% Completed", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white38)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Macro Transit Card 3: Rahu/Ketu Nodal Shift
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.09)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "☊ RAHU IN AQUARIUS (1ST HOUSE)",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AppleCosmicTheme.auroraPink, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "NOV 2026 SHIFT",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AppleCosmicTheme.champagneGold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Radical Identity Reinvention",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Accelerates public visibility in artificial intelligence, deep tech, and unconventional venture formation.",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bottom CTA
            GestureDetector(
              onTap: _onNavigateToCareer,
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
                    "Open Career Reading (Screen 12) →",
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
