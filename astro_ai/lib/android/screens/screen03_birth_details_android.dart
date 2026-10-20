// android/lib/screens/screen03_birth_details_android.dart
// Screen 03: Birth Details (Temporal Coordinates) (Google Android Target)
// Features: ListWheelScrollView 3D cylindrical perspective (perspective: 0.004, diameterRatio: 1.4, squeeze: 1.15),
// VibrationEffect haptic sync, Android shader fade-mask, and edge-to-edge keyboard ergonomics.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen04_birthplace_search_android.dart';

class Screen03BirthDetailsAndroid extends StatefulWidget {
  const Screen03BirthDetailsAndroid({super.key});

  @override
  State<Screen03BirthDetailsAndroid> createState() => _Screen03BirthDetailsAndroidState();
}

class _Screen03BirthDetailsAndroidState extends State<Screen03BirthDetailsAndroid> {
  final TextEditingController _nameController =
      TextEditingController(text: "Ramsundar Mahato");

  int _selectedDay = 14;
  int _selectedMonth = 9; // Sep
  int _selectedYear = 1996;
  final int _selectedHour = 6;
  final int _selectedMinute = 42;
  bool _isAm = true;

  final List<String> _months = [
    "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
    "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"
  ];

  String get _currentPaksha {
    return (_selectedDay <= 15) ? "SHUKLA PAKSHA" : "KRISHNA PAKSHA";
  }

  void _onNext() {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Screen04BirthplaceSearchAndroid(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
            // Top Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "STEP 02 / 03",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 10,
                    color: Colors.white60,
                  ),
                ),
                Row(
                  children: [
                    Container(width: 24, height: 4, decoration: BoxDecoration(color: AndroidCosmicTheme.nebulaViolet, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 4),
                    Container(width: 24, height: 4, decoration: BoxDecoration(color: AndroidCosmicTheme.nebulaViolet, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 4),
                    Container(width: 24, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              "Temporal Coordinates",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Ascendant (Lagna) shifts by 1° every 4 minutes.",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Component 1: Seeker Name Card (Material 3 TextField)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "COSMIC SEEKER NAME",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 9,
                      letterSpacing: 1.2,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 4),
                          ),
                          cursorColor: AndroidCosmicTheme.champagneGold,
                        ),
                      ),
                      const Text("✦", style: TextStyle(color: AndroidCosmicTheme.emeraldSync, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Component 2: 3D Cylindrical Date Tumbler Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "DATE OF BIRTH",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          letterSpacing: 1.2,
                          color: Colors.white54,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AndroidCosmicTheme.champagneGold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.3)),
                        ),
                        child: Text(
                          _currentPaksha,
                          style: const TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AndroidCosmicTheme.champagneGold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 120,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.white,
                            Colors.white,
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.25, 0.75, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Row(
                        children: [
                          // 3D ListWheelScrollView Day Drum
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 38,
                              perspective: 0.004,
                              diameterRatio: 1.4,
                              squeeze: 1.15,
                              physics: const FixedExtentScrollPhysics(),
                              controller: FixedExtentScrollController(initialItem: _selectedDay - 1),
                              onSelectedItemChanged: (index) {
                                HapticFeedback.vibrate();
                                setState(() => _selectedDay = index + 1);
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 31,
                                builder: (context, i) => Center(
                                  child: Text(
                                    "${i + 1}".padLeft(2, '0'),
                                    style: TextStyle(
                                      fontFamily: 'Space Mono',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (i + 1 == _selectedDay) ? AndroidCosmicTheme.champagneGold : Colors.white60,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Month Drum
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 38,
                              perspective: 0.004,
                              diameterRatio: 1.4,
                              squeeze: 1.15,
                              physics: const FixedExtentScrollPhysics(),
                              controller: FixedExtentScrollController(initialItem: _selectedMonth - 1),
                              onSelectedItemChanged: (index) {
                                HapticFeedback.vibrate();
                                setState(() => _selectedMonth = index + 1);
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: _months.length,
                                builder: (context, i) => Center(
                                  child: Text(
                                    _months[i],
                                    style: TextStyle(
                                      fontFamily: 'Space Mono',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (i + 1 == _selectedMonth) ? AndroidCosmicTheme.nebulaViolet : Colors.white60,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Year Drum
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 38,
                              perspective: 0.004,
                              diameterRatio: 1.4,
                              squeeze: 1.15,
                              physics: const FixedExtentScrollPhysics(),
                              controller: FixedExtentScrollController(initialItem: _selectedYear - 1920),
                              onSelectedItemChanged: (index) {
                                HapticFeedback.vibrate();
                                setState(() => _selectedYear = 1920 + index);
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 107,
                                builder: (context, i) => Center(
                                  child: Text(
                                    "${1920 + i}",
                                    style: TextStyle(
                                      fontFamily: 'Space Mono',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (1920 + i == _selectedYear) ? Colors.white : Colors.white60,
                                    ),
                                  ),
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
            ),

            const SizedBox(height: 14),

            // Component 3: Precision Time of Birth Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "EXACT TIME OF BIRTH",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          letterSpacing: 1.2,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        "±1 MIN PRECISION",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Text(
                          "$_selectedHour".padLeft(2, '0'),
                          style: const TextStyle(fontFamily: 'Space Mono', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(":", style: TextStyle(fontSize: 20, color: Colors.white54)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.5)),
                        ),
                        child: Text(
                          "$_selectedMinute".padLeft(2, '0'),
                          style: const TextStyle(fontFamily: 'Space Mono', fontSize: 20, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              HapticFeedback.vibrate();
                              setState(() => _isAm = true);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _isAm ? AndroidCosmicTheme.nebulaViolet : Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "AM",
                                style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: _isAm ? Colors.white : Colors.white38),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: () {
                              HapticFeedback.vibrate();
                              setState(() => _isAm = false);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: !_isAm ? AndroidCosmicTheme.nebulaViolet : Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "PM",
                                style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: !_isAm ? Colors.white : Colors.white38),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Bottom CTA (Material 3 ElevatedButton)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AndroidCosmicTheme.nebulaViolet,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 6,
                ),
                onPressed: _onNext,
                child: const Text(
                  "Next: Geodetic Birthplace →",
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
