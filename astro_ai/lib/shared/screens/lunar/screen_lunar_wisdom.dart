// lib/shared/screens/lunar/screen_lunar_wisdom.dart
// ASTROAI OS v5.0 - Real-time 3D Lunar Wisdom & Celestial Telemetry Experience
// Direct 1:1 Implementation matching Reference Screenshots (media_1792522755438_29909807.jpg & media_1792522755443_c70cf84b.jpg)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/batch4_celestial_painters.dart';
import '../screen_voice_session.dart';

class LunarDayInfo {
  final String dateLabel;
  final String dayName;
  final String phaseName;
  final int lunarDay;
  final int illuminationPercent;
  final int distanceKm;
  final String moonrise;
  final String moonset;
  final String sunrise;
  final String sunset;
  final String tithiName;
  final String insight;
  final String? transitionTime;
  final String? timerBadge;

  const LunarDayInfo({
    required this.dateLabel,
    required this.dayName,
    required this.phaseName,
    required this.lunarDay,
    required this.illuminationPercent,
    required this.distanceKm,
    required this.moonrise,
    required this.moonset,
    required this.sunrise,
    required this.sunset,
    required this.tithiName,
    required this.insight,
    this.transitionTime,
    this.timerBadge,
  });
}

class ScreenLunarWisdom extends StatefulWidget {
  const ScreenLunarWisdom({super.key});

  @override
  State<ScreenLunarWisdom> createState() => _ScreenLunarWisdomState();
}

