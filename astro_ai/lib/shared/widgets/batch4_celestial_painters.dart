// lib/shared/widgets/batch4_celestial_painters.dart
// ASTROAI OS v5.0 - Batch 4 Procedural 3D Celestial Widgets & Custom Painters
// Contains:
// 1. GoldenPiscesConstellationWidget (3D gold stars & connection lines)
// 2. SplitDualMoon3DWidget (Half basalt dark cratered + half embossed 24K gold filigree)
// 3. SunMoonDaylightArcWidget (Semicircular 24h arc with Rahu Kalam & Shubh Muhurat segments)
// 4. PlanetaryTransitDialWidget (Orbital transit dial with 3D grahas, retrograde badge & center focus)
// 5. DualLayeredKundliWidget (Overlapping D1 Rasi & D9 Navamsa charts with 4 dignity badges)

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// 1. 3D GOLDEN PISCES CONSTELLATION WIDGET (Settings Header Graphic)
// ============================================================================
class GoldenPiscesConstellationWidget extends StatefulWidget {
  final double width;
  final double height;

  const GoldenPiscesConstellationWidget({
    super.key,
    this.width = 160,
    this.height = 120,
  });

  @override
  State<GoldenPiscesConstellationWidget> createState() => _GoldenPiscesConstellationWidgetState();
}

class _GoldenPiscesConstellationWidgetState extends State<GoldenPiscesConstellationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _shimmerController,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.width, widget.height),
            painter: GoldenPiscesConstellationPainter(progress: _shimmerController.value),
          );
        },
      ),
    );
  }
}

class GoldenPiscesConstellationPainter extends CustomPainter {
  final double progress;

  GoldenPiscesConstellationPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Constellation stars normalized coordinates [x, y, radius]
    // Representing Pisces: Northern fish loop, Southern fish loop, and connecting cord
    final stars = [
      // Top fish cluster (Northern fish)
      [0.68, 0.08, 3.2],
      [0.76, 0.14, 4.0],
      [0.72, 0.22, 3.8],
      [0.64, 0.32, 3.0],
      [0.55, 0.44, 3.5],
      // Vertex / knot (Alrescha)
      [0.50, 0.54, 3.0],
      [0.45, 0.60, 4.2], // Alrescha junction
      // Line to Western fish
      [0.38, 0.62, 3.0],
      [0.72, 0.58, 3.4],
      // Bottom/Eastern fish loop
      [0.85, 0.60, 4.0],
      [0.92, 0.62, 3.8],
      [0.96, 0.70, 3.5],
      [0.94, 0.78, 4.0],
      [0.88, 0.80, 3.5],
      [0.82, 0.74, 3.0],
    ];

    // Connection line indices
    final lines = [
      [0, 1], [1, 2], [2, 3], [3, 4], [4, 5], [5, 6],
      [6, 7], [6, 8], [8, 9], [9, 10], [10, 11], [11, 12], [12, 13], [13, 14], [14, 9]
    ];

    // Background faint stars
    final ambientStars = [
      [0.40, 0.15], [0.85, 0.18], [0.35, 0.38], [0.82, 0.35],
      [0.30, 0.75], [0.60, 0.75], [0.70, 0.88], [0.98, 0.30],
      [0.48, 0.82], [0.92, 0.42], [0.25, 0.52], [0.60, 0.20],
    ];

    final bgStarPaint = Paint()..color = Colors.white.withOpacity(0.35);
    for (int i = 0; i < ambientStars.length; i++) {
      final s = ambientStars[i];
      final twinkle = 0.2 + 0.35 * math.sin(progress * math.pi * 2 + i);
      bgStarPaint.color = Colors.white.withOpacity(twinkle.clamp(0.1, 0.6));
      canvas.drawCircle(Offset(s[0] * w, s[1] * h), 1.0, bgStarPaint);
    }

    // Draw connection lines in metallic gold
    final linePaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.65)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final glowLinePaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.20)
      ..strokeWidth = 2.8
      ..style = PaintingStyle.stroke;

    for (final l in lines) {
      final p1 = Offset(stars[l[0]][0] * w, stars[l[0]][1] * h);
      final p2 = Offset(stars[l[1]][0] * w, stars[l[1]][1] * h);
      canvas.drawLine(p1, p2, glowLinePaint);
      canvas.drawLine(p1, p2, linePaint);
    }

    // Draw 3D Golden Star Spheres (Brass beads with specular highlights)
    for (int i = 0; i < stars.length; i++) {
      final s = stars[i];
      final center = Offset(s[0] * w, s[1] * h);
      final radius = s[2] * (1.0 + 0.08 * math.sin(progress * math.pi * 2 + i * 0.5));

      // Golden outer halo
      final haloPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFFD700).withOpacity(0.45),
            const Color(0xFFD4AF37).withOpacity(0.0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius * 3.0));
      canvas.drawCircle(center, radius * 3.0, haloPaint);

      // 3D Metallic brass sphere gradient
      final spherePaint = Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.35, -0.35),
          colors: [
            Color(0xFFFFF7D6), // Specular reflection
            Color(0xFFFFDF73), // Warm yellow gold
            Color(0xFFD4AF37), // Classic gold
            Color(0xFF8B6914), // Dark antique gold shadow
          ],
          stops: [0.0, 0.25, 0.70, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, spherePaint);

      // Tiny white specular glint
      final glintPaint = Paint()..color = Colors.white.withOpacity(0.9);
      canvas.drawCircle(center + Offset(-radius * 0.3, -radius * 0.3), radius * 0.25, glintPaint);
    }
  }

  @override
  bool shouldRepaint(covariant GoldenPiscesConstellationPainter oldDelegate) => true;
}

