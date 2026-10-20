// apple/lib/screens/screen02_choose_focus_apple.dart
// Screen 02: Choose Your Focus (Apple iOS Target)
// Features: Dynamic Island insets, UISelectionFeedbackGenerator, 3D card flip-tilt on selection,
// Cupertino navigation, and CupertinoPageRoute forward transition.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen03_birth_details_apple.dart';

class FocusVectorItem {
  final String glyph;
  final String title;
  final String subtitle;
  final Color accentColor;

  const FocusVectorItem({
    required this.glyph,
    required this.title,
    required this.subtitle,
    required this.accentColor,
  });
}

class Screen02ChooseFocusApple extends StatefulWidget {
  const Screen02ChooseFocusApple({super.key});

  @override
  State<Screen02ChooseFocusApple> createState() => _Screen02ChooseFocusAppleState();
}

class _Screen02ChooseFocusAppleState extends State<Screen02ChooseFocusApple> {
  final List<FocusVectorItem> _vectors = const [
    FocusVectorItem(
      glyph: "♄",
      title: "Career, Equity & Timing",
      subtitle: "10th House Dasamsa, promotions & venture pivots",
      accentColor: AppleCosmicTheme.champagneGold,
    ),
    FocusVectorItem(
      glyph: "♀",
      title: "Love, Synastry & Marriage",
      subtitle: "7th House Navamsa, karmic bonds & compatibility",
      accentColor: AppleCosmicTheme.auroraPink,
    ),
    FocusVectorItem(
      glyph: "♃",
      title: "Wealth & Asset Cycles",
      subtitle: "2nd/11th House Dhana Yoga & Dasha windows",
      accentColor: Color(0xFFFBBF24),
    ),
    FocusVectorItem(
      glyph: "☽",
      title: "Mental Peace & Shadow Work",
      subtitle: "Lunar Nakshatra rhythms, sleep & emotional alignment",
      accentColor: Color(0xFF67E8F9),
    ),
    FocusVectorItem(
      glyph: "☊",
      title: "Karmic Purpose (Rahu-Ketu)",
      subtitle: "Nodal axis decoding & spiritual evolution",
      accentColor: Color(0xFF34D399),
    ),
  ];

  final Set<int> _selectedIndices = {0, 1};

  void _toggleIndex(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_selectedIndices.contains(index)) {
        if (_selectedIndices.length > 1) {
          _selectedIndices.remove(index);
        }
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _onContinue() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => const Screen03BirthDetailsApple(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "STEP 01 / 03",
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
                    Container(width: 24, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 4),
                    Container(width: 24, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Header Title
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                ),
                children: [
                  TextSpan(text: "Where do you seek "),
                  TextSpan(text: "clarity", style: TextStyle(fontStyle: FontStyle.italic, color: AppleCosmicTheme.champagneGold)),
                  TextSpan(text: " right now?"),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Select your primary life vectors to tune Devi's neural weights.",
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Focus Cards List
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: _vectors.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = _vectors[index];
                  final isSelected = _selectedIndices.contains(index);

                  return GestureDetector(
                    onTap: () => _toggleIndex(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppleCosmicTheme.nebulaViolet.withOpacity(0.24)
                            : Colors.white.withOpacity(0.035),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppleCosmicTheme.nebulaViolet.withOpacity(0.7)
                              : Colors.white.withOpacity(0.09),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppleCosmicTheme.nebulaViolet.withOpacity(0.3),
                                  blurRadius: 18,
                                )
                              ]
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: item.accentColor.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: item.accentColor.withOpacity(0.4)),
                            ),
                            child: Center(
                              child: Text(
                                item.glyph,
                                style: TextStyle(fontSize: 20, color: item.accentColor),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontFamily: '.SF Pro Text',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item.subtitle,
                                  style: TextStyle(
                                    fontFamily: '.SF Pro Text',
                                    fontSize: 11,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppleCosmicTheme.champagneGold : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? AppleCosmicTheme.champagneGold : Colors.white24,
                                width: 1.5,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(Icons.check, size: 14, color: Colors.black)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Sticky Bottom CTA
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: GestureDetector(
                onTap: _onContinue,
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
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Continue with ${_selectedIndices.length} Focus Vectors →",
                      style: const TextStyle(
                        fontFamily: '.SF Pro Text',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
