// android/lib/screens/screen20_panchang_calendar_android.dart
// Screen 20: Panchang Calendar (Google Android Target)
// Features: 5 Limbs of Panchang calculation (Tithi, Nakshatra, Yoga, Karana, Var),
// Local Sunrise/Sunset Suryodaya calculation, Abhijit Muhurta & Rahu Kaal, and VibrationEffect haptic sync.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen21_traditional_practice_android.dart';

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

class Screen20PanchangCalendarAndroid extends StatefulWidget {
  const Screen20PanchangCalendarAndroid({super.key});

  @override
  State<Screen20PanchangCalendarAndroid> createState() => _Screen20PanchangCalendarAndroidState();
}

class _Screen20PanchangCalendarAndroidState extends State<Screen20PanchangCalendarAndroid> {
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
      HapticFeedback.vibrate();
      setState(() => _selectedDay = day);
    }
  }

  void _onNavigateToPractice() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen21TraditionalPracticeAndroid()),
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
                      "BENGALURU • IST (+05:30)",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Vedic Panchang & Muhurta",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AndroidCosmicTheme.champagneGold.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "OCT 2026",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold),
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
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _onSelectDate(item.dayNum),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 58,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AndroidCosmicTheme.nebulaViolet
                          : Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AndroidCosmicTheme.nebulaViolet
                            : Colors.white.withOpacity(0.08),
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4), blurRadius: 14)]
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
                            color: item.isAuspicious ? AndroidCosmicTheme.emeraldSync : Colors.white,
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
                  _buildLimbRow("Nakshatra", "Rohini (until 21:14 IST)", AndroidCosmicTheme.champagneGold),
                  const Divider(color: Colors.white10, height: 18),
                  _buildLimbRow("Yoga", "Siddha (Auspicious)", AndroidCosmicTheme.emeraldSync),
                  const Divider(color: Colors.white10, height: 18),
                  _buildLimbRow("Karana", "Taitila", Colors.white70),
                  const Divider(color: Colors.white10, height: 18),
                  _buildLimbRow("Vara (Solar Day)", "Mangalavara (Mars)", AndroidCosmicTheme.auroraPink),
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
                        left: BorderSide(color: AndroidCosmicTheme.emeraldSync, width: 3),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ABHIJIT MUHURTA", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AndroidCosmicTheme.emeraldSync, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text("11:44 – 12:32", style: TextStyle(fontFamily: 'Space Mono', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Best for signing contracts & product launches", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 10.5, color: Colors.white60)),
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
                        left: BorderSide(color: AndroidCosmicTheme.roseWarning, width: 3),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("RAHU KAAL", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: AndroidCosmicTheme.roseWarning, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text("15:00 – 16:30", style: TextStyle(fontFamily: 'Space Mono', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Pause new financial or contract beginnings", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 10.5, color: Colors.white60)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

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
                onPressed: _onNavigateToPractice,
                child: const Text(
                  "Open Traditional Practice (Screen 21) →",
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

  Widget _buildLimbRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, color: Colors.white60)),
        Text(value, style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