// ============================================================================
// 2. 3D SPLIT DUAL MOON SPHERE WIDGET (Basalt Lunar Crater + Embossed 24K Gold)
// ============================================================================
class SplitDualMoon3DWidget extends StatefulWidget {
  final double size;
  final bool animateWobble;

  const SplitDualMoon3DWidget({
    super.key,
    this.size = 190,
    this.animateWobble = true,
  });

  @override
  State<SplitDualMoon3DWidget> createState() => _SplitDualMoon3DWidgetState();
}

class _SplitDualMoon3DWidgetState extends State<SplitDualMoon3DWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _wobbleController;

  @override
  void initState() {
    super.initState();
    _wobbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    if (widget.animateWobble) {
      _wobbleController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _wobbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _wobbleController,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: SplitDualMoon3DPainter(wobble: _wobbleController.value),
          );
        },
      ),
    );
  }
}

class SplitDualMoon3DPainter extends CustomPainter {
  final double wobble;

  SplitDualMoon3DPainter({this.wobble = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    // 1. Ambient Warm Cosmic Halo
    final haloPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFD4AF37).withOpacity(0.24),
          const Color(0xFFB8860B).withOpacity(0.08),
          Colors.transparent,
        ],
        stops: const [0.65, 0.85, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.35));
    canvas.drawCircle(center, radius * 1.35, haloPaint);

    // 2. Base Moon Sphere Shadow
    final baseShadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.65)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(center + const Offset(0, 6), radius, baseShadowPaint);

    // Save canvas state for clipping the sphere
    canvas.save();
    final spherePath = Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.clipPath(spherePath);

    // ------------------------------------------------------------------------
    // LEFT HEMISPHERE: REALISTIC DARK BASALT CRATERED LUNAR SURFACE
    // ------------------------------------------------------------------------
    final basaltShader = const RadialGradient(
      center: Alignment(-0.4, -0.4),
      colors: [
        Color(0xFF5A606B), // Ambient grey reflection
        Color(0xFF333842), // Basalt midtone
        Color(0xFF1E2128), // Dark lunar mare
        Color(0xFF0F1115), // Deep shadow edge
      ],
      stops: [0.0, 0.4, 0.75, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, Paint()..shader = basaltShader);

    // Procedural Dark Basalt Craters (Left Side)
    final darkCraters = [
      [Offset(center.dx - radius * 0.45, center.dy - radius * 0.35), radius * 0.18],
      [Offset(center.dx - radius * 0.65, center.dy + radius * 0.05), radius * 0.22],
      [Offset(center.dx - radius * 0.30, center.dy + radius * 0.40), radius * 0.25],
      [Offset(center.dx - radius * 0.50, center.dy + radius * 0.55), radius * 0.14],
      [Offset(center.dx - radius * 0.20, center.dy - radius * 0.60), radius * 0.16],
      [Offset(center.dx - radius * 0.60, center.dy - radius * 0.45), radius * 0.12],
    ];

    for (final c in darkCraters) {
      final cOffset = c[0] as Offset;
      final cRadius = c[1] as double;

      // Crater floor (deep depression)
      final floorPaint = Paint()..color = const Color(0xFF14161C).withOpacity(0.85);
      canvas.drawCircle(cOffset, cRadius, floorPaint);

      // Crater rim highlight (soft top-left edge)
      final rimPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = const Color(0xFF717885).withOpacity(0.5);
      canvas.drawArc(
        Rect.fromCircle(center: cOffset, radius: cRadius),
        math.pi * 0.9,
        math.pi * 0.8,
        false,
        rimPaint,
      );
    }

    // ------------------------------------------------------------------------
    // RIGHT HEMISPHERE: RADIANT EMBOSSED 24K GOLD LUNAR SURFACE
    // ------------------------------------------------------------------------
    // Split boundary curve (lunar terminator)
    final terminatorPath = Path();
    terminatorPath.moveTo(center.dx, center.dy - radius);

    // Curved bezier path giving 3D spherical depth to the terminator
    final curveOffset = math.sin(wobble * math.pi) * 4.0;
    terminatorPath.cubicTo(
      center.dx + radius * 0.18 + curveOffset,
      center.dy - radius * 0.4,
      center.dx + radius * 0.18 + curveOffset,
      center.dy + radius * 0.4,
      center.dx,
      center.dy + radius,
    );
    terminatorPath.lineTo(center.dx + radius * 1.2, center.dy + radius);
    terminatorPath.lineTo(center.dx + radius * 1.2, center.dy - radius);
    terminatorPath.close();

    // Clip to only draw on the illuminated golden right half
    canvas.save();
    canvas.clipPath(terminatorPath);

    // 24K Gold Base Shader
    final goldShader = const RadialGradient(
      center: Alignment(0.4, -0.3),
      colors: [
        Color(0xFFFFF4B8), // Specular sun reflection
        Color(0xFFFFDF73), // 24K pure radiant gold
        Color(0xFFE5B232), // Deep yellow gold
        Color(0xFFB8860B), // Antique gold contour
        Color(0xFF6B4E00), // Shadow terminator rim
      ],
      stops: [0.0, 0.35, 0.65, 0.88, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, Paint()..shader = goldShader);

    // Embossed Golden Filigree Craters & Ornamental Relief Patterns (Right side)
    final goldCraters = [
      [Offset(center.dx + radius * 0.35, center.dy - radius * 0.45), radius * 0.22],
      [Offset(center.dx + radius * 0.50, center.dy + radius * 0.10), radius * 0.30],
      [Offset(center.dx + radius * 0.25, center.dy + radius * 0.50), radius * 0.20],
      [Offset(center.dx + radius * 0.62, center.dy + radius * 0.45), radius * 0.16],
      [Offset(center.dx + radius * 0.22, center.dy - radius * 0.15), radius * 0.15],
    ];

    for (final gc in goldCraters) {
      final cOffset = gc[0] as Offset;
      final cRadius = gc[1] as double;

      // Embossed crater depression
      final goldDepression = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF9E7206).withOpacity(0.9),
            const Color(0xFFD49D24).withOpacity(0.7),
          ],
        ).createShader(Rect.fromCircle(center: cOffset, radius: cRadius));
      canvas.drawCircle(cOffset, cRadius, goldDepression);

      // Embossed golden rim highlight
      final goldRimPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = const Color(0xFFFFF9E0).withOpacity(0.85);
      canvas.drawArc(
        Rect.fromCircle(center: cOffset, radius: cRadius),
        math.pi * 1.1,
        math.pi * 0.9,
        false,
        goldRimPaint,
      );

      // Fine filigree etched inner contour ring
      final filigreePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = const Color(0xFF7A5500).withOpacity(0.6);
      canvas.drawCircle(cOffset, cRadius * 0.6, filigreePaint);
    }

    // Fine ornamental golden filigree scrolls near the perimeter
    final scrollPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0xFFFFF3A8).withOpacity(0.45);

    for (double ang = -math.pi / 2; ang <= math.pi / 2; ang += 0.35) {
      final pOnRim = Offset(center.dx + radius * 0.88 * math.cos(ang), center.dy + radius * 0.88 * math.sin(ang));
      canvas.drawCircle(pOnRim, 3.5, scrollPaint);
    }

    canvas.restore(); // restore terminator clip
    canvas.restore(); // restore sphere clip

    // Golden limb rim glow
    final limbPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi / 2,
        colors: [
          const Color(0xFFFFDF73).withOpacity(0.9),
          const Color(0xFFFFFCE0),
          const Color(0xFFFFDF73).withOpacity(0.9),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi,
      false,
      limbPaint,
    );
  }

  @override
  bool shouldRepaint(covariant SplitDualMoon3DPainter oldDelegate) =>
      oldDelegate.wobble != wobble;
}

