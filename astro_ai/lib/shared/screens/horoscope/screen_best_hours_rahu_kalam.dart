// lib/shared/screens/horoscope/screen_best_hours_rahu_kalam.dart
// Screen 5: Best Hours Today, with Rahu Kalam
// Direct 1:1 Implementation matching Reference Screenshot (media_1792523863384_3c37229f.jpg)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/batch5_celestial_painters.dart';

class ScreenBestHoursRahuKalam extends StatefulWidget {
  const ScreenBestHoursRahuKalam({super.key});

  @override
  State<ScreenBestHoursRahuKalam> createState() => _ScreenBestHoursRahuKalamState();
}

class _ScreenBestHoursRahuKalamState extends State<ScreenBestHoursRahuKalam> {
  bool _isToday = true;

  final List<BestHourWindowItem> _todayWindows = const [
    BestHourWindowItem(
      category: "CAREER",
      timeRange: "5:06 PM - 6:06 PM",
      horaDescription: "Jupiter Hour • Jupiter rules your 10th house",
      badgeText: "Strong",
      iconColor: Color(0xFF3498DB),
      icon: Icons.work_outline,
    ),
    BestHourWindowItem(
      category: "MONEY",
      timeRange: "8:13 AM - 9:12 AM",
      horaDescription: "Moon Hour • Moon rules your 2nd house",
      badgeText: "Own Sign",
      iconColor: Color(0xFF2ECC71),
      icon: Icons.payments_outlined,
    ),
    BestHourWindowItem(
      category: "LOVE",
      timeRange: "6:14 AM - 7:13 AM",
      horaDescription: "Venus Hour • Venus rules your 5th house",
      badgeText: "Own Sign",
      iconColor: Color(0xFFE07A5F),
      icon: Icons.favorite,
    ),
    BestHourWindowItem(
      category: "WELLNESS",
      timeRange: "7:13 AM - 8:13 AM",
      horaDescription: "Mercury Hour • Mercury rules your 1st house",
      iconColor: Color(0xFF9B59B6),
      icon: Icons.spa_outlined,
    ),
    BestHourWindowItem(
      category: "RAHU KALAM",
      timeRange: "10:41 AM - 12:10 PM",
      horaDescription: "Avoid new beginnings",
      iconColor: Color(0xFFE07A5F),
      icon: Icons.error_outline,
      isRahuKalam: true,
    ),
  ];

  final List<BestHourWindowItem> _tomorrowWindows = const [
    BestHourWindowItem(
      category: "CAREER",
      timeRange: "6:15 PM - 7:15 PM",
      horaDescription: "Sun Hour • High executive visibility",
      badgeText: "Digbala",
      iconColor: Color(0xFF3498DB),
      icon: Icons.work_outline,
    ),
    BestHourWindowItem(
      category: "MONEY",
      timeRange: "9:20 AM - 10:15 AM",
      horaDescription: "Jupiter Hour • Favorable for investments",
      badgeText: "Benefic",
      iconColor: Color(0xFF2ECC71),
      icon: Icons.payments_outlined,
    ),
    BestHourWindowItem(
      category: "LOVE",
      timeRange: "7:30 AM - 8:25 AM",
      horaDescription: "Moon Hour • Gentle emotional intimacy",
      badgeText: "Friendly",
      iconColor: Color(0xFFE07A5F),
      icon: Icons.favorite,
    ),
    BestHourWindowItem(
      category: "RAHU KALAM",
      timeRange: "12:12 PM - 1:40 PM",
      horaDescription: "Avoid signatures & important negotiations",
      iconColor: Color(0xFFE07A5F),
      icon: Icons.error_outline,
      isRahuKalam: true,
    ),
  ];

  void _showLearnModal() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF16151E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About Hora & Rahu Kalam",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "• Planetary Hora: Each planetary hour is ruled by a specific graha. Aligning your career, wealth, and health activities with the ruling planet amplifies success.\n\n"
              "• Rahu Kalam: A fixed 90-minute daily period ruled by the north node Rahu. Classical Vedic astrology recommends pausing new beginnings, investments, or travel during this window.",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE07A5F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Got it", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeWindows = _isToday ? _todayWindows : _tomorrowWindows;

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
                "BEST HOURS",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFFE07A5F),
                ),
              ),

              const SizedBox(height: 8),

              // Headline: "Your best hours today, with Rahu Kalam"
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
                    TextSpan(text: "Your "),
                    TextSpan(
                      text: "best hours ",
                      style: TextStyle(color: Color(0xFFE07A5F)),
                    ),
                    TextSpan(text: "today,\nwith Rahu Kalam"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Main Best Hours Card Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1D24),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Top Bar: < Gemini Lagna | Learn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.chevron_left, color: Colors.white70, size: 20),
                            SizedBox(width: 4),
                            Text(
                              "Gemini Lagna",
                              style: TextStyle(
                                fontFamily: 'Cormorant Garamond',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: _showLearnModal,
                          child: const Text(
                            "Learn",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Pill Selector: [ Today • ] vs [ Tomorrow ]
                    Center(
                      child: Container(
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
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
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
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
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
                    ),

                    const SizedBox(height: 24),

                    // Hourly List with Category Badges and Rahu Kalam
                    BestHoursHoraListWidget(items: activeWindows),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
