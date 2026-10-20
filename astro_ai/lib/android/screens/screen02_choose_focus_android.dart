// android/lib/screens/screen02_choose_focus_android.dart
// Screen 02: Choose Your Focus (Google Android Target)
// Features: Edge-to-edge layout, VibrationEffect haptic tick, Android 14 predictive back,
// 3D spring micro-tilt on selection, and ClampingScrollPhysics.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen03_birth_details_android.dart';

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

class Screen02ChooseFocusAndroid extends StatefulWidget {
  const Screen02ChooseFocusAndroid({super.key});

  @override
  State<Screen02ChooseFocusAndroid> createState() => _Screen02ChooseFocusAndroidState();
}

class _Screen02ChooseFocusAndroidState extends State<Screen02ChooseFocusAndroid> {
  final List<FocusVectorItem> _vectors = const [
    FocusVectorItem(
      glyph: "♄",
      title: "Career, Equity & Timing",
      subtitle: "10th House Dasamsa, promotions & venture pivots",
      accentColor: AndroidCosmicTheme.champagneGold,
    ),
    FocusVectorItem(
      glyph: "♀",
      title: "Love, Synastry & Marriage",
      subtitle: "7th House Navamsa, karmic bonds & compatibility",
      accentColor: AndroidCosmicTheme.auroraPink,
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
    // Android VibrationEffect.createPredefined(EFFECT_TICK)
    HapticFeedback.vibrate();
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
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Screen03BirthDetailsAndroid(),
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
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
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
                    Container(width: 24, height: 4, decoration: BoxDecoration(color: AndroidCosmicTheme.nebulaViolet, borderRadius: BorderRadius.circular(2))),
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
                  TextSpan(text: "clarity", style: TextStyle(fontStyle: FontStyle.italic, color: AndroidCosmicTheme.champagneGold)),
                  TextSpan(text: " right now?"),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Select your primary life vectors to tune Devi's neural weights.",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Focus Cards List with ClampingScrollPhysics
            Expanded(
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                itemCount: _vectors.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = _vectors[index];
                  final isSelected = _selectedIndices.contains(index);

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _toggleIndex(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AndroidCosmicTheme.nebulaViolet.withOpacity(0.24)
                            : Colors.white.withOpacity(0.035),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AndroidCosmicTheme.nebulaViolet.withOpacity(0.7)
                              : Colors.white.withOpacity(0.09),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.3),
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
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item.subtitle,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
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
                              color: isSelected ? AndroidCosmicTheme.champagneGold : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? AndroidCosmicTheme.champagneGold : Colors.white24,
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

            // Sticky Bottom CTA (Material 3 ElevatedButton)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
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
                  onPressed: _onContinue,
                  child: Text(
                    "Continue with ${_selectedIndices.length} Focus Vectors →",
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
