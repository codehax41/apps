// android/lib/screens/screen09_daily_guidance_android.dart
// Screen 09: Daily Guidance (Google Android Target)
// High-Fidelity implementation matching exact reference screenshots:
// - 3D Illuminated Golden Diya (Oil Lamp) with burning divine flame
// - Chandra Rashi: Sagittarius & personalized headline ("Kanu, aaj apni sehat aur rishton par dhyan dein")
// - Expandable "Today's Prediction" with show more/less and "Ask Reva for Insights" CTA
// - Lucky Number (2, 9 / Two, Nine) & Lucky Color (Yellow / Light Yellow) badges
// - Category Selector Pills: CAREER, LOVE, EMOTION, HEALTH with dynamic guidance
// - Chanting Card: "Om Gam Ganapataye Namah" with 3D Ganesha idol, audio player & japa counter
// - Personal Timings Ongoing Window (AVOID 10:58pm - 1:18am) with 3D Orbital Sphere
// - "Aapka Din" chronological timeline (Shubh & Ashubh windows)
// - Interactive Energy Levels (Physical, Emotional, Mind) with 3D Muscle, Drama Masks & Brain
// - Festivals Section: Vinayaka Chaturthi ongoing card with 3D Puja Thali & Upcoming Events list

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'package:astro_ai/shared/widgets/daily_guidance_3d_painters.dart';
import 'screen10_weekly_forecast_android.dart';
import 'screen16_devi_live_oracle_android.dart';
import 'package:astro_ai/shared/screens/horoscope/screen_daily_scored_horoscope.dart';
import 'package:astro_ai/shared/screens/horoscope/screen_best_hours_rahu_kalam.dart';

enum GuidanceCategory { career, love, emotion, health }
enum EnergyType { physical, emotional, mind }

class Screen09DailyGuidanceAndroid extends StatefulWidget {
  const Screen09DailyGuidanceAndroid({super.key});

  @override
  State<Screen09DailyGuidanceAndroid> createState() => _Screen09DailyGuidanceAndroidState();
}

class _Screen09DailyGuidanceAndroidState extends State<Screen09DailyGuidanceAndroid> {
  bool _isExpanded = false;
  GuidanceCategory _selectedCategory = GuidanceCategory.career;
  EnergyType _selectedEnergy = EnergyType.physical;
  bool _isMantraPlaying = false;
  int _japaCount = 3;

  final Map<GuidanceCategory, Map<String, String>> _categoryContent = {
    GuidanceCategory.career: {
      "title": "CAREER",
      "icon": "💼",
      "guidance": "Aaj impulsive hone se bachein, kyunki team aapke faislon se khush nahi hogi. Zaroori meetings ko kisi aur din ke liye taal dena hi behtar hai.",
    },
    GuidanceCategory.love: {
      "title": "LOVE",
      "icon": "💛",
      "guidance": "Vaivahik rishton mein thoda thehraav aur vinamrata rakhein. Purani baaton ko lekar bahas na karein; prem aur aapsi samajh se samvad karein.",
    },
    GuidanceCategory.emotion: {
      "title": "EMOTION",
      "icon": "🎭",
      "guidance": "Aap apne kareebi logon dwara ki gayi baaton ko lekar kaafi sensitive rahenge. Gambhir bahas se bachein aur aatm-chintan mein samay bitayein.",
    },
    GuidanceCategory.health: {
      "title": "HEALTH",
      "icon": "➕",
      "guidance": "Health ke liye bahut zyada care ki zaroorat hai. Subah jaldi hari-bhari jagah ya garden mein walk karein. Depression se bachne ke liye meditation karein.",
    },
  };

  void _toggleCategory(GuidanceCategory category) {
    HapticFeedback.selectionClick();
    setState(() => _selectedCategory = category);
  }

  void _selectEnergy(EnergyType type) {
    HapticFeedback.selectionClick();
    setState(() => _selectedEnergy = type);
  }

  void _toggleMantra() {
    HapticFeedback.lightImpact();
    setState(() {
      _isMantraPlaying = !_isMantraPlaying;
      if (_isMantraPlaying && _japaCount < 108) {
        _japaCount++;
      }
    });
  }

