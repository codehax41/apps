// apple/lib/screens/screen03_birth_details_apple.dart
// Screen 03: Birth Details (Temporal Coordinates) (Apple iOS Target)
// Features: CupertinoPicker mechanical tick haptic sync, ListWheelScrollView 3D cylindrical perspective,
// Dynamic Tithi/Paksha calculation, and Cupertino keyboard dismissal ergonomics.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen04_birthplace_search_apple.dart';

class Screen03BirthDetailsApple extends StatefulWidget {
  const Screen03BirthDetailsApple({super.key});

  @override
  State<Screen03BirthDetailsApple> createState() => _Screen03BirthDetailsAppleState();
}

class _Screen03BirthDetailsAppleState extends State<Screen03BirthDetailsApple> {
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
    // Dynamic Tithi / Paksha calculation heuristic
    return (_selectedDay <= 15) ? "SHUKLA PAKSHA" : "KRISHNA PAKSHA";
  }

  void _onNext() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => const Screen04BirthplaceSearchApple(),
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
    return ApplePlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    Container(width: 24, height: 4, decoration: BoxDecoration(color: AppleCosmicTheme.nebulaViolet, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 4),
                    Container(width: 24, height: 4, decoration: BoxDecoration(color: AppleCosmicTheme.nebulaViolet, borderRadius: BorderRadius.circular(2))),
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
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Component 1: Seeker Name Card
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: _nameController,
                          style: const TextStyle(
                            fontFamily: '.SF Pro Text',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          decoration: null,
                          cursorColor: AppleCosmicTheme.champagneGold,
                        ),
                      ),
                      const Text("✦", style: TextStyle(color: AppleCosmicTheme.emeraldSync, fontSize: 16)),
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
                          color: AppleCosmicTheme.champagneGold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.3)),
                        ),
                        child: Text(
                          _currentPaksha,
                          style: const TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppleCosmicTheme.champagneGold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 120,
                    child: Row(
                      children: [
                        // Day Drum
                        Expanded(
                          child: CupertinoPicker(
                            itemExtent: 38,
                            scrollController: FixedExtentScrollController(initialItem: _selectedDay - 1),
                            onSelectedItemChanged: (index) {
                              HapticFeedback.selectionClick();
                              setState(() => _selectedDay = index + 1);
                            },
                            children: List.generate(31, (i) => Center(
                              child: Text(
                                "${i + 1}".padLeft(2, '0'),
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (i + 1 == _selectedDay) ? AppleCosmicTheme.champagneGold : Colors.white60,
                                ),
                              ),
                            )),
                          ),
                        ),
                        // Month Drum
                        Expanded(
                          child: CupertinoPicker(
                            itemExtent: 38,
                            scrollController: FixedExtentScrollController(initialItem: _selectedMonth - 1),
                            onSelectedItemChanged: (index) {
                              HapticFeedback.selectionClick();
                              setState(() => _selectedMonth = index + 1);
                            },
                            children: List.generate(_months.length, (i) => Center(
                              child: Text(
                                _months[i],
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (i + 1 == _selectedMonth) ? AppleCosmicTheme.nebulaViolet : Colors.white60,
                                ),
                              ),
                            )),
                          ),
                        ),
                        // Year Drum
                        Expanded(
                          child: CupertinoPicker(
                            itemExtent: 38,
                            scrollController: FixedExtentScrollController(initialItem: _selectedYear - 1920),
                            onSelectedItemChanged: (index) {
                              HapticFeedback.selectionClick();
                              setState(() => _selectedYear = 1920 + index);
                            },
                            children: List.generate(107, (i) => Center(
                              child: Text(
                                "${1920 + i}",
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (1920 + i == _selectedYear) ? Colors.white : Colors.white60,
                                ),
                              ),
                            )),
                          ),
                        ),
                      ],
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
                          color: AppleCosmicTheme.nebulaViolet.withOpacity(0.9),
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
                          color: AppleCosmicTheme.nebulaViolet.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.5)),
                        ),
                        child: Text(
                          "$_selectedMinute".padLeft(2, '0'),
                          style: const TextStyle(fontFamily: 'Space Mono', fontSize: 20, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() => _isAm = true);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _isAm ? AppleCosmicTheme.nebulaViolet : Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "AM",
                                style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: _isAm ? Colors.white : Colors.white38),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() => _isAm = false);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: !_isAm ? AppleCosmicTheme.nebulaViolet : Colors.white.withOpacity(0.06),
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

            // Bottom CTA
            GestureDetector(
              onTap: _onNext,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AppleCosmicTheme.nebulaViolet, AppleCosmicTheme.auroraPink],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppleCosmicTheme.nebulaViolet.withOpacity(0.4),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Next: Geodetic Birthplace →",
                    style: TextStyle(
                      fontFamily: '.SF Pro Text',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