class _ScreenLunarWisdomState extends State<ScreenLunarWisdom>
    with SingleTickerProviderStateMixin {
  late AnimationController _moonRotController;
  int _selectedDayIndex = 3; // Default to OCT 16 FRI as shown in screenshot

  final List<LunarDayInfo> _days = const [
    LunarDayInfo(
      dateLabel: "13",
      dayName: "TUE",
      phaseName: "Chaturthi",
      lunarDay: 4,
      illuminationPercent: 32,
      distanceKm: 393400,
      moonrise: "12:45",
      moonset: "22:10",
      sunrise: "06:31",
      sunset: "18:14",
      tithiName: "Chaturthi",
      transitionTime: "14 OCT, 3:12AM TAK • PHIR PANCHAMI SHURU",
      insight:
          "Chaturthi ke din Lord Ganesha ki upasana vishesh faldayi hoti hai. Kisi bhi rukavat ko door karne ke liye ye din shubh hai.",
    ),
    LunarDayInfo(
      dateLabel: "14",
      dayName: "WED",
      phaseName: "Panchami",
      lunarDay: 5,
      illuminationPercent: 41,
      distanceKm: 391800,
      moonrise: "13:30",
      moonset: "23:05",
      sunrise: "06:31",
      sunset: "18:13",
      tithiName: "Panchami",
      transitionTime: "15 OCT, 4:20AM TAK • PHIR SHASHTHI SHURU",
      insight:
          "Panchami vidya, kala aur gyan ke arjan ke liye atyant anukool hai. Shanti se manthan karne par safalta prapt hogi.",
    ),
    LunarDayInfo(
      dateLabel: "15",
      dayName: "THU",
      phaseName: "Shashthi",
      lunarDay: 6,
      illuminationPercent: 50,
      distanceKm: 390145,
      moonrise: "14:15",
      moonset: "23:55",
      sunrise: "06:32",
      sunset: "18:12",
      tithiName: "Shashthi",
      transitionTime: "16 OCT, 5:10AM TAK • PHIR SAPTAMI SHURU",
      insight:
          "Parivar ke sath samay bitane aur aatm-shanti ke liye ye samay adbhut hai. Naye nivesh se pehle thoda vichar karein.",
    ),
    // Oct 16 FRI (Reference Screenshot 1)
    LunarDayInfo(
      dateLabel: "16",
      dayName: "FRI",
      phaseName: "Shashthi",
      lunarDay: 6,
      illuminationPercent: 58,
      distanceKm: 388910,
      moonrise: "15:02",
      moonset: "00:48",
      sunrise: "06:32",
      sunset: "18:11",
      tithiName: "Shashthi",
      transitionTime: "17 OCT, 5:55AM TAK • PHIR SAPTAMI SHURU",
      insight:
          "Shukla Shashthi ka samay ghar banane ya zameen-jaydad se jude kaamon ke liye bahut achha mana jata hai. Is samay mein nirman karya shuru karna labhdayak ho sakta hai.",
    ),
    // Oct 17 SAT (Reference Screenshot 2)
    LunarDayInfo(
      dateLabel: "17",
      dayName: "SAT",
      phaseName: "Shukla-Saptami",
      lunarDay: 7,
      illuminationPercent: 67,
      distanceKm: 387420,
      moonrise: "15:50",
      moonset: "01:42",
      sunrise: "06:33",
      sunset: "18:10",
      tithiName: "Shukla-Saptami",
      transitionTime: "18 OCT, 8:29AM TAK • PHIR ASHTAMI SHURU",
      timerBadge: "01:16",
      insight:
          "Shukla-Saptami ek bahut achha din hai. Aap naye kaam ki shuruat kar sakte hain, ya phir kahin jaane ka plan bana sakte hain. Ye din bahas aur exercise ke liye bhi kaafi labhdayak hai.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _moonRotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _moonRotController.dispose();
    super.dispose();
  }

  void _askAboutDay(LunarDayInfo day) {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScreenVoiceSession(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final active = _days[_selectedDayIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF111015),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar: Back | Location | Quick Actions
              _buildTopBar(),

              const SizedBox(height: 14),

              // 2. 5-Day Horizontal Date Selector Strip (Oct 13 - Oct 17)
              _buildDateStrip(),

              const SizedBox(height: 24),

              // 3. Center Hero: 3D Split Dual Moon Sphere (Basalt Crater + 24K Gold Filigree)
              const Center(
                child: SplitDualMoon3DWidget(
                  size: 210,
                  animateWobble: true,
                ),
              ),

              const SizedBox(height: 18),

              // 4. Tithi Title (e.g. Shashthi or Shukla-Saptami)
              Center(
                child: Text(
                  active.tithiName,
                  style: const TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // 5. Tithi Transition Timing Subtitle (e.g. "17 OCT, 5:55AM TAK • PHIR SAPTAMI SHURU")
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      active.transitionTime ?? "TODAY • SHUBH MUHURAT",
                      style: const TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: Color(0xFFE5B232),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 6. Astrological Meaning Paragraph (Authentic Hindi Guidance)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  active.insight,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // 7. Interactive Reva Avatar Pill CTA ("Is din ke baare mein poochein")
              Center(
                child: GestureDetector(
                  onTap: () => _askAboutDay(active),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1D24),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withOpacity(0.45),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withOpacity(0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Circular Avatar with Gold Rim
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFFFDF73), width: 1.5),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/daivant_logo.webp'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Is din ke baare mein poochein",
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // 8. Ornate Diamond Divider: — ◈ — Sun and Moon — ◈ —
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 40, height: 1, color: const Color(0xFFD4AF37).withOpacity(0.4)),
                    const SizedBox(width: 6),
                    const Icon(Icons.diamond_outlined, size: 10, color: Color(0xFFD4AF37)),
                    const SizedBox(width: 10),
                    const Text(
                      "Sun and Moon",
                      style: TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.diamond_outlined, size: 10, color: Color(0xFFD4AF37)),
                    const SizedBox(width: 6),
                    Container(width: 40, height: 1, color: const Color(0xFFD4AF37).withOpacity(0.4)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 9. Dynamic Sun & Moon 24-Hour Daylight Arc Tracker Card
              SunMoonDaylightArcWidget(
                height: 150,
                currentProgress: (_selectedDayIndex + 1) / _days.length * 0.75,
              ),

              const SizedBox(height: 20),

              // 10. Ephemeris Telemetry Grid
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.035),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildEphemerisCell("Moonrise", active.moonrise, "☾↑"),
                    _buildEphemerisCell("Moonset", active.moonset, "☾↓"),
                    _buildEphemerisCell("Sunrise", active.sunrise, "☼↑"),
                    _buildEphemerisCell("Sunset", active.sunset, "☼↓"),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
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
              color: const Color(0xFF1E1D26),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white70),
          ),
        ),

        // Location Telemetry
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFFD4AF37)),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Location",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 9,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                const Text(
                  "Mumbai, Maharashtra",
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Right Action Group (Search, User, Menu)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1D26),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: const Icon(Icons.edit_location_outlined, size: 16, color: Colors.white70),
            ),
            const SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1D26),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: const Icon(Icons.person_outline, size: 16, color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateStrip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_days.length, (i) {
        final d = _days[i];
        final isSel = i == _selectedDayIndex;

        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _selectedDayIndex = i);
          },
          child: Container(
            width: 62,
            height: 72,
            decoration: BoxDecoration(
              color: isSel ? const Color(0xFF1F1E26) : const Color(0xFF16151B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSel ? const Color(0xFFD4AF37) : Colors.white.withOpacity(0.06),
                width: isSel ? 1.5 : 1.0,
              ),
              boxShadow: isSel
                  ? [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withOpacity(0.20),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (d.timerBadge != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Text(
                      d.timerBadge!,
                      style: const TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 8,
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OCT",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 8.5,
                          color: isSel ? const Color(0xFFD4AF37) : Colors.white38,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        d.dateLabel,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSel ? Colors.white : Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        d.dayName,
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 8.5,
                          fontWeight: FontWeight.w600,
                          color: isSel ? const Color(0xFFD4AF37) : Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEphemerisCell(String label, String time, String icon) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 14, color: Color(0xFFD4AF37)),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 9.5,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class Realistic3DMoonPainter extends CustomPainter {
  final double illuminationFraction;
  final double subtleWobble;

  Realistic3DMoonPainter({
    required this.illuminationFraction,
    required this.subtleWobble,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.46;

    final glowPaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawCircle(center, radius + 8, glowPaint);

    final darkBasePaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.2, -0.2),
        colors: [Color(0xFF1E2638), Color(0xFF0C101A)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, darkBasePaint);
  }

  @override
  bool shouldRepaint(covariant Realistic3DMoonPainter oldDelegate) =>
      oldDelegate.illuminationFraction != illuminationFraction ||
      oldDelegate.subtleWobble != subtleWobble;
}
