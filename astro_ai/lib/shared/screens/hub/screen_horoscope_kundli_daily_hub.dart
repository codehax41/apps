// lib/shared/screens/hub/screen_horoscope_kundli_daily_hub.dart
// Screen 1: "Your Horoscope & Kundli - Daily" Bento Discovery Hub
// Direct 1:1 Implementation matching Reference Screenshot (media_1792523863345_fea20cd1.jpg)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/daily_guidance_3d_painters.dart';
import '../../widgets/batch5_celestial_painters.dart';
import '../horoscope/screen_daily_scored_horoscope.dart';
import '../horoscope/screen_best_hours_rahu_kalam.dart';
import '../compatibility/screen_gun_milan_report.dart';
import '../kundali/screen_dual_chart_kundli.dart';
import '../screen_voice_session.dart';
import '../reports/screen_free_reports_hub.dart';

class ScreenHoroscopeKundliDailyHub extends StatefulWidget {
  const ScreenHoroscopeKundliDailyHub({super.key});

  @override
  State<ScreenHoroscopeKundliDailyHub> createState() => _ScreenHoroscopeKundliDailyHubState();
}

class _ScreenHoroscopeKundliDailyHubState extends State<ScreenHoroscopeKundliDailyHub> {
  final TextEditingController _promptController = TextEditingController();

  final List<Map<String, dynamic>> _quickCategories = const [
    {"label": "Love", "icon": Icons.favorite_border},
    {"label": "Marriage", "icon": Icons.circle_outlined},
    {"label": "Today", "icon": Icons.wb_sunny_outlined},
    {"label": "Career", "icon": Icons.school_outlined},
    {"label": "Education", "icon": Icons.menu_book_outlined},
  ];

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  void _submitPrompt(String query) {
    if (query.trim().isEmpty) return;
    HapticFeedback.heavyImpact();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScreenVoiceSession()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF4E8), // Light Champagne Gold ambient background from screenshot
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Back Arrow & Sparkles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                    ),
                  ),
                  const Text("✦", style: TextStyle(fontSize: 22, color: Color(0xFFD4AF37))),
                ],
              ),

              const SizedBox(height: 8),

              // Title: "Your Horoscope & Kundli - Daily"
              const Text(
                "Your Horoscope &\nKundli - Daily",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                  color: Color(0xFF1B1917),
                ),
              ),

              const SizedBox(height: 18),

              // Realistic Phone Frame Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: const Color(0xFF222222), width: 6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Container(
                    color: const Color(0xFFFCFAF6),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Phone Top Bar: Menu | Gold Coins | Wallet
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.menu, size: 22, color: Colors.black87),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7E6B5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      Text("🪙", style: TextStyle(fontSize: 12)),
                                      SizedBox(width: 4),
                                      Text("1120", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      Text("₹1050", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
                                      SizedBox(width: 4),
                                      Icon(Icons.add_circle, size: 14, color: Color(0xFF2ECC71)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Greeting: Hi, Anubhav
                        const Text(
                          "Hi, Anubhav",
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1917),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // AI Query Prompt Bar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black.withOpacity(0.08)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.auto_awesome, size: 18, color: Color(0xFFD4AF37)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: _promptController,
                                  onSubmitted: _submitPrompt,
                                  decoration: const InputDecoration(
                                    hintText: "How will my portfolio perform today?",
                                    hintStyle: TextStyle(fontSize: 13, color: Colors.black54),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _submitPrompt(_promptController.text),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF5E5C0),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Section Title: Kundali AI
                        const Text(
                          "Kundali AI",
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1917),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Category Chips Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _quickCategories.map((cat) {
                            return Column(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBF4E8),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE5D5B8)),
                                  ),
                                  child: Icon(cat["icon"] as IconData, size: 20, color: const Color(0xFF8B6914)),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  cat["label"] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 10.5,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 18),

                        // 3D Bento Grid (Matching Reference Screenshot)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column: Detailed Horoscope (Tall Card)
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ScreenDailyScoredHoroscope()),
                                  );
                                },
                                child: Container(
                                  height: 210,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Color(0xFFFFF7E6), Color(0xFFFFE6B8)],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10),
                                    ],
                                  ),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Detailed\nHoroscope",
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1B1917),
                                        ),
                                      ),
                                      Spacer(),
                                      // 3D Procedural Armillary / Orbital Sphere
                                      Center(
                                        child: OrbitalPlanetSphereWidget(size: 80),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Right Column: Stack of Cards
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  // Love Compatibility Card
                                  GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ScreenGunMilanReport()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Love\nCompatibility",
                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1B1917)),
                                            ),
                                          ),
                                          Text("💕", style: TextStyle(fontSize: 24)),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Kundli Card (with purple scroll)
                                  GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ScreenDualChartKundli()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFF3E8FF), Color(0xFFE9D5FF)],
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Kundli",
                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1B1917)),
                                            ),
                                          ),
                                          GoldenScroll3DWidget(size: 38),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Kundli Matching (with Ganesha)
                                  GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ScreenGunMilanReport()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Kundli\nMatching",
                                              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Color(0xFF1B1917)),
                                            ),
                                          ),
                                          GaneshaIdol3DWidget(width: 38, height: 38),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Best Hours Quick Banner
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ScreenBestHoursRahuKalam()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5E5C0),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.schedule, size: 18, color: Color(0xFF8B6914)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Best Hours Today & Rahu Kalam",
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1B1917)),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black54),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // 100+ Free Reports Hub Banner
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ScreenFreeReportsHub()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFDF0D5), Color(0xFFFEE2B3)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE5B869)),
                            ),
                            child: const Row(
                              children: [
                                Text("📜", style: TextStyle(fontSize: 20)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "100+ Free Reports Vault",
                                        style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1B1917)),
                                      ),
                                      Text(
                                        "KP System, Dasha, Lal Kitab, Sade Sati & Gemstones",
                                        style: TextStyle(fontSize: 10.5, color: Color(0xFF78590F)),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF78590F)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
