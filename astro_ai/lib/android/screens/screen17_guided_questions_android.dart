// android/lib/screens/screen17_guided_questions_android.dart
// Screen 17: Guided Question Library (Google Android Target)
// Features: Android RefreshIndicator pull-to-refresh, Hero shared-element transition to Devi Screen 16,
// Material 3 filter chips, and transit-tailored question cards.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'package:astro_ai/shared/widgets/celestial_3d_painters.dart';
import 'screen16_devi_live_oracle_android.dart';
import 'screen18_premium_reports_android.dart';

class GuidedQuestionItem {
  final String categoryTag;
  final String questionText;
  final Color accentColor;

  const GuidedQuestionItem({
    required this.categoryTag,
    required this.questionText,
    required this.accentColor,
  });
}

class Screen17GuidedQuestionsAndroid extends StatefulWidget {
  const Screen17GuidedQuestionsAndroid({super.key});

  @override
  State<Screen17GuidedQuestionsAndroid> createState() => _Screen17GuidedQuestionsAndroidState();
}

class _Screen17GuidedQuestionsAndroidState extends State<Screen17GuidedQuestionsAndroid> {
  String _selectedCategory = "ALL";

  final List<String> _categories = ["ALL", "CAREER", "LOVE", "WEALTH", "SHADOW WORK"];

  final List<GuidedQuestionItem> _questions = const [
    GuidedQuestionItem(
      categoryTag: "♄ 10TH HOUSE • CAREER",
      questionText: "Should I transition into an AI Pod Lead / Founder role before Jupiter shifts?",
      accentColor: AndroidCosmicTheme.champagneGold,
    ),
    GuidedQuestionItem(
      categoryTag: "♀ 7TH HOUSE • RELATIONSHIPS",
      questionText: "What karmic lesson is my current partner mirroring in my Navamsa (D9)?",
      accentColor: AndroidCosmicTheme.auroraPink,
    ),
    GuidedQuestionItem(
      categoryTag: "♃ 2ND/11TH • EQUITY & WEALTH",
      questionText: "Which quarter of 2027 activates my strongest Dhana Yoga for wealth accumulation?",
      accentColor: AndroidCosmicTheme.emeraldSync,
    ),
    GuidedQuestionItem(
      categoryTag: "☽ ROHINI • WELLNESS",
      questionText: "Why does my sleep rhythm dip during Waning Moon transits?",
      accentColor: AndroidCosmicTheme.nebulaViolet,
    ),
  ];

  void _onQuestionTapped(String prompt) {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Screen16DeviLiveOracleAndroid(initialPrompt: prompt),
      ),
    );
  }

  void _onNavigateToReports() {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen18PremiumReportsAndroid()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      body: RefreshIndicator(
        color: AndroidCosmicTheme.champagneGold,
        backgroundColor: AndroidCosmicTheme.oledVoid,
        onRefresh: () async {
          HapticFeedback.vibrate();
          await Future.delayed(const Duration(milliseconds: 900));
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                "CURATED ORACLE PROMPTS",
                style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
              ),
              const SizedBox(height: 2),
              const Text(
                "Guided Question Library",
                style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                "Tap any prompt to immediately trigger Devi speaking the astrological answer.",
                style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12.5, color: Colors.white.withOpacity(0.65)),
              ),

              const SizedBox(height: 12),

              // 3D Levitating Iridescent Intelligence Orb
              const Center(
                child: IridescentIntelligenceOrbWidget(size: 80),
              ),

              const SizedBox(height: 14),

              // Category Filter Bar
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: Row(
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () {
                          HapticFeedback.vibrate();
                          setState(() => _selectedCategory = cat);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: isSelected ? AndroidCosmicTheme.nebulaViolet : Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: isSelected ? AndroidCosmicTheme.nebulaViolet : Colors.white.withOpacity(0.09)),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 9.5,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.white60,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 18),

              // Questions Stack
              ..._questions.map((q) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => _onQuestionTapped(q.questionText),
                    child: Container(
                      padding: const EdgeInsets.all(16),
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
                              Text(
                                q.categoryTag,
                                style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: q.accentColor),
                              ),
                              const Text("🔊 Ask Devi", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AndroidCosmicTheme.champagneGold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "“${q.questionText}”",
                            style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white, height: 1.35),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 16),

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
                  onPressed: _onNavigateToReports,
                  child: const Text(
                    "Browse Premium Report Library (Screen 18) →",
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13.5, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
