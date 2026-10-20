// lib/shared/widgets/reports_celestial_painters.dart
// AstroAI OS v4.2 - High-Fidelity Custom Procedural Painters for Vedic Reports

import 'dart:math' as math;
import 'package:flutter/material.dart';

// 1. Dasha Chakra Wheel Painter (24-Spoke Vedic Astrological Wheel)
class DashaChakraWheelPainter extends CustomPainter {
  final double animationProgress;
  final Color primaryColor;
  final Color accentColor;

  DashaChakraWheelPainter({
    this.animationProgress = 1.0,
    this.primaryColor = const Color(0xFFD4AF37),
    this.accentColor = const Color(0xFF8A2BE2),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 8;

    // Outer Glow Ring
    final glowPaint = Paint()
      ..color = primaryColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, radius, glowPaint);

    // Rim
    final rimPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius, rimPaint);
    canvas.drawCircle(center, radius * 0.85, rimPaint..strokeWidth = 1.0);
    canvas.drawCircle(center, radius * 0.45, rimPaint..strokeWidth = 1.2);

    // 24 Spokes (Dasha Nakshatra divisions)
    final spokePaint = Paint()
      ..color = primaryColor.withOpacity(0.55)
      ..strokeWidth = 0.8;

    const int totalSpokes = 24;
    final rotation = animationProgress * 2 * math.pi;

    for (int i = 0; i < totalSpokes; i++) {
      final angle = rotation + (i * 2 * math.pi / totalSpokes);
      final p1 = Offset(center.dx + radius * 0.45 * math.cos(angle), center.dy + radius * 0.45 * math.sin(angle));
      final p2 = Offset(center.dx + radius * 0.85 * math.cos(angle), center.dy + radius * 0.85 * math.sin(angle));
      canvas.drawLine(p1, p2, spokePaint);

      // Orbital Beads
      if (i % 2 == 0) {
        final dotPaint = Paint()
          ..color = (i % 4 == 0) ? accentColor : primaryColor
          ..style = PaintingStyle.fill;
        final beadPos = Offset(center.dx + radius * 0.92 * math.cos(angle), center.dy + radius * 0.92 * math.sin(angle));
        canvas.drawCircle(beadPos, 2.5, dotPaint);
      }
    }

    // Central Hub (Sun/Brahma Core)
    final hubPaint = Paint()
      ..shader = RadialGradient(
        colors: [primaryColor, accentColor, Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.35));
    canvas.drawCircle(center, radius * 0.35, hubPaint);
  }

  @override
  bool shouldRepaint(covariant DashaChakraWheelPainter oldDelegate) =>
      oldDelegate.animationProgress != animationProgress || oldDelegate.primaryColor != primaryColor;
}

// 2. Shodashvarga 16-Mosaic Geometric Mandala Painter
class ShodashvargaMosaicPainter extends CustomPainter {
  final double animationProgress;
  final Color primaryColor;

  ShodashvargaMosaicPainter({
    this.animationProgress = 1.0,
    this.primaryColor = const Color(0xFFD4AF37),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final glow = Paint()
      ..color = primaryColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final rect = Rect.fromLTWH(8, 8, size.width - 16, size.height - 16);
    canvas.drawRect(rect, glow);
    canvas.drawRect(rect, paint);

    // 4x4 Grid (16 Vargas)
    final cellW = rect.width / 4;
    final cellH = rect.height / 4;

    for (int i = 1; i < 4; i++) {
      // Vertical lines
      canvas.drawLine(
        Offset(rect.left + i * cellW, rect.top),
        Offset(rect.left + i * cellW, rect.bottom),
        paint,
      );
      // Horizontal lines
      canvas.drawLine(
        Offset(rect.left, rect.top + i * cellH),
        Offset(rect.right, rect.top + i * cellH),
        paint,
      );
    }

    // Diagonal Sacred Diamond Overlays
    final diamondPath = Path()
      ..moveTo(rect.center.dx, rect.top)
      ..lineTo(rect.right, rect.center.dy)
      ..lineTo(rect.center.dx, rect.bottom)
      ..lineTo(rect.left, rect.center.dy)
      ..close();
    canvas.drawPath(diamondPath, paint..strokeWidth = 1.0);

    // Central Bindu
    canvas.drawCircle(rect.center, 3.5, Paint()..color = primaryColor);
  }

  @override
  bool shouldRepaint(covariant ShodashvargaMosaicPainter oldDelegate) => true;
}

// 3. Sade Sati Orbit & Saturn Ring Painter
class SadeSatiOrbitPainter extends CustomPainter {
  final double orbitProgress;

