// android/lib/screens/screen10_weekly_forecast_android.dart
// Screen 10: Weekly Forecast (Google Android Target)
// Features: Interactive 7-Day momentum wave bar chart with VibrationEffect tick on horizontal scrub,
// 3D bar scaling, and Day-by-Day Power/Caution inspector stack.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen11_yearly_transits_android.dart';

class DayForecastItem {
  final String dayLetter;
  final String dateStr;
  final int syncScore;
  final bool isPeak;
  final bool isCaution;
  final String aspect;
  final String summary;

  const DayForecastItem({
    required this.dayLetter,
    required this.dateStr,
    required this.syncScore,
    this.isPeak = false,
    this.isCaution = false,
    required this.aspect,
    required this.summary,
  });
}

class Screen10WeeklyForecastAndroid extends StatefulWidget {
  const Screen10WeeklyForecastAndroid({super.key});

  @override
  State<Screen10WeeklyForecastAndroid> createState() => _Screen10WeeklyForecastAndroidState();
}

class _Screen10WeeklyForecastAndroidState extends State<Screen10WeeklyForecastAndroid> {
  int _activeDayIndex = 4; // Friday Peak

  final List<DayForecastItem> _weekDays = const [
    DayForecastItem(
      dayLetter: "M",
      dateStr: "MON • OCT 19",
      syncScore: 68,
      aspect: "Moon in Aries 3rd House",
      summary: "High communicative energy; great for drafting specifications.",
    ),
    DayForecastItem(
      dayLetter: "T",
      dateStr: "TUE • OCT 20",
      syncScore: 88,
      aspect: "Mercury Trine Natal Jupiter",
      summary: "Peak strategic clarity. Bold architectural launches favored.",
    ),
    DayForecastItem(
      dayLetter: "W",
      dateStr: "WED • OCT 21",
      syncScore: 74,
      aspect: "Sun Sextile Mars",
      summary: "Strong physical vitality. Clear outstanding engineering backlog.",
    ),
    DayForecastItem(
      dayLetter: "T",
      dateStr: "THU • OCT 22",
      syncScore: 54,
      isCaution: true,
      aspect: "Moon Square Natal Saturn",
      summary: "Pacing required. Avoid rushing contract approvals or over-promising.",
    ),
    DayForecastItem(
      dayLetter: "F★",
      dateStr: "FRI • OCT 23",
      syncScore: 96,
      isPeak: true,
      aspect: "Sun Enters Scorpio + Moon Conjunct Jupiter",
      summary: "Peak cosmic sync. Ideal for major venture pitches and public deployments.",
    ),
    DayForecastItem(
      dayLetter: "S",
      dateStr: "SAT • OCT 24",
      syncScore: 78,
      aspect: "Venus Enters Sagittarius",
      summary: "Warm interpersonal harmony; connect with close collaborators.",
    ),
    DayForecastItem(
      dayLetter: "S",
      dateStr: "SUN • OCT 25",
      syncScore: 65,
      aspect: "Moon in Gemini 5th House",
      summary: "Restorative day for philosophical contemplation and acoustic meditation.",
    ),
  ];

  void _onBarTapped(int index) {
    if (_activeDayIndex != index) {
      HapticFeedback.vibrate();
      setState(() => _activeDayIndex = index);
    }
  }

  void _onNavigateToYearly() {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen11YearlyTransitsAndroid()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeDay = _weekDays[_activeDayIndex];

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OCT 19 – OCT 25",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white.withOpacity(0.6), letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "7-Day Momentum Wave",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AndroidCosmicTheme.champagneGold.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "PEAK: FRI",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // 7-Day Interactive Momentum Bar Chart Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.2), blurRadius: 24),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "SYNCHRONICITY INDEX",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white54),
                      ),
                      Text(
                        "${activeDay.syncScore}% SYNC",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: activeDay.isPeak
                              ? AndroidCosmicTheme.champagneGold
                              : (activeDay.isCaution ? AndroidCosmicTheme.roseWarning : AndroidCosmicTheme.emeraldSync),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(_weekDays.length, (i) {
                        final item = _weekDays[i];
                        final isSelected = _activeDayIndex == i;
                        final barHeight = (item.syncScore / 100) * 90;

                        return InkWell(
                          onTap: () => _onBarTapped(i),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                width: 28,
                                height: barHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: item.isPeak
                                        ? [AndroidCosmicTheme.nebulaViolet, AndroidCosmicTheme.champagneGold]
                                        : (item.isCaution
                                            ? [AndroidCosmicTheme.roseWarning.withOpacity(0.4), AndroidCosmicTheme.roseWarning]
                                            : [AndroidCosmicTheme.nebulaViolet.withOpacity(0.6), AndroidCosmicTheme.nebulaViolet]),
                                  ),
                                  border: isSelected ? Border.all(color: Colors.white, width: 1.5) : null,
                                  boxShadow: item.isPeak
                                      ? [
                                          BoxShadow(
                                            color: AndroidCosmicTheme.champagneGold.withOpacity(0.5),
                                            blurRadius: 14,
                                          )
                                        ]
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.dayLetter,
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 10,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? Colors.white : Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Day-by-Day Inspector Card (Dynamic reactive to selected day)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border(
                  left: BorderSide(
                    color: activeDay.isPeak
                        ? AndroidCosmicTheme.champagneGold
                        : (activeDay.isCaution ? AndroidCosmicTheme.roseWarning : AndroidCosmicTheme.emeraldSync),
                    width: 3,
                  ),
                  top: BorderSide(color: Colors.white.withOpacity(0.08)),
                  right: BorderSide(color: Colors.white.withOpacity(0.08)),
                  bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${activeDay.dateStr} • ${activeDay.isPeak ? 'POWER WINDOW' : (activeDay.isCaution ? 'CAUTION' : 'STEADY')}",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: activeDay.isPeak
                              ? AndroidCosmicTheme.champagneGold
                              : (activeDay.isCaution ? AndroidCosmicTheme.roseWarning : AndroidCosmicTheme.emeraldSync),
                        ),
                      ),
                      Text(
                        "${activeDay.syncScore}% SYNC",
                        style: const TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    activeDay.aspect,
                    style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activeDay.summary,
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, height: 1.4, color: Colors.white.withOpacity(0.75)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bottom CTA (Material 3 ElevatedButton)
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
                onPressed: _onNavigateToYearly,
                child: const Text(
                  "View Yearly Macro Transits (Screen 11) →",
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