// ============================================================================
// 3. SUN AND MOON DAYLIGHT ARC TRACKER WIDGET
// ============================================================================
class SunMoonDaylightArcWidget extends StatelessWidget {
  final double width;
  final double height;
  final double currentProgress; // 0.0 to 1.0 across 24h

  const SunMoonDaylightArcWidget({
    super.key,
    this.width = double.infinity,
    this.height = 140,
    this.currentProgress = 0.42,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF13131A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CustomPaint(
          size: Size(width, height),
          painter: SunMoonDaylightArcPainter(progress: currentProgress),
        ),
      ),
    );
  }
}

class SunMoonDaylightArcPainter extends CustomPainter {
  final double progress;

  SunMoonDaylightArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Center of the arc sits below the bottom of the card to create a graceful rising dome
    final arcCenter = Offset(w / 2, h * 1.08);
    final arcRadius = w * 0.46;

    // Segment definitions (startAngle, sweepAngle, color, hasVerticalProjection)
    // Angles in standard radians: Math.pi to 2*Math.pi is upper semi-circle dome
    // Segment 1: Inauspicious / Rahu Kalam (Reddish coral)
    const s1Start = math.pi + 0.35;
    const s1Sweep = 0.55;
    const s1Color = Color(0xFFE55353);

    // Segment 2: Auspicious / Shubh Muhurat (Emerald green)
    const s2Start = s1Start + s1Sweep;
    const s2Sweep = 0.30;
    const s2Color = Color(0xFF55D488);

    // Segment 3: Neutral daytime transition (Warm gold / beige)
    const s3Start = s2Start + s2Sweep;
    const s3Sweep = 0.85;
    const s3Color = Color(0xFF8F7A56);

    // 1. Draw subtle vertical light curtains projecting downwards from segments
    _drawProjectionCurtain(canvas, arcCenter, arcRadius, s1Start, s1Sweep, s1Color.withOpacity(0.12), h);
    _drawProjectionCurtain(canvas, arcCenter, arcRadius, s2Start, s2Sweep, s2Color.withOpacity(0.12), h);
    _drawProjectionCurtain(canvas, arcCenter, arcRadius, s3Start, s3Sweep, s3Color.withOpacity(0.05), h);

    // 2. Base Dim Track Arc
    final baseTrackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withOpacity(0.10);

    canvas.drawArc(
      Rect.fromCircle(center: arcCenter, radius: arcRadius),
      math.pi + 0.15,
      math.pi - 0.30,
      false,
      baseTrackPaint,
    );

    // 3. Colored Segments
    final s1Paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..color = s1Color;
    canvas.drawArc(Rect.fromCircle(center: arcCenter, radius: arcRadius), s1Start, s1Sweep, false, s1Paint);

    final s2Paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..color = s2Color;
    canvas.drawArc(Rect.fromCircle(center: arcCenter, radius: arcRadius), s2Start, s2Sweep, false, s2Paint);

    final s3Paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..color = s3Color;
    canvas.drawArc(Rect.fromCircle(center: arcCenter, radius: arcRadius), s3Start, s3Sweep, false, s3Paint);

    // 4. Current Time Indicator Node (Golden bead sliding along the arc)
    final activeAngle = math.pi + 0.20 + (math.pi - 0.40) * progress.clamp(0.0, 1.0);
    final nodePos = Offset(
      arcCenter.dx + arcRadius * math.cos(activeAngle),
      arcCenter.dy + arcRadius * math.sin(activeAngle),
    );

    // Glow behind indicator
    final nodeGlow = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(nodePos, 8, nodeGlow);