  SadeSatiOrbitPainter({this.orbitProgress = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Orbit Ring (Golden Ellipse)
    final orbitPaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawOval(Rect.fromCenter(center: center, width: radius * 2.2, height: radius * 1.3), orbitPaint);

    // Moon at Focal Center
    final moonPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFCBD5E1), Color(0xFF64748B)],
      ).createShader(Rect.fromCircle(center: center, radius: 16));
    canvas.drawCircle(center, 16, moonPaint);

    // Saturn at Orbit Position
    final angle = orbitProgress * 2 * math.pi;
    final saturnX = center.dx + (radius * 1.1) * math.cos(angle);
    final saturnY = center.dy + (radius * 0.65) * math.sin(angle);
    final saturnCenter = Offset(saturnX, saturnY);

    // Saturn Glow
    canvas.drawCircle(
      saturnCenter,
      14,
      Paint()
        ..color = const Color(0xFFE2B04E).withOpacity(0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Saturn Body
    canvas.drawCircle(
      saturnCenter,
      9,
      Paint()..color = const Color(0xFFD4A373),
    );

    // Saturn's Iconic Rings
    final ringPaint = Paint()
      ..color = const Color(0xFFF3C68F).withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawOval(
      Rect.fromCenter(center: saturnCenter, width: 28, height: 10),
      ringPaint,
    );
  }

  @override
  bool shouldRepaint(covariant SadeSatiOrbitPainter oldDelegate) => true;
}

// 4. Kaal Sarp Cosmic Serpent Axis Painter
class KaalSarpSerpentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9333EA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final glow = Paint()
      ..color = const Color(0xFFC084FC).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final path = Path();
    path.moveTo(20, size.height * 0.7);
    path.cubicTo(
      size.width * 0.3, size.height * 0.1,
      size.width * 0.7, size.height * 0.9,
      size.width - 20, size.height * 0.3,
    );

    canvas.drawPath(path, glow);
    canvas.drawPath(path, paint);

    // Rahu Head Node
    final rahuPos = Offset(20, size.height * 0.7);
    canvas.drawCircle(rahuPos, 7, Paint()..color = const Color(0xFFE11D48));
    canvas.drawCircle(rahuPos, 3, Paint()..color = Colors.white);

    // Ketu Tail Node
    final ketuPos = Offset(size.width - 20, size.height * 0.3);
    canvas.drawCircle(ketuPos, 7, Paint()..color = const Color(0xFF3B82F6));
    canvas.drawCircle(ketuPos, 3, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant KaalSarpSerpentPainter oldDelegate) => false;
}

// 5. Gemstone Brilliant Crystal Facet Painter
class GemstoneFacetPainter extends CustomPainter {
  final Color stoneColor;

  GemstoneFacetPainter({this.stoneColor = const Color(0xFF10B981)});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final w = size.width * 0.35;
    final h = size.height * 0.35;

    // Facet Octagon Shape
    final octagon = Path()
      ..moveTo(center.dx - w * 0.5, center.dy - h)
      ..lineTo(center.dx + w * 0.5, center.dy - h)
      ..lineTo(center.dx + w, center.dy - h * 0.5)
      ..lineTo(center.dx + w, center.dy + h * 0.5)
      ..lineTo(center.dx + w * 0.5, center.dy + h)
      ..lineTo(center.dx - w * 0.5, center.dy + h)
      ..lineTo(center.dx - w, center.dy + h * 0.5)
      ..lineTo(center.dx - w, center.dy - h * 0.5)
      ..close();

    // Glow
    canvas.drawPath(
      octagon,
      Paint()
        ..color = stoneColor.withOpacity(0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    // Fill with Gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [stoneColor.withOpacity(0.9), stoneColor, stoneColor.withOpacity(0.6)],
      ).createShader(Rect.fromCenter(center: center, width: w * 2, height: h * 2));
    canvas.drawPath(octagon, fillPaint);

    // Facet Outline
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(octagon, linePaint);

    // Inner Facet Table
    final table = Path()
      ..moveTo(center.dx - w * 0.25, center.dy - h * 0.5)
      ..lineTo(center.dx + w * 0.25, center.dy - h * 0.5)
      ..lineTo(center.dx + w * 0.5, center.dy - h * 0.25)
      ..lineTo(center.dx + w * 0.5, center.dy + h * 0.25)
      ..lineTo(center.dx + w * 0.25, center.dy + h * 0.5)
      ..lineTo(center.dx - w * 0.25, center.dy + h * 0.5)
      ..lineTo(center.dx - w * 0.5, center.dy + h * 0.25)
      ..lineTo(center.dx - w * 0.5, center.dy - h * 0.25)
      ..close();
    canvas.drawPath(table, linePaint);
  }

  @override
  bool shouldRepaint(covariant GemstoneFacetPainter oldDelegate) => oldDelegate.stoneColor != stoneColor;
}
