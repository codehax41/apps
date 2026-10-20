// lib/shared/widgets/batch5_celestial_painters.dart
// ASTROAI OS v5.0 - Batch 5 Procedural 3D Celestial Widgets & Custom Painters
// Contains:
// 1. CircularScoreMeterWidget (Scores 100, 69, 96, 99 with category badges)
// 2. WhyThisScoreCardWidget (Supporting planetary factors: Mercury +11, Venus +20)
// 3. BestHoursHoraListWidget (Career, Money, Love, Wellness, and Rahu Kalam orange bar)
// 4. GunMilanAshtaKootBreakdownWidget (29.5/36 Points, Priya vs You, Gana, Bhakoot, Nadi)
// 5. GoldenScroll3DWidget (Procedural purple & gold astrological parchment scroll)

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// 1. CIRCULAR SCORE METER WIDGET (Scores 100, 69, 96, 99 with category badges)
// ============================================================================
class CircularScoreMeterWidget extends StatelessWidget {
  final int score;
  final String label;
  final IconData icon;
  final Color iconBadgeColor;
  final VoidCallback? onTap;
  final bool isSelected;

  const CircularScoreMeterWidget({
    super.key,
    required this.score,
    required this.label,
    required this.icon,
    required this.iconBadgeColor,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Custom Circular Meter Arc
                CustomPaint(
                  size: const Size(72, 72),
                  painter: CircularScoreArcPainter(
                    score: score,
                    strokeColor: const Color(0xFF00FF66),
                    isSelected: isSelected,
                  ),
                ),

                // Center Score Number
                Text(
                  "$score",
                  style: const TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // Category Icon Badge (Pinned to bottom-right of the circle)
                Positioned(
                  right: 0,
                  bottom: 2,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: iconBadgeColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF1E1D24), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: iconBadgeColor.withOpacity(0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xFFE07A5F) : Colors.white70,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.chevron_right, size: 14, color: Colors.white54),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularScoreArcPainter extends CustomPainter {
  final int score;
  final Color strokeColor;
  final bool isSelected;

  CircularScoreArcPainter({
    required this.score,
    required this.strokeColor,
    this.isSelected = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Track Background
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..color = Colors.white.withOpacity(0.12);
    canvas.drawCircle(center, radius, trackPaint);

    // Active Score Arc
    final sweep = (score / 100.0) * (2 * math.pi);
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSelected ? 4.5 : 3.5
      ..strokeCap = StrokeCap.round
      ..color = strokeColor;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweep,
      false,
      arcPaint,
    );

    // Selection Glow
    if (isSelected) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6.0
        ..color = strokeColor.withOpacity(0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(center, radius, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CircularScoreArcPainter oldDelegate) =>
      oldDelegate.score != score || oldDelegate.isSelected != isSelected;
}

// ============================================================================
// 2. WHY THIS SCORE BREAKDOWN CARD WIDGET
// ============================================================================
class WhyThisScoreCardWidget extends StatelessWidget {
  final int score;
  final String categoryTitle;
  final String summary;
  final List<ScoreFactorItem> factors;
  final VoidCallback? onBack;
  final VoidCallback? onShare;

  const WhyThisScoreCardWidget({
    super.key,
    required this.score,
    required this.categoryTitle,
    required this.summary,
    required this.factors,
    this.onBack,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1D24),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.65),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: < Today | Share
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBack,
                child: const Row(
                  children: [
                    Icon(Icons.chevron_left, color: Colors.white70, size: 20),
                    SizedBox(width: 4),
                    Text(
                      "Today",
                      style: TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onShare,
                child: const Icon(Icons.share_outlined, size: 18, color: Colors.white70),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Big Circular Ring Meter: 100 with Cash badge
          Center(
            child: SizedBox(
              width: 96,
              height: 96,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(96, 96),
                    painter: CircularScoreArcPainter(
                      score: score,
                      strokeColor: const Color(0xFF00FF66),
                      isSelected: true,
                    ),
                  ),
                  Text(
                    "$score",
                    style: const TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2ECC71),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.payments_outlined, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Description Paragraph
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("⚵ ", style: TextStyle(color: Color(0xFFE07A5F), fontSize: 16)),
              Expanded(
                child: Text(
                  summary,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // Section Title: Why this score
          const Text(
            "Why this score",
            style: TextStyle(
              fontFamily: 'Cormorant Garamond',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          // Supporting Factors Subheader
          const Row(
            children: [
              Icon(Icons.arrow_upward, size: 14, color: Color(0xFF00FF66)),
              SizedBox(width: 6),
              Text(
                "Supporting Factors",
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00FF66),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Factor Rows
          ...factors.map((f) => _buildFactorRow(f)),
        ],
      ),
    );
  }

  Widget _buildFactorRow(ScoreFactorItem f) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  f.placementTitle,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "+${f.points}",
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FF66),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            f.explanation,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              height: 1.4,
              color: Colors.white.withOpacity(0.65),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreFactorItem {
  final String placementTitle;
  final int points;
  final String explanation;

  const ScoreFactorItem({
    required this.placementTitle,
    required this.points,
    required this.explanation,
  });
}

// ============================================================================
// 3. BEST HOURS & RAHU KALAM TIMINGS WIDGET
// ============================================================================
class BestHourWindowItem {
  final String category;
  final String timeRange;
  final String horaDescription;
  final String? badgeText;
  final Color iconColor;
  final IconData icon;
  final bool isRahuKalam;

  const BestHourWindowItem({
    required this.category,
    required this.timeRange,
    required this.horaDescription,
    this.badgeText,
    required this.iconColor,
    required this.icon,
    this.isRahuKalam = false,
  });
}

class BestHoursHoraListWidget extends StatelessWidget {
  final List<BestHourWindowItem> items;

  const BestHoursHoraListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((w) => _buildWindowRow(w)).toList(),
    );
  }

  Widget _buildWindowRow(BestHourWindowItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Left Orange Indicator Bar for Rahu Kalam
          if (item.isRahuKalam)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 3.5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE07A5F),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

          Padding(
            padding: EdgeInsets.only(left: item.isRahuKalam ? 18.0 : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circular Category Icon Container
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: item.iconColor.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, size: 18, color: item.iconColor),
                ),

                const SizedBox(width: 14),

                // Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Label (e.g. CAREER, MONEY, RAHU KALAM)
                      Text(
                        item.category,
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          color: item.isRahuKalam
                              ? const Color(0xFFE07A5F)
                              : Colors.white.withOpacity(0.55),
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Time Range (e.g. 5:06 PM - 6:06 PM)
                      Text(
                        item.timeRange,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Hora Details (e.g. Jupiter Hour • Jupiter rules your 10th house)
                      Text(
                        item.horaDescription,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 11.5,
                          color: Colors.white.withOpacity(0.60),
                        ),
                      ),

                      // Dignity Badge (e.g. Strong / Own Sign)
                      if (item.badgeText != null) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00FF66).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.35)),
                          ),
                          child: Text(
                            item.badgeText!,
                            style: const TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00FF66),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. GUN MILAN ASHTA KOOT BREAKDOWN WIDGET
// ============================================================================
class AshtakootRowItem {
  final String kutaName;
  final String pointsFraction; // e.g. "6/6", "7/7", "8/8"
  final String femaleAttribute;
  final String maleAttribute;
  final String description;

  const AshtakootRowItem({
    required this.kutaName,
    required this.pointsFraction,
    required this.femaleAttribute,
    required this.maleAttribute,
    required this.description,
  });
}

class GunMilanAshtaKootBreakdownWidget extends StatelessWidget {
  final String partnerName;
  final double totalScore;
  final double maxScore;
  final String verdict;
  final List<AshtakootRowItem> kutas;

  const GunMilanAshtaKootBreakdownWidget({
    super.key,
    this.partnerName = "Priya",
    this.totalScore = 29.5,
    this.maxScore = 36.0,
    this.verdict = "Excellent",
    required this.kutas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total Score Headline
        Center(
          child: Column(
            children: [
              Text(
                "${totalScore % 1 == 0 ? totalScore.toInt() : totalScore}/${maxScore.toInt()} Points",
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FF66),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                verdict,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.65),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        // Partner Comparison Header: [ Priya ♀ ] vs [ You ♂ ]
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Icon(Icons.female, size: 20, color: Color(0xFFE07A5F)),
                const SizedBox(height: 2),
                Text(
                  partnerName,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const Column(
              children: [
                Icon(Icons.male, size: 20, color: Color(0xFFE07A5F)),
                SizedBox(height: 2),
                Text(
                  "You",
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 18),

        // Ashta Koot Rows
        ...kutas.map((k) => _buildKootRow(k)),
      ],
    );
  }

  Widget _buildKootRow(AshtakootRowItem k) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kuta Name & Points
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                k.kutaName,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                k.pointsFraction,
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE07A5F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Attributes Comparison
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                k.femaleAttribute,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              Text(
                k.maleAttribute,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Underline separator
          Container(
            width: double.infinity,
            height: 1.5,
            decoration: BoxDecoration(
              color: const Color(0xFFE07A5F).withOpacity(0.55),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 6),

          // Description
          Text(
            k.description,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 11,
              color: Colors.white.withOpacity(0.50),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. 3D GOLDEN PARCHMENT SCROLL WIDGET (for Kundli Bento Card)
// ============================================================================
class GoldenScroll3DWidget extends StatelessWidget {
  final double size;

  const GoldenScroll3DWidget({super.key, this.size = 54});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: GoldenScrollPainter(),
      ),
    );
  }
}

class GoldenScrollPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Purple Rolled Parchment Body
    final bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFC084FC),
          Color(0xFFA855F7),
          Color(0xFF7E22CE),
        ],
      ).createShader(Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.70, h * 0.70));

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.20, h * 0.15, w * 0.60, h * 0.68),
      const Radius.circular(8),
    );
    canvas.drawRRect(rrect, bodyPaint);

    // Wavy Sanskrit Text Glyphs on Scroll
    final textLinePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 4; i++) {
      final y = h * (0.30 + i * 0.11);
      final path = Path()
        ..moveTo(w * 0.30, y)
        ..quadraticBezierTo(w * 0.42, y - 2, w * 0.50, y)
        ..quadraticBezierTo(w * 0.58, y + 2, w * 0.70, y);
      canvas.drawPath(path, textLinePaint);
    }

    // Scroll Roll Rims (Top & Bottom cylinder edges)
    final rollPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFE9D5FF),
          Color(0xFFA855F7),
          Color(0xFF6B21A8),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    // Bottom rolled cylinder
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.78, w * 0.70, h * 0.14),
        const Radius.circular(6),
      ),
      rollPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
