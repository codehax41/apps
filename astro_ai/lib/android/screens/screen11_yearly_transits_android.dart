// android/lib/screens/screen11_yearly_transits_android.dart
// Screen 11: Yearly Transits (Macro Gochara) (Google Android Target)
// Features: Orbital Time-Scrubber (2026/2027/2028), Jupiter/Saturn/Rahu transit cards,
// Sade Sati status badge, VibrationEffect haptics, and ClampingScrollPhysics.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen12_career_reading_android.dart';

class Screen11YearlyTransitsAndroid extends StatefulWidget {
  const Screen11YearlyTransitsAndroid({super.key});

  @override
  State<Screen11YearlyTransitsAndroid> createState() => _Screen11YearlyTransitsAndroidState();
}

class _Screen11YearlyTransitsAndroidState extends State<Screen11YearlyTransitsAndroid> {
  int _selectedYear = 2026;

  void _onSelectYear(int year) {
    if (_selectedYear != year) {
      HapticFeedback.vibrate();
      setState(() => _selectedYear = year);
    }
  }

  void _onNavigateToCareer() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen12CareerReadingAndroid()),
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
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                      return InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () => _onSelectYear(y),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? AndroidCosmicTheme.nebulaViolet : Colors.transparent,
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
                    AndroidCosmicTheme.nebulaViolet.withOpacity(0.35),
                    AndroidCosmicTheme.auroraPink.withOpacity(0.2),
                  ],
                ),
                border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.25), blurRadius: 22),
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
                          color: AndroidCosmicTheme.champagneGold.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          "JUPITER EXALTATION TRANSIT",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold),
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
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12.5, height: 1.45, color: Colors.white.withOpacity(0.85)),
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
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AndroidCosmicTheme.nebulaViolet, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AndroidCosmicTheme.emeraldSync.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "SADE SATI: EXEMPT",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 8, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.emeraldSync),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Disciplined Wealth Accumulation",
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Restructures long-term asset diversification and family capital foundations through late 2027.",
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, color: Colors.white.withOpacity(0.7)),
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
                          color: AndroidCosmicTheme.nebulaViolet,
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
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AndroidCosmicTheme.auroraPink, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "NOV 2026 SHIFT",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AndroidCosmicTheme.champagneGold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Radical Identity Reinvention",
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Accelerates public visibility in artificial intelligence, deep tech, and unconventional venture formation.",
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

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
                onPressed: _onNavigateToCareer,
                child: const Text(
                  "Open Career Reading (Screen 12) →",
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
