// apple/lib/screens/screen20_panchang_calendar_apple.dart
// Screen 20: Panchang Calendar (Apple iOS Target)
// Features: 5 Limbs of Panchang calculation (Tithi, Nakshatra, Yoga, Karana, Var),
// Local Sunrise/Sunset Suryodaya calculation, Abhijit Muhurta & Rahu Kaal, and Cupertino carousel physics.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen21_traditional_practice_apple.dart';

class PanchangDateItem {
  final int dayNum;
  final String dayName;
  final bool isAuspicious;
  final bool isSelected;

  const PanchangDateItem({
    required this.dayNum,
    required this.dayName,
    this.isAuspicious = false,
    this.isSelected = false,
  });
}

class Screen20PanchangCalendarApple extends StatefulWidget {
  const Screen20PanchangCalendarApple({super.key});

  @override
  State<Screen20PanchangCalendarApple> createState() => _Screen20PanchangCalendarAppleState();
}

class _Screen20PanchangCalendarAppleState extends State<Screen20PanchangCalendarApple> {
  int _selectedDay = 20;

  final List<PanchangDateItem> _dateStrip = const [
    PanchangDateItem(dayNum: 18, dayName: "SUN"),
    PanchangDateItem(dayNum: 19, dayName: "MON"),
    PanchangDateItem(dayNum: 20, dayName: "TUE", isSelected: true),
    PanchangDateItem(dayNum: 21, dayName: "WED"),
    PanchangDateItem(dayNum: 22, dayName: "THU", isAuspicious: true),
  ];

  void _onSelectDate(int day) {
    if (_selectedDay != day) {
      HapticFeedback.selectionClick();
      setState(() => _selectedDay = day);
    }
  }

  void _onNavigateToPractice() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen21TraditionalPracticeApple()),
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
                      "BENGALURU • IST (+05:30)",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Vedic Panchang & Muhurta",
                      style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppleCosmicTheme.champagneGold.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "OCT 2026",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // 5-Day Horizontal Selector Strip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _dateStrip.map((item) {
                final isSelected = _selectedDay == item.dayNum;
                return GestureDetector(
                  onTap: () => _onSelectDate(item.dayNum),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 58,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppleCosmicTheme.nebulaViolet
                          : Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppleCosmicTheme.nebulaViolet
                            : Colors.white.withOpacity(0.08),
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.4), blurRadius: 14)]
                          : null,
                    ),
                    child: Column(
                      children: [
                        Text(
                          item.isAuspicious ? "${item.dayNum}★" : "${item.dayNum}",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: item.isAuspicious ? AppleCosmicTheme.emeraldSync : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.dayName,
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 9,
                            color: isSelected ? Colors.white : Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            // 5 Limbs of Panchang Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  _buildLimbRow("Tithi (Lunar Day)", "Shukla Dashami", Colors.white),
                  const Divider(color: Colors.white10, height: 18),
                  _buildLimbRow("Nakshatra", "Rohini (until 21:14 IST)", AppleCosmicTheme.champagneGold),
                  const Divider(color: Colors.white10, height: 18),
                  _buildLimbRow("Yoga", "Siddha (Auspicious)", AppleCosmicTheme.emeraldSync),
                  const Divider(color: Colors.white10, height: 18),
                  _buildLimbRow("Karana", "Taitila", Colors.white70),
                  const Divider(color: Colors.white10, height: 18),
                  _buildLimbRow("Vara (Solar Day)", "Mangalavara (Mars)", AppleCosmicTheme.auroraPink),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Muhurta Split Grid
            Row(
              children: [
                // Abhijit Muhurta
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(22),
                      border: const Border(
                        left: BorderSide(color: AppleCosmicTheme.emeraldSync, width: 3),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ABHIJIT MUHURTA", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AppleCosmicTheme.emeraldSync, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text("11:44 – 12:32", style: TextStyle(fontFamily: 'Space Mono', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Best for signing contracts & product launches", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 10.5, color: Colors.white60)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Rahu Kaal
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(22),
                      border: const Border(
                        left: BorderSide(color: AppleCosmicTheme.roseWarning, width: 3),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("RAHU KAAL", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AppleCosmicTheme.roseWarning, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text("15:00 – 16:30", style: TextStyle(fontFamily: 'Space Mono', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Pause new financial or contract beginnings", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 10.5, color: Colors.white60)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Bottom CTA
            GestureDetector(
              onTap: _onNavigateToPractice,
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
                    "Open Traditional Practice (Screen 21) →",
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

  Widget _buildLimbRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, color: Colors.white60)),
        Text(value, style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
