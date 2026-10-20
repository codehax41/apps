// lib/shared/screens/horoscope/screen_daily_scored_horoscope.dart
// Screen 3: Daily Scored Horoscope - "Love, money, career, scored daily"
// Direct 1:1 Implementation matching Reference Screenshot (media_1792523863349_c80f43cf.jpg)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/batch5_celestial_painters.dart';

class ScreenDailyScoredHoroscope extends StatefulWidget {
  const ScreenDailyScoredHoroscope({super.key});

  @override
  State<ScreenDailyScoredHoroscope> createState() => _ScreenDailyScoredHoroscopeState();
}

class _ScreenDailyScoredHoroscopeState extends State<ScreenDailyScoredHoroscope> {
  bool _isToday = true;
  int _selectedCategoryIndex = 0; // 0: Money, 1: Love, 2: Career, 3: Wellness
  bool _showFactorDetail = true; // Shows factor card as in screenshot

  final List<Map<String, dynamic>> _categories = [
    {
      "score": 100,
      "label": "Money",
      "icon": Icons.payments_outlined,
      "color": const Color(0xFF2ECC71),
      "summary":
          "Money is a clear green light. Venus boosts income and gains, so negotiate confidently, collect dues, or make a well-researched purchase.",
      "factors": const [
        ScoreFactorItem(
          placementTitle: "Mercury in 11th house (Friendly)",
          points: 11,
          explanation: "Mercury sharpens thinking and communication in your income and gains",
        ),
        ScoreFactorItem(
          placementTitle: "Venus in 11th house (Mool Trikona)",
          points: 20,
          explanation: "Venus brings charm and harmony to your income and gains, and it is strong and well placed today.",
        ),
      ],
    },
    {
      "score": 69,
      "label": "Love",
      "icon": Icons.favorite,
      "color": const Color(0xFFE07A5F),
      "summary":
          "Relationships thrive with patience. Stay receptive and avoid turning brief emotional disagreements into deep intellectual arguments.",
      "factors": const [
        ScoreFactorItem(
          placementTitle: "Jupiter aspect on 7th house (Benefic)",
          points: 14,
          explanation: "Expansive wisdom protects long-term bonds despite transient mood dips.",
        ),
      ],
    },
    {
      "score": 96,
      "label": "Career",
      "icon": Icons.work_outline,
      "color": const Color(0xFF3498DB),
      "summary":
          "Executive authority is heavily fortified. Take decisive actions on key deliverables and pitch high-stakes initiatives today.",
      "factors": const [
        ScoreFactorItem(
          placementTitle: "Sun in 10th house (Digbala)",
          points: 25,
          explanation: "Sun attains maximum directional strength, commanding professional respect.",
        ),
      ],
    },
    {
      "score": 99,
      "label": "Wellness",
      "icon": Icons.spa_outlined,
      "color": const Color(0xFF9B59B6),
      "summary":
          "Pranic energy and mental vitality are at an apex. Excellent for revitalizing routines and disciplined pranayama.",
      "factors": const [
        ScoreFactorItem(
          placementTitle: "Moon in Rohini Nakshatra",
          points: 18,
          explanation: "Nourishing lunar placement calms the nervous system and fosters emotional equilibrium.",
        ),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeCat = _categories[_selectedCategoryIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF131217),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Back Arrow
              GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1D26),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: const Icon(Icons.arrow_back, size: 20, color: Colors.white70),
                ),
              ),

              const SizedBox(height: 24),

              // Subtitle in terracotta uppercase
              const Text(
                "DAILY HOROSCOPE",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFFE07A5F),
                ),
              ),

              const SizedBox(height: 8),

              // Headline: "Love, money, career, scored daily"
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.15,
                  ),
                  children: [
                    TextSpan(text: "Love, money,\ncareer, "),
                    TextSpan(
                      text: "scored daily",
                      style: TextStyle(color: Color(0xFFE07A5F)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Main Daily Horoscope Scored Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1D24),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  children: [
                    // Pill Toggle: [ Today • ] vs [ Tomorrow ]
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131217),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() => _isToday = true);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: _isToday ? const Color(0xFFE07A5F) : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                "Today •",
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                  color: _isToday ? Colors.white : Colors.white60,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() => _isToday = false);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: !_isToday ? const Color(0xFFE07A5F) : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                "Tomorrow",
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                  color: !_isToday ? Colors.white : Colors.white60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // 4 Circular Score Meters Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(_categories.length, (i) {
                        final c = _categories[i];
                        final isSel = _selectedCategoryIndex == i;
                        return CircularScoreMeterWidget(
                          score: c["score"] as int,
                          label: c["label"] as String,
                          icon: c["icon"] as IconData,
                          iconBadgeColor: c["color"] as Color,
                          isSelected: isSel,
                          onTap: () {
                            setState(() {
                              _selectedCategoryIndex = i;
                              _showFactorDetail = true;
                            });
                          },
                        );
                      }),
                    ),

                    const SizedBox(height: 14),

                    // Tap hint
                    Text(
                      "Tap a score for details",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 11.5,
                        color: Colors.white.withOpacity(0.40),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Overview summary
                    Text(
                      "You've got unusually strong planetary backing for ambitious progress. Money and work are primed for disciplined, high-conviction action, while relationships flourish when you stay open-hearted and don't turn small friction into heavy debates.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 12.5,
                        height: 1.45,
                        color: Colors.white.withOpacity(0.70),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Floating Detail Card ("Why this score")
              if (_showFactorDetail)
                WhyThisScoreCardWidget(
                  score: activeCat["score"] as int,
                  categoryTitle: activeCat["label"] as String,
                  summary: activeCat["summary"] as String,
                  factors: activeCat["factors"] as List<ScoreFactorItem>,
                  onBack: () => setState(() => _showFactorDetail = false),
                  onShare: () {
                    HapticFeedback.lightImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Shared ${activeCat['label']} score of ${activeCat['score']}/100 to clipboard."),
                        backgroundColor: const Color(0xFFE07A5F),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