    // White/Gold Bead
    final nodePaint = Paint()..color = const Color(0xFFFFF2B2);
    canvas.drawCircle(nodePos, 4.5, nodePaint);
  }

  void _drawProjectionCurtain(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
    Color color,
    double bottomY,
  ) {
    final p1 = Offset(center.dx + radius * math.cos(startAngle), center.dy + radius * math.sin(startAngle));
    final p2 = Offset(center.dx + radius * math.cos(startAngle + sweepAngle), center.dy + radius * math.sin(startAngle + sweepAngle));

    final path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p2.dx, bottomY)
      ..lineTo(p1.dx, bottomY)
      ..close();

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color, color.withOpacity(0.0)],
      ).createShader(Rect.fromLTRB(p1.dx, p1.dy, p2.dx, bottomY));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SunMoonDaylightArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ============================================================================
// 4. 3D PLANETARY TRANSIT DIAL WIDGET ("Today's Transits" Orbit Ring)
// ============================================================================
class PlanetaryTransitItem {
  final String id;
  final String name;
  final String sanskrit;
  final String glyph;
  final Color baseColor;
  final bool isRetrograde;
  final bool hasRings;
  final double orbitAngle; // 0.0 to 2*pi
  final double orbitRadiusFraction;

  const PlanetaryTransitItem({
    required this.id,
    required this.name,
    required this.sanskrit,
    required this.glyph,
    required this.baseColor,
    this.isRetrograde = false,
    this.hasRings = false,
    required this.orbitAngle,
    required this.orbitRadiusFraction,
  });
}

class PlanetaryTransitDialWidget extends StatefulWidget {
  final double size;
  final ValueChanged<PlanetaryTransitItem>? onPlanetSelected;

  const PlanetaryTransitDialWidget({
    super.key,
    this.size = 320,
    this.onPlanetSelected,
  });

  @override
  State<PlanetaryTransitDialWidget> createState() => _PlanetaryTransitDialWidgetState();
}