  void _onAskReva() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen16DeviLiveOracleAndroid()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Bar: Back | User Birth Telemetry | Settings Gear
            _buildTopBar(),

            const SizedBox(height: 12),

            // 1. 3D Illuminated Golden Diya (Oil Lamp) Hero
            const GoldenDiya3DWidget(width: 170, height: 110),

            const SizedBox(height: 10),

            // Chandra Rashi Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "CHANDRA RASHI",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Color(0xFFFFD700),
                  ),
                ),
                const SizedBox(width: 6),
                const Text("🌙", style: TextStyle(fontSize: 11)),
                const SizedBox(width: 6),
                Text(
                  "SAGITTARIUS",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Headline
            const Text(
              "Kanu, aaj apni sehat aur\nrishton par dhyan dein",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.25,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            // Date Separator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("✦✦", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.6))),
                const SizedBox(width: 8),
                Text(
                  "WEDNESDAY, 14 OCTOBER 2026",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Colors.white.withOpacity(0.55),
                  ),
                ),
                const SizedBox(width: 8),
                Text("✦✦", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.6))),
              ],
            ),

            const SizedBox(height: 16),

            // 2. Main Daily Prediction Text Card (Expandable)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: const Color(0xFF13111C),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Health ke liye bahut zyada care ki zaroorat hai. Pet ki takleefein aur kamar dard aapko pareshan kar sakte hain. Aapko salah di jaati hai ki aap subah jaldi hari-bhari jagah ya garden mein walk karein. Depression se bachne ke liye meditation karein. Garbhvati mahilaon ko apni sehat ka extra dhyan rakhne ki zaroorat hai.",
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 13,
                      height: 1.5,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),

                  if (_isExpanded) ...[
                    const SizedBox(height: 14),
                    Text(
                      "Parivaar ke sadasyon ke saath vicharon mein matbhed hone ki sambhavna hai. Ego clashes ki wajah se vaivahik rishte mein khichav aa sakta hai. Ho sakta hai ki aapka kisi purane dost se rishta toot jaye. Gambhir bahas mein padne se bachein. Aap apne kareebi logon dwara ki gayi baaton ko lekar kaafi sensitive rahenge.",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Aaj koi bhi bada faisla na lein kyunki cheezein aapki ummeed ke mutabik nahi ho sakti hain.",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: const Color(0xFFFFD700).withOpacity(0.95),
                      ),
                    ),
                  ],

                  const SizedBox(height: 8),

                  // Show More / Show Less Toggle
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _isExpanded = !_isExpanded);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isExpanded ? "show less" : "show more",
                            style: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFD700),
                            ),
                          ),
                          Icon(
                            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            size: 16,
                            color: const Color(0xFFFFD700),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // "Ask Reva for Insights" Gold Gradient Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE5C07B), Color(0xFFC59E36), Color(0xFF8C6D23)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFD700).withOpacity(0.20),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: _onAskReva,
                          child: const Center(
                            child: Text(
                              "Ask Reva for Insights",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF14111D),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 3. Lucky Number & Lucky Color Dual Badges (Image 2 & 3)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF13111C),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Row(
                      children: [
                        // Roman Numeral / Lucky Coin Medallion
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [Color(0xFFFFF2A3), Color(0xFF8C6D23)],
                            ),
                            boxShadow: [
                              BoxShadow(color: const Color(0xFFFFD700).withOpacity(0.25), blurRadius: 6),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "②",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF14111D)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lucky Number",
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 9.5,
                                color: Colors.white.withOpacity(0.45),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Two, Nine",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF13111C),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Row(
                      children: [
                        // Golden Orb Medallion
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              center: Alignment(-0.3, -0.3),
                              colors: [Color(0xFFFFF7C2), Color(0xFFFBBF24), Color(0xFF92400E)],
                            ),
                            boxShadow: [
                              BoxShadow(color: const Color(0xFFFBBF24).withOpacity(0.3), blurRadius: 6),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lucky Color",
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 9.5,
                                color: Colors.white.withOpacity(0.45),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Light Yellow",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Daily Scored Horoscope Banner (Love, Money, Career scored daily)
            GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenDailyScoredHoroscope()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFE07A5F).withOpacity(0.22),
                      const Color(0xFF1E1D24),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.4)),
                ),
                child: const Row(
                  children: [
                    Text("💯", style: TextStyle(fontSize: 22)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DAILY SCORED HOROSCOPE",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Color(0xFFE07A5F), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Love, money, career, scored daily →",
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFE07A5F)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 4. Horizontal Category Selector Pills (CAREER, LOVE, EMOTION, HEALTH)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: GuidanceCategory.values.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  final info = _categoryContent[cat]!;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () => _toggleCategory(cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF262114) : const Color(0xFF13111C),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: isSelected ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.10),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(info["icon"]!, style: const TextStyle(fontSize: 12)),
                            const SizedBox(width: 6),
                            Text(
                              info["title"]!,
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // Category Specific Prediction Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.07)),
              ),
              child: Text(
                _categoryContent[_selectedCategory]!["guidance"]!,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 5. Chanting Card: Om Gam Ganapataye Namah with 3D Ganesha Idol (Image 4)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: const Color(0xFF13111C),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Stack(
                children: [
                  // 3D Golden Ganesha Idol on the Right
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: GaneshaIdol3DWidget(width: 85, height: 90),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WEDNESDAY • 108 TIMES",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: const Color(0xFFFFD700).withOpacity(0.75),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const SizedBox(
                        width: 220,
                        child: Text(
                          "Om Gam Ganapataye Namah",
                          style: TextStyle(
                            fontFamily: 'Cormorant Garamond',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 210,
                        child: Text(
                          "Ganesha ko naman. Saaf raaste, nayi shuruaat aur baadhaayein door karne ke liye...",
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11.5,
                            color: Colors.white.withOpacity(0.55),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Audio Waveform Controls Row
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0D17),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: _toggleMantra,
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _isMantraPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 18,
                                  color: const Color(0xFFFFD700),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            AudioWaveformVisualizer(isPlaying: _isMantraPlaying),
                            const SizedBox(width: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "$_japaCount",
                                style: const TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFD700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 6. Section Separator: Personal Timings
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("✦✦", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.6))),
                const SizedBox(width: 8),
                const Text(
                  "Personal Timings",
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text("✦✦", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.6))),
              ],
            ),

            const SizedBox(height: 14),

            // Ongoing Window Card (AVOID 10:58pm to 1:18am)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: const Color(0xFF13111C),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    bottom: -8,
                    right: -8,
                    child: OrbitalPlanetSphereWidget(size: 65),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ONGOING WINDOW",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: const Color(0xFFFFD700).withOpacity(0.75),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE63946).withOpacity(0.85),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "AVOID",
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "10:58pm to 1:18am",
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "Is samay aapki energy kam rehti hai. Bade faislon se door rahein; abhi kiya kaam baad mein sudhaarna pad sakta hai. Ise guzarne dein.",
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            height: 1.45,
                            color: Colors.white.withOpacity(0.65),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // View All Best Hours & Rahu Kalam Button
            GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenBestHoursRahuKalam()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: const Color(0xFFE07A5F).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE07A5F).withOpacity(0.35)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View All Best Hours Today & Rahu Kalam →",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12.5, fontWeight: FontWeight.bold, color: Color(0xFFE07A5F)),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFFE07A5F)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 7. "Aapka Din" Chronological Timeline
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Aapka Din",
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.95),
                ),
              ),
            ),

            const SizedBox(height: 12),

            _buildTimelineItem(
              timeRange: "6:32am to 8:53am",
              description: "Ek accha samay — zaroori kaam, meetings aur faislon ke liye sahi.",
              isGood: true,
            ),
            _buildTimelineItem(
              timeRange: "11:13am to 1:34pm",
              description: "Ek kamzor samay — kaam karne se behtar hai aaram karein.",
              isGood: false,
            ),
            _buildTimelineItem(
              timeRange: "8:37pm to 10:58pm",
              description: "Ek accha samay — zaroori kaam, meetings aur faislon ke liye sahi.",
              isGood: true,
            ),
            _buildTimelineItem(
              timeRange: "10:58pm to 1:18am",
              description: "Ek kamzor samay — kaam karne se behtar hai aaram karein.",
              isGood: false,
              isLast: true,
            ),

            const SizedBox(height: 24),

            // 8. Interactive Energy Levels Section (Images 1, 2, 3)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("✦✦", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.6))),
                const SizedBox(width: 8),
                const Text(
                  "Energy Levels",
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text("✦✦", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.6))),
              ],
            ),

            const SizedBox(height: 14),

            // 3 Selectable Energy Cards (Physical, Emotional, Mind)
            Row(
              children: [
                Expanded(
                  child: _buildSelectableEnergyCard(
                    type: EnergyType.physical,
                    percent: "44%",
                    label: "Physical",
                    isFalling: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSelectableEnergyCard(
                    type: EnergyType.emotional,
                    percent: "72%",
                    label: "Emotional",
                    isFalling: false,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSelectableEnergyCard(
                    type: EnergyType.mind,
                    percent: "46%",
                    label: "Mind",
                    isFalling: true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Selected Energy Dynamic Detail Card (Images 1, 2, 3)
            _buildEnergyDetailCard(),

            const SizedBox(height: 24),

            // 9. Festivals Section (Images 1, 2, 3, 4)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("✦✦", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.6))),
                const SizedBox(width: 8),
                const Text(
                  "Festivals",
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text("✦✦", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.6))),
              ],
            ),

            const SizedBox(height: 14),

            // Featured Ongoing Festival Card: Vinayaka Chaturthi with 3D Puja Thali
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: const Color(0xFF13111C),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: GoldenPujaThali3DWidget(width: 105, height: 70),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Vinayaka Chaturthi",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00FF66).withOpacity(0.20),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.40)),
                            ),
                            child: const Text(
                              "ONGOING",
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00FF66),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Starts Box
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "STARTS",
                                  style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.45)),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  "13 October, 11:29pm",
                                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Ends Box
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ENDS",
                                  style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white.withOpacity(0.45)),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  "Tomorrow, 1:14am",
                                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 220,
                        child: Text(
                          "Vinayaka Chaturthi ka din Ganesha ji ko samarpit hota hai, jo aapke sabhi kaamon mein aane wali baadhaayon ko door karte hain.",
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11.5,
                            height: 1.45,
                            color: Colors.white.withOpacity(0.65),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Upcoming Events List Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Upcoming Events",
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Event 1: Durga Ashtami
            _buildUpcomingEventItem(
              title: "Durga Ashtami",
              date: "18 October",
              timeRange: "8:29am - 10:53am",
              iconWidget: const GoldenPujaThali3DWidget(width: 32, height: 22),
            ),
            // Event 2: Vijayadashami
            _buildUpcomingEventItem(
              title: "Vijayadashami",
              date: "20 October",
              timeRange: "12:51pm - 2:13pm",
              iconWidget: const GoldenBowArrowWidget(size: 22),
            ),
            // Event 3: Ekadashi
            _buildUpcomingEventItem(
              title: "Ekadashi",
              date: "21 October",
              timeRange: "2:13pm - 2:49pm",
              iconWidget: const GoldenPujaThali3DWidget(width: 32, height: 22),
            ),
            // Event 4: Pradosh Vrat
            _buildUpcomingEventItem(
              title: "Pradosh Vrat",
              date: "23 October",
              timeRange: "2:37pm - 1:38pm",
              iconWidget: const GoldenPujaThali3DWidget(width: 32, height: 22),
            ),
            // Event 5: Sharad Purnima
            _buildUpcomingEventItem(
              title: "Sharad Purnima",
              date: "25 October",
              timeRange: "11:57am - 9:42am",
              iconWidget: const GoldenPujaThali3DWidget(width: 32, height: 22),
            ),

            const SizedBox(height: 24),

            // 10. View Weekly Forecast Link (Screen 10)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.12)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Screen10WeeklyForecastAndroid()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View 7-Day Weekly Forecast (Screen 10)",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 14, color: Color(0xFFFFD700)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1824),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 15, color: Colors.white70),
          ),
        ),

        // Centered User Birth Metadata
        Column(
          children: [
            const Text(
              "kanu",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "25/08/96",
                  style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, color: Colors.white.withOpacity(0.55)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text("•", style: TextStyle(fontSize: 10, color: const Color(0xFFFFD700).withOpacity(0.7))),
                ),
                Text(
                  "12:00pm",
                  style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, color: Colors.white.withOpacity(0.55)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text("•", style: TextStyle(fontSize: 10, color: const Color(0xFFFFD700).withOpacity(0.7))),
                ),
                Text(
                  "Mumbai",
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, color: Colors.white.withOpacity(0.55)),
                ),
              ],
            ),
          ],
        ),

        // Settings Gear Icon Button
        GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1824),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: const Icon(Icons.settings_outlined, size: 18, color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String timeRange,
    required String description,
    required bool isGood,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon & Connecting Line Column
          Column(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: isGood
                      ? const Color(0xFF00FF66).withOpacity(0.15)
                      : const Color(0xFFE63946).withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isGood
                        ? const Color(0xFF00FF66).withOpacity(0.40)
                        : const Color(0xFFE63946).withOpacity(0.40),
                  ),
                ),
                child: Center(
                  child: isGood
                      ? const Text("✨", style: TextStyle(fontSize: 11))
                      : const Text("⛔", style: TextStyle(fontSize: 10)),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.white.withOpacity(0.12),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeRange,
                    style: const TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      height: 1.4,
                      color: Colors.white.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableEnergyCard({
    required EnergyType type,
    required String percent,
    required String label,
    required bool isFalling,
  }) {
    final isSelected = _selectedEnergy == type;

    return GestureDetector(
      onTap: () => _selectEnergy(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: const Color(0xFF13111C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.08),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Text(
              percent,
              style: const TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 10.5,
                    color: isSelected ? Colors.white : Colors.white.withOpacity(0.55),
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  isFalling ? "🔻" : "🔺",
                  style: const TextStyle(fontSize: 8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyDetailCard() {
    String title;
    String statusText;
    String pillText;
    bool isRising;
    String description;
    Widget icon3D;

    switch (_selectedEnergy) {
      case EnergyType.physical:
        title = "Physical";
        statusText = "Balanced";
        pillText = "FALLING";
        isRising = false;
        description = "Energy theek hai. Aaram se chalein, din accha nikal jayega.";
        icon3D = const GoldenMuscleArmWidget(size: 38);
        break;
      case EnergyType.emotional:
        title = "Emotional";
        statusText = "Strong and steady";
        pillText = "RISING";
        isRising = true;
        description = "Dil khula aur josh se bhara hai. Apno se judne ka accha samay hai.";
        icon3D = const GoldenDramaMasksWidget(size: 38);
        break;
      case EnergyType.mind:
        title = "Mind";
        statusText = "Balanced";
        pillText = "FALLING";
        isRising = false;
        description = "Soch saaf hai. Rozmarra ke kaam aaram se honge.";
        icon3D = const GoldenBrainWidget(size: 38);
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF13111C),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon3D,
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 11.5,
                      color: Colors.white.withOpacity(0.50),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isRising
                      ? const Color(0xFF00FF66).withOpacity(0.20)
                      : const Color(0xFFE63946).withOpacity(0.20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  pillText,
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: isRising ? const Color(0xFF00FF66) : const Color(0xFFE63946),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12.5,
              height: 1.45,
              color: Colors.white.withOpacity(0.80),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEventItem({
    required String title,
    required String date,
    required String timeRange,
    required Widget iconWidget,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.025),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          SizedBox(width: 32, height: 26, child: Center(child: iconWidget)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text("📅", style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.4))),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 10.5, color: Colors.white.withOpacity(0.55)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text("•", style: TextStyle(fontSize: 9, color: const Color(0xFFFFD700).withOpacity(0.7))),
                    ),
                    Text("⏱", style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.4))),
                    const SizedBox(width: 4),
                    Text(
                      timeRange,
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 10.5, color: Colors.white.withOpacity(0.55)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