class _PlanetaryTransitDialWidgetState extends State<PlanetaryTransitDialWidget>
    with TickerProviderStateMixin {
  late AnimationController _orbitController;
  late AnimationController _idleSpinController;
  late PlanetaryTransitItem _focusedPlanet;

  // 3D Movable Jupiter & Orbit Parameters
  double _jupiterSpin = 0.0;
  double _jupiterTiltX = 0.0;
  double _orbitPitch = 0.15;

  final List<PlanetaryTransitItem> _orbitPlanets = const [
    PlanetaryTransitItem(
      id: "sun",
      name: "Sun",
      sanskrit: "Surya",
      glyph: "☉",
      baseColor: Color(0xFFE58025),
      orbitAngle: 1.15,
      orbitRadiusFraction: 0.72,
    ),
    PlanetaryTransitItem(
      id: "moon",
      name: "Moon",
      sanskrit: "Chandra",
      glyph: "☽",
      baseColor: Color(0xFF7E8492),
      orbitAngle: 2.30,
      orbitRadiusFraction: 0.68,
    ),
    PlanetaryTransitItem(
      id: "mars",
      name: "Mars",
      sanskrit: "Mangal",
      glyph: "♂",
      baseColor: Color(0xFFC0543E),
      orbitAngle: 3.14,
      orbitRadiusFraction: 0.76,
    ),
    PlanetaryTransitItem(
      id: "mercury",
      name: "Mercury",
      sanskrit: "Budha",
      glyph: "☿",
      baseColor: Color(0xFF7A7F85),
      orbitAngle: 3.85,
      orbitRadiusFraction: 0.58,
    ),
    PlanetaryTransitItem(
      id: "venus",
      name: "Venus",
      sanskrit: "Shukra",
      glyph: "♀",
      baseColor: Color(0xFFDED7C5),
      orbitAngle: 5.50,
      orbitRadiusFraction: 0.62,
    ),
    PlanetaryTransitItem(
      id: "saturn",
      name: "Saturn",
      sanskrit: "Shani",
      glyph: "♄",
      baseColor: Color(0xFFB5A47C),
      isRetrograde: true,
      hasRings: true,
      orbitAngle: 5.95,
      orbitRadiusFraction: 0.80,
    ),
    PlanetaryTransitItem(
      id: "rahu",
      name: "Rahu",
      sanskrit: "North Node",
      glyph: "☊",
      baseColor: Color(0xFF5B6982),
      orbitAngle: 0.35,
      orbitRadiusFraction: 0.74,
    ),
    PlanetaryTransitItem(
      id: "ketu",
      name: "Ketu",
      sanskrit: "South Node",
      glyph: "☋",
      baseColor: Color(0xFF48515E),
      orbitAngle: 0.75,
      orbitRadiusFraction: 0.65,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _focusedPlanet = const PlanetaryTransitItem(
      id: "jupiter",
      name: "Jupiter",
      sanskrit: "Guru",
      glyph: "♃",
      baseColor: Color(0xFFC89D6C),
      orbitAngle: 0,
      orbitRadiusFraction: 0,
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    _idleSpinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..addListener(() {
        setState(() {
          _jupiterSpin += 0.004;
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _idleSpinController.dispose();
    super.dispose();
  }

  void _selectPlanet(PlanetaryTransitItem p) {
    HapticFeedback.selectionClick();
    setState(() {
      _focusedPlanet = p;
    });
    widget.onPlanetSelected?.call(p);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Interactive 3D Orbital Rings with Perspective Pitch
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..rotateX(_orbitPitch)
                  ..rotateY(0.0),
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: OrbitalRingsPainter(),
                ),
              ),

              // 2. Surrounding Vedic Grahas
              ..._orbitPlanets.map((planet) {
                final r = (widget.size / 2) * planet.orbitRadiusFraction;
                final x = (widget.size / 2) + r * math.cos(planet.orbitAngle - math.pi / 2);
                final y = (widget.size / 2) + r * math.sin(planet.orbitAngle - math.pi / 2);

                final isSaturn = planet.hasRings;
                final isSelected = _focusedPlanet.id == planet.id;

                return Positioned(
                  left: x - 22,
                  top: y - 22,
                  child: GestureDetector(
                    onTap: () => _selectPlanet(planet),
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: planet.id == 'mercury' || planet.id == 'venus' ? 28 : 22,
                            height: planet.id == 'mercury' || planet.id == 'venus' ? 28 : 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                center: const Alignment(-0.3, -0.3),
                                colors: [
                                  planet.baseColor.withOpacity(0.9),
                                  planet.baseColor,
                                  planet.baseColor.withOpacity(0.4),
                                  Colors.black87,
                                ],
                                stops: const [0.0, 0.45, 0.80, 1.0],
                              ),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFFFD700) : Colors.white12,
                                width: isSelected ? 1.5 : 0.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: planet.baseColor.withOpacity(0.35),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),

                          if (isSaturn)
                            Transform.rotate(
                              angle: -0.45,
                              child: Container(
                                width: 38,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: const Color(0xFFDCD0B4).withOpacity(0.8),
                                    width: 2.2,
                                  ),
                                ),
                              ),
                            ),

                          if (planet.isRetrograde)
                            Positioned(
                              top: -2,
                              right: -4,
                              child: Container(
                                width: 13,
                                height: 13,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE07A5F),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "R",
                                  style: TextStyle(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              // 3. Central Focused Planet (Interactive 3D Movable Jupiter Sphere)
              Positioned(
                bottom: 12,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _jupiterSpin += details.delta.dx * 0.02;
                      _jupiterTiltX = (_jupiterTiltX - details.delta.dy * 0.015).clamp(-0.45, 0.45);
                      _orbitPitch = (_orbitPitch - details.delta.dy * 0.005).clamp(-0.35, 0.45);
                    });
                  },
                  onDoubleTap: () {
                    HapticFeedback.lightImpact();
                    setState(() {
                      _jupiterTiltX = 0.0;
                      _orbitPitch = 0.15;
                    });
                  },
                  child: Container(
                    width: 108,
                    height: 108,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _focusedPlanet.baseColor.withOpacity(0.55),
                          blurRadius: 32,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: JupiterBandedSpherePainter(
                        spinAngle: _jupiterSpin,
                        tiltX: _jupiterTiltX,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Focused Planet Name Headline
        Text(
          _focusedPlanet.name,
          style: const TextStyle(
            fontFamily: 'Cormorant Garamond',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 4),

        // 3D Interaction Hint
        Text(
          "DRAG JUPITER TO ROTATE IN 3D",
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 8.5,
            letterSpacing: 1.2,
            color: Colors.white.withOpacity(0.35),
          ),
        ),
      ],
    );
  }
}

// 3D Atmospheric Shader for Movable Jupiter

class OrbitalRingsPainter extends CustomPainter {
  final double tiltX;
  final double tiltY;

  OrbitalRingsPainter({this.tiltX = 0.0, this.tiltY = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = size.width / 2 - 12;

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withOpacity(0.08);

    canvas.drawOval(
      Rect.fromCenter(center: center, width: maxR * 1.1, height: maxR * 0.9),
      ringPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: center, width: maxR * 1.44, height: maxR * 1.18),
      ringPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: center, width: maxR * 1.76, height: maxR * 1.44),
      ringPaint,
    );
  }

  @override
  bool shouldRepaint(covariant OrbitalRingsPainter oldDelegate) =>
      oldDelegate.tiltX != tiltX || oldDelegate.tiltY != tiltY;
}

class JupiterBandedSpherePainter extends CustomPainter {
  final double spinAngle;
  final double tiltX;

  JupiterBandedSpherePainter({
    this.spinAngle = 0.0,
    this.tiltX = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Save clip to circle
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

    // Base Jovian creamy tan atmosphere
    canvas.drawRect(
      Rect.fromCircle(center: center, radius: radius),
      Paint()..color = const Color(0xFFC7A77E),
    );

    // Atmospheric striped bands
    final bandColors = [
      const Color(0xFF966847),
      const Color(0xFFDEC39F),
      const Color(0xFF8B5738),
      const Color(0xFFDFC6A6),
      const Color(0xFFA66F4B),
      const Color(0xFFCFB390),
      const Color(0xFF7E4A2F),
      const Color(0xFFC8A67B),
    ];

    double y = 0;
    final bandH = size.height / bandColors.length;
    for (int i = 0; i < bandColors.length; i++) {
      final col = bandColors[i];
      // Curve bands slightly according to 3D tiltX
      final curveOffset = math.sin((i / bandColors.length) * math.pi) * tiltX * 16;
      final path = Path()
        ..moveTo(0, y + curveOffset)
        ..quadraticBezierTo(size.width / 2, y + curveOffset * 1.4, size.width, y + curveOffset)
        ..lineTo(size.width, y + bandH + curveOffset)
        ..quadraticBezierTo(size.width / 2, y + bandH + curveOffset * 1.4, 0, y + bandH + curveOffset)
        ..close();

      canvas.drawPath(path, Paint()..color = col);
      y += bandH;
    }

    // Great Red Spot storm vortex with 3D Spherical Rotation
    final double grsLon = spinAngle + 0.35;
    final double visibleFactor = math.sin(grsLon);

    // Only draw Great Red Spot when rotated on the visible front hemisphere
    if (visibleFactor > -0.15) {
      final double grsX = center.dx + radius * 0.72 * math.cos(grsLon);
      final double grsY = center.dy + radius * 0.28 + tiltX * 18;
      final double grsWidth = (22.0 * visibleFactor.abs()).clamp(4.0, 22.0);

      final grsCenter = Offset(grsX, grsY);
      final grsPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFB8452D),
            const Color(0xFFD67355),
            const Color(0xFFA13722).withOpacity(0.0),
          ],
        ).createShader(Rect.fromCircle(center: grsCenter, radius: 10));

      canvas.drawOval(
        Rect.fromCenter(center: grsCenter, width: grsWidth, height: 11),
        grsPaint,
      );
    }

    // 3D Spherical Ambient Shadow & Specular Gradient
    final sphereShadow = Paint()
      ..shader = RadialGradient(
        center: Alignment(-0.25, -0.35 + tiltX * 0.3),
        colors: [
          Colors.white.withOpacity(0.38), // Specular sheen
          Colors.transparent,
          Colors.black.withOpacity(0.55),
          Colors.black.withOpacity(0.95), // Deep shadow edge
        ],
        stops: const [0.0, 0.45, 0.80, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, sphereShadow);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant JupiterBandedSpherePainter oldDelegate) {
    return oldDelegate.spinAngle != spinAngle || oldDelegate.tiltX != tiltX;
  }
}
// ============================================================================
// 5. DUAL LAYERED KUNDLI WIDGET (D1 Rasi + D9 Navamsa Overlap with 4 Dignities)
// ============================================================================
class DualLayeredKundliWidget extends StatefulWidget {
  final VoidCallback? onLearnTapped;

  const DualLayeredKundliWidget({
    super.key,
    this.onLearnTapped,
  });

  @override
  State<DualLayeredKundliWidget> createState() => _DualLayeredKundliWidgetState();
}

class _DualLayeredKundliWidgetState extends State<DualLayeredKundliWidget>
    with TickerProviderStateMixin {
  bool _isNavamsaPrimary = false;

  // 3D Movable Tilt Angles
  double _tiltX = 0.0;
  double _tiltY = 0.0;

  late AnimationController _flipController;
  late AnimationController _resetController;
  late Animation<double> _resetAnimX;
  late Animation<double> _resetAnimY;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    _resetController.dispose();
    super.dispose();
  }

  void _togglePrimaryChart(bool navamsa) {
    if (_isNavamsaPrimary != navamsa) {
      HapticFeedback.selectionClick();
      if (_flipController.isCompleted) {
        _flipController.reverse();
      } else {
        _flipController.forward();
      }
      setState(() {
        _isNavamsaPrimary = navamsa;
      });
    }
  }

  void _resetTilt() {
    HapticFeedback.lightImpact();
    _resetAnimX = Tween<double>(begin: _tiltX, end: 0.0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
    _resetAnimY = Tween<double>(begin: _tiltY, end: 0.0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );

    _resetController.reset();
    _resetController.addListener(() {
      setState(() {
        _tiltX = _resetAnimX.value;
        _tiltY = _resetAnimY.value;
      });
    });
    _resetController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.09)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: Birth Chart | Learn
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Birth Chart",
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: widget.onLearnTapped ?? () {
                  HapticFeedback.lightImpact();
                  _showLearnModal(context);
                },
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

          const SizedBox(height: 14),

          // 2. Pill Toggle: [ Rasi Chart ] vs [ Navamsa Chart ]
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFF121215),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _togglePrimaryChart(false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: !_isNavamsaPrimary ? const Color(0xFFE07A5F) : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Rasi Chart",
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: !_isNavamsaPrimary ? Colors.white : Colors.white60,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _togglePrimaryChart(true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: _isNavamsaPrimary ? const Color(0xFFE07A5F) : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Navamsa Chart",
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _isNavamsaPrimary ? Colors.white : Colors.white60,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 3. Primary Chart Label
          Center(
            child: Text(
              _isNavamsaPrimary ? "Navamsa chart (D9)" : "Rasi chart (D1)",
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // 4. Overlapping 3D Movable Geometric Chart Stack
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _tiltY = (_tiltY + details.delta.dx * 0.007).clamp(-0.45, 0.45);
                _tiltX = (_tiltX - details.delta.dy * 0.007).clamp(-0.45, 0.45);
              });
            },
            onDoubleTap: _resetTilt,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0016)
                ..rotateX(_tiltX)
                ..rotateY(_tiltY),
              child: SizedBox(
                height: 290,
                child: Stack(
                  children: [
                    // Primary Base Diamond Chart
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF28282B),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: CustomPaint(
                          painter: CleanNorthIndianDiamondPainter(
                            isD9: _isNavamsaPrimary,
                          ),
                        ),
                      ),
                    ),

                    // Floating 3D Secondary Chart with Z-Depth Parallax
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Transform.translate(
                        offset: Offset(-_tiltY * 18, -_tiltX * 18),
                        child: GestureDetector(
                          onTap: () => _togglePrimaryChart(!_isNavamsaPrimary),
                          child: Container(
                            width: 175,
                            height: 175,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF202024),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.80),
                                  blurRadius: 24,
                                  offset: Offset(-6 - _tiltY * 8, -6 - _tiltX * 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _isNavamsaPrimary ? "Rasi chart (D1)" : "Navamsa chart (D9)",
                                  style: const TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Expanded(
                                  child: CustomPaint(
                                    painter: VerticalCelestialAxisPainter(
                                      isD9: !_isNavamsaPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 3D Interaction Hint
          Center(
            child: Text(
              "DRAG TO TILT IN 3D • DOUBLE TAP TO RESET",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 8.5,
                letterSpacing: 1.2,
                color: Colors.white.withOpacity(0.35),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // 5. Four Dignity Badges Row: Strong (Green) | Weakened (Red) | Enemy (Purple) | Neutral (Gray)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDignityBadge("Strong", const Color(0xFF00FF66)),
              _buildDignityBadge("Weakened", const Color(0xFFFF4D4D)),
              _buildDignityBadge("Enemy", const Color(0xFF9D65FF)),
              _buildDignityBadge("Neutral", const Color(0xFF9E9E9E)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDignityBadge(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 11.5,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showLearnModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF13131F),
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
              "Vedic Chart Essentials",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "• Rasi Chart (D1): Your physical constitution, foundational karma, and public destiny.\n"
              "• Navamsa Chart (D9): The 9th harmonic division, revealing your soul's spiritual purpose, inner strengths, and life partner compatibility.\n"
              "• Dignities: Planetary states (Exalted/Strong, Debilitated/Weakened, Enemy, or Neutral) govern how easily each graha manifests its potential.",
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Understood", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Accurate Diamond North Indian Chart Painter with Dignity Highlights
class CleanNorthIndianDiamondPainter extends CustomPainter {
  final bool isD9;

  CleanNorthIndianDiamondPainter({required this.isD9});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Outer boundary
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), linePaint);

    // Diagonal lines (corner to corner)
    canvas.drawLine(const Offset(0, 0), Offset(w, h), linePaint);
    canvas.drawLine(Offset(0, h), Offset(w, 0), linePaint);

    // Inner diamond (midpoints)
    final diamondPath = Path()
      ..moveTo(w / 2, 0)
      ..lineTo(w, h / 2)
      ..lineTo(w / 2, h)
      ..lineTo(0, h / 2)
      ..close();
    canvas.drawPath(diamondPath, linePaint);

    // House Numbers and Grahas
    // Colors matching legend:
    // Green (Strong): Color(0xFF00FF66)
    // Red (Weakened): Color(0xFFFF4D4D)
    // Purple (Enemy): Color(0xFF9D65FF)
    // Gray (Neutral): Color(0xFF9E9E9E)
    // Cyan/Blue (General): Color(0xFF4FC3F7)
    // Terracotta (Lagna): Color(0xFFE07A5F)

    final numStyle = TextStyle(
      fontSize: w > 200 ? 11 : 8,
      color: Colors.white38,
      fontFamily: 'Space Mono',
    );

    if (!isD9) {
      // D1 Rasi Chart Data (Exact to reference screenshot)
      // House 1 (Top Center diamond): Lagna 3 (Gemini), Lg
      _drawCenteredText(canvas, "3", Offset(w * 0.44, h * 0.28), numStyle);
      _drawCenteredText(canvas, "Lg", Offset(w * 0.44, h * 0.36), TextStyle(fontSize: w > 200 ? 12 : 9, color: const Color(0xFFE07A5F), fontWeight: FontWeight.bold));

      // House 2 (Top Right triangle): 2 (Taurus), Su (Purple - Enemy), Me (Cyan), +1
      _drawCenteredText(canvas, "2", Offset(w * 0.60, h * 0.16), numStyle);
      _drawCenteredText(canvas, "Su", Offset(w * 0.60, h * 0.23), TextStyle(fontSize: w > 200 ? 11 : 8.5, color: const Color(0xFF9D65FF), fontWeight: FontWeight.bold));
      _drawCenteredText(canvas, "Me", Offset(w * 0.60, h * 0.30), TextStyle(fontSize: w > 200 ? 11 : 8.5, color: const Color(0xFF4FC3F7), fontWeight: FontWeight.bold));
      _drawCenteredText(canvas, "+1", Offset(w * 0.60, h * 0.37), TextStyle(fontSize: w > 200 ? 10 : 7.5, color: Colors.white54));

      // House 12 (Top Left triangle): 4 (Cancer)
      _drawCenteredText(canvas, "4", Offset(w * 0.27, h * 0.16), numStyle);

      // House 11 (Left Upper triangle): 5 (Leo), Ma (Cyan)
      _drawCenteredText(canvas, "5", Offset(w * 0.12, h * 0.27), numStyle);
      _drawCenteredText(canvas, "Ma", Offset(w * 0.13, h * 0.35), TextStyle(fontSize: w > 200 ? 11 : 8.5, color: const Color(0xFF4FC3F7), fontWeight: FontWeight.bold));

      // House 3 (Right Upper triangle): 1 (Aries), Ke (Gray)
      _drawCenteredText(canvas, "1", Offset(w * 0.75, h * 0.27), numStyle);
      _drawCenteredText(canvas, "Ke", Offset(w * 0.76, h * 0.35), TextStyle(fontSize: w > 200 ? 11 : 8.5, color: const Color(0xFF9E9E9E), fontWeight: FontWeight.bold));

      // House 10 (Left Center diamond): 6 (Virgo)
      _drawCenteredText(canvas, "6", Offset(w * 0.27, h * 0.56), numStyle);

      // House 4 (Right Center diamond): 12 (Pisces)
      _drawCenteredText(canvas, "12", Offset(w * 0.60, h * 0.56), numStyle);

      // House 9 (Left Lower triangle): 7 (Libra), Ra (Gray)
      _drawCenteredText(canvas, "7", Offset(w * 0.12, h * 0.63), numStyle);
      _drawCenteredText(canvas, "Ra", Offset(w * 0.13, h * 0.71), TextStyle(fontSize: w > 200 ? 11 : 8.5, color: const Color(0xFF9E9E9E), fontWeight: FontWeight.bold));

      // House 8 (Bottom Center diamond): 8 (Scorpio), Ju (Cyan)
      _drawCenteredText(canvas, "8", Offset(w * 0.27, h * 0.70), numStyle);
      _drawCenteredText(canvas, "Ju", Offset(w * 0.27, h * 0.77), TextStyle(fontSize: w > 200 ? 11 : 8.5, color: const Color(0xFF4FC3F7), fontWeight: FontWeight.bold));
    } else {
      // D9 Navamsa Chart Data
      _drawCenteredText(canvas, "8", Offset(w * 0.44, h * 0.24), numStyle);
      _drawCenteredText(canvas, "Lg", Offset(w * 0.44, h * 0.31), TextStyle(fontSize: w > 200 ? 11 : 8, color: const Color(0xFFE07A5F), fontWeight: FontWeight.bold));
      _drawCenteredText(canvas, "Mo", Offset(w * 0.44, h * 0.37), TextStyle(fontSize: w > 200 ? 10 : 7.5, color: const Color(0xFFFF4D4D), fontWeight: FontWeight.bold));

      _drawCenteredText(canvas, "9", Offset(w * 0.27, h * 0.18), numStyle);
      _drawCenteredText(canvas, "7", Offset(w * 0.60, h * 0.18), numStyle);
      _drawCenteredText(canvas, "6", Offset(w * 0.75, h * 0.27), numStyle);
      _drawCenteredText(canvas, "Su", Offset(w * 0.76, h * 0.35), TextStyle(fontSize: w > 200 ? 10 : 7.5, color: const Color(0xFF9E9E9E)));

      _drawCenteredText(canvas, "5", Offset(w * 0.60, h * 0.52), numStyle);
      _drawCenteredText(canvas, "Ma", Offset(w * 0.60, h * 0.59), TextStyle(fontSize: w > 200 ? 10 : 7.5, color: const Color(0xFF4FC3F7)));

      _drawCenteredText(canvas, "2", Offset(w * 0.44, h * 0.70), numStyle);
      _drawCenteredText(canvas, "Me", Offset(w * 0.44, h * 0.77), TextStyle(fontSize: w > 200 ? 10 : 7.5, color: const Color(0xFF4FC3F7)));
    }
  }

  void _drawCenteredText(Canvas canvas, String text, Offset center, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, center - Offset(painter.width / 2, painter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CleanNorthIndianDiamondPainter oldDelegate) =>
      oldDelegate.isD9 != isD9;
}


// 3D Vertical Celestial Axis Painter matching Screenshots 2 & 4
class VerticalCelestialAxisPainter extends CustomPainter {
  final bool isD9;

  VerticalCelestialAxisPainter({required this.isD9});

  @override
  void paint(Canvas canvas, Size size) {
    const double centerX = 175 / 2;
    const double topY = 10;
    final double bottomY = size.height - 10;

    // Glowing Central Vertical Celestial Axis Rod
    final rodGlow = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..strokeWidth = 3.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawLine(const Offset(centerX, topY), Offset(centerX, bottomY), rodGlow);

    final rodPaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..strokeWidth = 1.2;
    canvas.drawLine(const Offset(centerX, topY), Offset(centerX, bottomY), rodPaint);

    if (isD9) {
      // Navamsa (D9) Floating Card Axis (Screenshot 2)
      // Nodes from top to bottom: 9, Su (purple), 8, Lg (terracotta), Mo (red), 5, Ma (cyan), 2, Me (cyan)
      _drawAxisNode(canvas, centerX, topY + 12, "9", Colors.white54, isGlyph: false);
      _drawAxisNode(canvas, centerX, topY + 28, "Su", const Color(0xFF9D65FF));
      _drawAxisNode(canvas, centerX, topY + 44, "8", Colors.white54, isGlyph: false);
      _drawAxisNode(canvas, centerX, topY + 58, "Lg", const Color(0xFFE07A5F));
      _drawAxisNode(canvas, centerX, topY + 72, "Mo", const Color(0xFFFF4D4D));
      _drawAxisNode(canvas, centerX, topY + 88, "5", Colors.white54, isGlyph: false);
      _drawAxisNode(canvas, centerX, topY + 104, "Ma", const Color(0xFF4FC3F7));
      _drawAxisNode(canvas, centerX, topY + 118, "2", Colors.white54, isGlyph: false);
      _drawAxisNode(canvas, centerX, topY + 132, "Me", const Color(0xFF4FC3F7));
    } else {
      // Rasi (D1) Floating Card Axis (Screenshot 4)
      // Nodes from top to bottom: 3, Su (purple), Me (cyan), Lg (terracotta), 12, 7, Ra (gray), Ju (cyan)
      _drawAxisNode(canvas, centerX, topY + 12, "3", Colors.white54, isGlyph: false);
      _drawAxisNode(canvas, centerX, topY + 28, "Su", const Color(0xFF9D65FF));
      _drawAxisNode(canvas, centerX, topY + 44, "Me", const Color(0xFF4FC3F7));
      _drawAxisNode(canvas, centerX, topY + 60, "Lg", const Color(0xFFE07A5F));
      _drawAxisNode(canvas, centerX, topY + 76, "12", Colors.white54, isGlyph: false);
      _drawAxisNode(canvas, centerX, topY + 92, "7", Colors.white54, isGlyph: false);
      _drawAxisNode(canvas, centerX, topY + 108, "Ra", const Color(0xFF9E9E9E));
      _drawAxisNode(canvas, centerX, topY + 124, "Ju", const Color(0xFF4FC3F7));
    }
  }

  void _drawAxisNode(Canvas canvas, double x, double y, String label, Color color, {bool isGlyph = true}) {
    // Small horizontal tick mark
    canvas.drawLine(
      Offset(x - 3, y),
      Offset(x + 3, y),
      Paint()..color = Colors.white30..strokeWidth = 0.8,
    );

    final textStyle = TextStyle(
      fontSize: isGlyph ? 9.5 : 8.0,
      fontWeight: isGlyph ? FontWeight.bold : FontWeight.normal,
      color: color,
      fontFamily: isGlyph ? 'Plus Jakarta Sans' : 'Space Mono',
    );

    final painter = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    painter.paint(canvas, Offset(x - painter.width / 2, y - painter.height / 2));
  }

  @override
  bool shouldRepaint(covariant VerticalCelestialAxisPainter oldDelegate) =>
      oldDelegate.isD9 != isD9;
}
