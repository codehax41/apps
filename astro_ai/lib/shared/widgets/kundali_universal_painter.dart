// Universal Full-Fidelity Kundali Painter Supporting Exact North & South Indian Layouts from Reference Screenshots

import 'dart:math' as math;
import 'package:flutter/material.dart';

enum KundaliDivision { d1Lagna, d9Navamsa, d10Dasamsa }

class KundaliUniversalPainter extends CustomPainter {
  final KundaliDivision division;
  final bool isSouthIndian;
  final int selectedHouse;

  KundaliUniversalPainter({
    required this.division,
    required this.isSouthIndian,
    this.selectedHouse = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final boundaryPaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final gridLinePaint = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;

    final goldLinePaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    if (!isSouthIndian) {
      _paintNorthIndian(canvas, size, boundaryPaint, gridLinePaint, goldLinePaint);
    } else {
      _paintSouthIndian(canvas, size, boundaryPaint, gridLinePaint, goldLinePaint);
    }
  }

  void _paintNorthIndian(Canvas canvas, Size size, Paint boundary, Paint grid, Paint gold) {
    final w = size.width;
    final h = size.height;

    // Outer rounded/rect boundary
    final outerRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(8),
    );
    canvas.drawRRect(outerRRect, boundary);

    // Diagonals crossing the chart
    canvas.drawLine(const Offset(0, 0), Offset(w, h), grid);
    canvas.drawLine(Offset(w, 0), Offset(0, h), grid);

    // Central Diamond (House 1 - Tanu Bhava)
    final diamond = Path()
      ..moveTo(w / 2, 0)
      ..lineTo(w, h / 2)
      ..lineTo(w / 2, h)
      ..lineTo(0, h / 2)
      ..close();
    canvas.drawPath(diamond, gold);

    // Golden intersection vertices dots
    final dotPaint = Paint()..color = const Color(0xFFFFD700).withOpacity(0.8);
    final dotOffsets = [
      Offset(w / 2, 0), Offset(w, h / 2), Offset(w / 2, h), Offset(0, h / 2),
      Offset(w / 4, h / 4), Offset(w * 3 / 4, h / 4),
      Offset(w / 4, h * 3 / 4), Offset(w * 3 / 4, h * 3 / 4),
      Offset(w / 2, h / 2),
    ];
    for (final dot in dotOffsets) {
      canvas.drawCircle(dot, 1.8, dotPaint);
    }

    // 12 Life-Domain Labels (Exact to Screenshots 1, 2, 3)
    _drawLabel(canvas, "SELF", Offset(w * 0.50, h * 0.28));
    _drawLabel(canvas, "WEALTH", Offset(w * 0.28, h * 0.08));
    _drawLabel(canvas, "TRAVEL", Offset(w * 0.72, h * 0.08));
    _drawLabel(canvas, "COURAGE", Offset(w * 0.12, h * 0.28));
    _drawLabel(canvas, "HOME", Offset(w * 0.30, h * 0.50));
    _drawLabel(canvas, "CAREER", Offset(w * 0.70, h * 0.50));
    _drawLabel(canvas, "DESIRES", Offset(w * 0.88, h * 0.28));
    _drawLabel(canvas, "MARRIAGE", Offset(w * 0.50, h * 0.72));
    _drawLabel(canvas, "ENEMIES", Offset(w * 0.28, h * 0.92));
    _drawLabel(canvas, "LONGEVITY", Offset(w * 0.72, h * 0.92));
    _drawLabel(canvas, "CHILDREN", Offset(w * 0.12, h * 0.72));
    _drawLabel(canvas, "FORTUNE", Offset(w * 0.88, h * 0.72));

    // House Zodiac Numbers for Libra Lagna (Libra = 7 in 1st house, etc.)
    _drawHouseNum(canvas, "7", Offset(w * 0.50, h * 0.46));
    _drawHouseNum(canvas, "8", Offset(w * 0.29, h * 0.24));
    _drawHouseNum(canvas, "9", Offset(w * 0.27, h * 0.26));
    _drawHouseNum(canvas, "10", Offset(w * 0.46, h * 0.50));
    _drawHouseNum(canvas, "11", Offset(w * 0.26, h * 0.74));
    _drawHouseNum(canvas, "12", Offset(w * 0.28, h * 0.76));
    _drawHouseNum(canvas, "1", Offset(w * 0.50, h * 0.54));
    _drawHouseNum(canvas, "2", Offset(w * 0.71, h * 0.76));
    _drawHouseNum(canvas, "3", Offset(w * 0.73, h * 0.74));
    _drawHouseNum(canvas, "4", Offset(w * 0.54, h * 0.50));
    _drawHouseNum(canvas, "5", Offset(w * 0.74, h * 0.26));
    _drawHouseNum(canvas, "6", Offset(w * 0.71, h * 0.24));

    // Divisional Planetary Nodes (Exact to Screenshots 1, 2, 3)
    switch (division) {
      case KundaliDivision.d1Lagna:
        // House 3 (9): MO, JU
        _drawPlanetSphere(canvas, "MO", const Color(0xFFCAD5E2), const Color(0xFF64748B), Offset(w * 0.16, h * 0.20));
        _drawPlanetSphere(canvas, "JU", const Color(0xFFFDE047), const Color(0xFFCA8A04), Offset(w * 0.23, h * 0.20));
        // House 6 (12): SA, KE
        _drawPlanetSphere(canvas, "SA", const Color(0xFFD4A373), const Color(0xFFA98467), Offset(w * 0.25, h * 0.85), hasRings: true);
        _drawPlanetSphere(canvas, "KE", const Color(0xFFFB923C), const Color(0xFF9A3412), Offset(w * 0.32, h * 0.85));
        // House 9 (3): MA, VE
        _drawPlanetSphere(canvas, "MA", const Color(0xFFEF4444), const Color(0xFF991B1B), Offset(w * 0.78, h * 0.82));
        _drawPlanetSphere(canvas, "VE", const Color(0xFFFEF08A), const Color(0xFFEAB308), Offset(w * 0.85, h * 0.82));
        // House 11 (5): SU
        _drawPlanetSphere(canvas, "SU", const Color(0xFFFDBA74), const Color(0xFFEA580C), Offset(w * 0.81, h * 0.20));
        // House 12 (6): ME, RA
        _drawPlanetSphere(canvas, "ME", const Color(0xFF38BDF8), const Color(0xFF0369A1), Offset(w * 0.69, h * 0.05));
        _drawPlanetSphere(canvas, "RA", const Color(0xFF818CF8), const Color(0xFF312E81), Offset(w * 0.76, h * 0.05));
        break;

      case KundaliDivision.d9Navamsa:
        // House 1 (7): SA
        _drawPlanetSphere(canvas, "SA", const Color(0xFFD4A373), const Color(0xFFA98467), Offset(w * 0.50, h * 0.34), hasRings: true);
        // House 2 (8): KE
        _drawPlanetSphere(canvas, "KE", const Color(0xFFFB923C), const Color(0xFF9A3412), Offset(w * 0.28, h * 0.15));
        // House 5 (11): ME
        _drawPlanetSphere(canvas, "ME", const Color(0xFF38BDF8), const Color(0xFF0369A1), Offset(w * 0.19, h * 0.79));
        // House 7 (1): VE
        _drawPlanetSphere(canvas, "VE", const Color(0xFFFEF08A), const Color(0xFFEAB308), Offset(w * 0.50, h * 0.80));
        // House 8 (2): MA, RA
        _drawPlanetSphere(canvas, "MA", const Color(0xFFEF4444), const Color(0xFF991B1B), Offset(w * 0.68, h * 0.85));
        _drawPlanetSphere(canvas, "RA", const Color(0xFF818CF8), const Color(0xFF312E81), Offset(w * 0.75, h * 0.85));
        // House 9 (3): SU
        _drawPlanetSphere(canvas, "SU", const Color(0xFFFDBA74), const Color(0xFFEA580C), Offset(w * 0.81, h * 0.82));
        // House 11 (5): JU
        _drawPlanetSphere(canvas, "JU", const Color(0xFFFDE047), const Color(0xFFCA8A04), Offset(w * 0.81, h * 0.20));
        // House 12 (6): MO
        _drawPlanetSphere(canvas, "MO", const Color(0xFFCAD5E2), const Color(0xFF64748B), Offset(w * 0.72, h * 0.05));
        break;

      case KundaliDivision.d10Dasamsa:
        // House 1 (7): SU, RA
        _drawPlanetSphere(canvas, "SU", const Color(0xFFFDBA74), const Color(0xFFEA580C), Offset(w * 0.47, h * 0.34));
        _drawPlanetSphere(canvas, "RA", const Color(0xFF818CF8), const Color(0xFF312E81), Offset(w * 0.53, h * 0.34));
        // House 4 (10): VE
        _drawPlanetSphere(canvas, "VE", const Color(0xFFFEF08A), const Color(0xFFEAB308), Offset(w * 0.30, h * 0.58));
        // House 5 (11): MA
        _drawPlanetSphere(canvas, "MA", const Color(0xFFEF4444), const Color(0xFF991B1B), Offset(w * 0.19, h * 0.79));
        // House 6 (12): SA
        _drawPlanetSphere(canvas, "SA", const Color(0xFFD4A373), const Color(0xFFA98467), Offset(w * 0.28, h * 0.85), hasRings: true);
        // House 7 (1): JU, KE
        _drawPlanetSphere(canvas, "JU", const Color(0xFFFDE047), const Color(0xFFCA8A04), Offset(w * 0.47, h * 0.80));
        _drawPlanetSphere(canvas, "KE", const Color(0xFFFB923C), const Color(0xFF9A3412), Offset(w * 0.53, h * 0.80));
        // House 9 (3): MO, ME
        _drawPlanetSphere(canvas, "MO", const Color(0xFFCAD5E2), const Color(0xFF64748B), Offset(w * 0.78, h * 0.82));
        _drawPlanetSphere(canvas, "ME", const Color(0xFF38BDF8), const Color(0xFF0369A1), Offset(w * 0.85, h * 0.82));
        break;
    }
  }

  void _paintSouthIndian(Canvas canvas, Size size, Paint boundary, Paint grid, Paint gold) {
    final w = size.width;
    final h = size.height;

    // Outer boundary with slight rounding
    final outerRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(8),
    );
    canvas.drawRRect(outerRRect, boundary);

    final colW = w / 4.0;
    final rowH = h / 4.0;

    // 4x4 Grid Lines
    for (int i = 1; i < 4; i++) {
      canvas.drawLine(Offset(colW * i, 0), Offset(colW * i, h), grid);
      canvas.drawLine(Offset(0, rowH * i), Offset(w, rowH * i), grid);
    }

    // Hollow Center 2x2 Square
    final centerRect = Rect.fromLTWH(colW, rowH, colW * 2, rowH * 2);
    canvas.drawRect(centerRect, Paint()..color = const Color(0xFF080612));
    canvas.drawRect(centerRect, gold);

    // Grid intersection dots
    final dotPaint = Paint()..color = const Color(0xFFFFD700).withOpacity(0.7);
    for (int r = 1; r < 4; r++) {
      for (int c = 1; c < 4; c++) {
        canvas.drawCircle(Offset(colW * c, rowH * r), 1.5, dotPaint);
      }
    }

    // Exact 12 Boxes Map (Screenshots 4 & 5)
    final Map<int, Offset> boxCenters = {
      12: Offset(colW * 0.5, rowH * 0.5), // Top row 0, col 0 (HOME 12)
      1: Offset(colW * 1.5, rowH * 0.5),  // Top row 0, col 1 (CHILDREN 1)
      2: Offset(colW * 2.5, rowH * 0.5),  // Top row 0, col 2 (ENEMIES 2)
      3: Offset(colW * 3.5, rowH * 0.5),  // Top row 0, col 3 (MARRIAGE 3)
      4: Offset(colW * 3.5, rowH * 1.5),  // Col 3, row 1 (LONGEVITY 4)
      5: Offset(colW * 3.5, rowH * 2.5),  // Col 3, row 2 (FORTUNE 5)
      6: Offset(colW * 3.5, rowH * 3.5),  // Col 3, row 3 (CAREER 6)
      7: Offset(colW * 2.5, rowH * 3.5),  // Row 3, col 2 (DESIRES 7)
      8: Offset(colW * 1.5, rowH * 3.5),  // Row 3, col 1 (TRAVEL 8)
      9: Offset(colW * 0.5, rowH * 3.5),  // Row 3, col 0 (SELF 9 - LAGNA)
      10: Offset(colW * 0.5, rowH * 2.5), // Row 2, col 0 (WEALTH 10)
      11: Offset(colW * 0.5, rowH * 1.5), // Row 1, col 0 (COURAGE 11)
    };

    // Draw Domains in South Indian Format
    _drawSouthDomain(canvas, "HOME", "12", boxCenters[12]!, false);
    _drawSouthDomain(canvas, "CHILDREN", "1", boxCenters[1]!, false);
    _drawSouthDomain(canvas, "ENEMIES", "2", boxCenters[2]!, false);
    _drawSouthDomain(canvas, "MARRIAGE", "3", boxCenters[3]!, false);
    _drawSouthDomain(canvas, "LONGEVITY", "4", boxCenters[4]!, false);
    _drawSouthDomain(canvas, "FORTUNE", "5", boxCenters[5]!, false);
    _drawSouthDomain(canvas, "CAREER", "6", boxCenters[6]!, false);
    _drawSouthDomain(canvas, "DESIRES", "7", boxCenters[7]!, false);
    _drawSouthDomain(canvas, "TRAVEL", "8", boxCenters[8]!, false);
    _drawSouthDomain(canvas, "SELF", "9", boxCenters[9]!, true); // Gold accent on Self (Lagna)
    _drawSouthDomain(canvas, "WEALTH", "10", boxCenters[10]!, false);
    _drawSouthDomain(canvas, "COURAGE", "11", boxCenters[11]!, false);

    // Draw Planets in South Indian Mode
    switch (division) {
      case KundaliDivision.d1Lagna:
        _drawPlanetSphere(canvas, "SA", const Color(0xFFD4A373), const Color(0xFFA98467), boxCenters[12]! + const Offset(-9, -10), hasRings: true);
        _drawPlanetSphere(canvas, "KE", const Color(0xFFFB923C), const Color(0xFF9A3412), boxCenters[12]! + const Offset(9, -10));
        _drawPlanetSphere(canvas, "MO", const Color(0xFFCAD5E2), const Color(0xFF64748B), boxCenters[9]! + const Offset(-9, -10));
        _drawPlanetSphere(canvas, "JU", const Color(0xFFFDE047), const Color(0xFFCA8A04), boxCenters[9]! + const Offset(9, -10));
        _drawPlanetSphere(canvas, "MA", const Color(0xFFEF4444), const Color(0xFF991B1B), boxCenters[3]! + const Offset(-9, -10));
        _drawPlanetSphere(canvas, "VE", const Color(0xFFFEF08A), const Color(0xFFEAB308), boxCenters[3]! + const Offset(9, -10));
        _drawPlanetSphere(canvas, "SU", const Color(0xFFFDBA74), const Color(0xFFEA580C), boxCenters[5]! + const Offset(0, -10));
        _drawPlanetSphere(canvas, "ME", const Color(0xFF38BDF8), const Color(0xFF0369A1), boxCenters[6]! + const Offset(-9, -10));
        _drawPlanetSphere(canvas, "RA", const Color(0xFF818CF8), const Color(0xFF312E81), boxCenters[6]! + const Offset(9, -10));
        break;

      case KundaliDivision.d9Navamsa:
        // Match Reference Image 5
        _drawPlanetSphere(canvas, "VE", const Color(0xFFFEF08A), const Color(0xFFEAB308), boxCenters[1]! + const Offset(0, -10));
        _drawPlanetSphere(canvas, "MA", const Color(0xFFEF4444), const Color(0xFF991B1B), boxCenters[2]! + const Offset(-9, -10));
        _drawPlanetSphere(canvas, "RA", const Color(0xFF818CF8), const Color(0xFF312E81), boxCenters[2]! + const Offset(9, -10));
        _drawPlanetSphere(canvas, "SU", const Color(0xFFFDBA74), const Color(0xFFEA580C), boxCenters[3]! + const Offset(0, -10));
        _drawPlanetSphere(canvas, "JU", const Color(0xFFFDE047), const Color(0xFFCA8A04), boxCenters[5]! + const Offset(0, -10));
        _drawPlanetSphere(canvas, "MO", const Color(0xFFCAD5E2), const Color(0xFF64748B), boxCenters[6]! + const Offset(0, -10));
        _drawPlanetSphere(canvas, "SA", const Color(0xFFD4A373), const Color(0xFFA98467), boxCenters[7]! + const Offset(0, -10), hasRings: true);
        _drawPlanetSphere(canvas, "KE", const Color(0xFFFB923C), const Color(0xFF9A3412), boxCenters[8]! + const Offset(0, -10));
        _drawPlanetSphere(canvas, "ME", const Color(0xFF38BDF8), const Color(0xFF0369A1), boxCenters[11]! + const Offset(0, -10));
        break;

      case KundaliDivision.d10Dasamsa:
        // Match Reference Image 4
        _drawPlanetSphere(canvas, "SA", const Color(0xFFD4A373), const Color(0xFFA98467), boxCenters[12]! + const Offset(0, -10), hasRings: true);
        _drawPlanetSphere(canvas, "JU", const Color(0xFFFDE047), const Color(0xFFCA8A04), boxCenters[1]! + const Offset(-9, -10));
        _drawPlanetSphere(canvas, "KE", const Color(0xFFFB923C), const Color(0xFF9A3412), boxCenters[1]! + const Offset(9, -10));
        _drawPlanetSphere(canvas, "MO", const Color(0xFFCAD5E2), const Color(0xFF64748B), boxCenters[3]! + const Offset(-9, -10));
        _drawPlanetSphere(canvas, "ME", const Color(0xFF38BDF8), const Color(0xFF0369A1), boxCenters[3]! + const Offset(9, -10));
        _drawPlanetSphere(canvas, "SU", const Color(0xFFFDBA74), const Color(0xFFEA580C), boxCenters[7]! + const Offset(-9, -10));
        _drawPlanetSphere(canvas, "RA", const Color(0xFF818CF8), const Color(0xFF312E81), boxCenters[7]! + const Offset(9, -10));
        _drawPlanetSphere(canvas, "VE", const Color(0xFFFEF08A), const Color(0xFFEAB308), boxCenters[10]! + const Offset(0, -10));
        _drawPlanetSphere(canvas, "MA", const Color(0xFFEF4444), const Color(0xFF991B1B), boxCenters[11]! + const Offset(0, -10));
        break;
    }
  }

  void _drawSouthDomain(Canvas canvas, String domain, String num, Offset center, bool isLagna) {
    final tpDomain = TextPainter(
      text: TextSpan(
        text: domain,
        style: TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 6.8,
          letterSpacing: 0.5,
          fontWeight: FontWeight.bold,
          color: isLagna ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.42),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tpDomain.paint(canvas, Offset(center.dx - tpDomain.width / 2, center.dy + 12));

    final tpNum = TextPainter(
      text: TextSpan(
        text: num,
        style: TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 6.2,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.32),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tpNum.paint(canvas, Offset(center.dx + 16, center.dy + 12));
  }

  void _drawLabel(Canvas canvas, String label, Offset center) {
    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 7.2,
          letterSpacing: 0.8,
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.45),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  void _drawHouseNum(Canvas canvas, String num, Offset center) {
    final tp = TextPainter(
      text: TextSpan(
        text: num,
        style: TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 6.8,
          color: Colors.white.withOpacity(0.38),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  void _drawPlanetSphere(Canvas canvas, String glyph, Color lightColor, Color darkColor, Offset center, {bool hasRings = false}) {
    const double radius = 6.5;

    // Atmospheric outer soft glow
    final glow = Paint()
      ..color = lightColor.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center, radius + 2, glow);

    // 3D Spherical Radial Gradient
    final sphereRect = Rect.fromCircle(center: center, radius: radius);
    final spherePaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.35, -0.35),
        radius: 0.85,
        colors: [Colors.white, lightColor, darkColor],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(sphereRect);
    canvas.drawCircle(center, radius, spherePaint);

    // Specular Highlight Spot
    final specPaint = Paint()..color = Colors.white.withOpacity(0.85);
    canvas.drawCircle(center + const Offset(-2.0, -2.0), 1.2, specPaint);

    // Saturn's tilted planetary rings
    if (hasRings) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(-math.pi / 6.0);
      final ringPaint = Paint()
        ..color = const Color(0xFFFFE8B2).withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: radius * 3.0, height: radius * 1.1), ringPaint);
      canvas.restore();
    }

    // 2-Letter Planet Glyph Label
    final tp = TextPainter(
      text: TextSpan(
        text: glyph,
        style: const TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 6.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.3,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy + radius + 2.5));
  }

  @override
  bool shouldRepaint(covariant KundaliUniversalPainter oldDelegate) =>
      oldDelegate.division != division ||
      oldDelegate.isSouthIndian != isSouthIndian ||
      oldDelegate.selectedHouse != selectedHouse;
}

// Procedural 3D Golden Brass Libra Scales (Matches Exact Reference Screenshots)
class LibraScalesWidget extends StatelessWidget {
  final double width;
  final double height;
  const LibraScalesWidget({super.key, this.width = 110, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: LibraScalesPainter(),
      ),
    );
  }
}

class LibraScalesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Ambient warm golden glow behind scales
    final glowPaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawCircle(Offset(w * 0.55, h * 0.45), w * 0.45, glowPaint);

    // Central Pillar / Stem
    final pillarRect = Rect.fromLTWH(w * 0.52, h * 0.16, w * 0.05, h * 0.65);
    final pillarShader = const LinearGradient(
      colors: [
        Color(0xFFFFF2A3),
        Color(0xFFD4AF37),
        Color(0xFF8C6D23),
        Color(0xFFD4AF37),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(pillarRect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(pillarRect, const Radius.circular(2)),
      Paint()..shader = pillarShader,
    );

    // Top Cap / Finial Orb
    final topOrbRect = Rect.fromCircle(center: Offset(w * 0.545, h * 0.14), radius: w * 0.035);
    canvas.drawOval(
      topOrbRect,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.3, -0.3),
          colors: [Colors.white, Color(0xFFD4AF37), Color(0xFF5A4410)],
        ).createShader(topOrbRect),
    );

    // Tiered Pedestal Base
    final baseRect1 = Rect.fromCenter(center: Offset(w * 0.545, h * 0.84), width: w * 0.22, height: h * 0.04);
    canvas.drawOval(
      baseRect1,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFFFF2A3), Color(0xFFD4AF37), Color(0xFF5A4410)],
        ).createShader(baseRect1),
    );
    final baseRect2 = Rect.fromCenter(center: Offset(w * 0.545, h * 0.87), width: w * 0.32, height: h * 0.05);
    canvas.drawOval(
      baseRect2,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFFFF2A3), Color(0xFFC59E36), Color(0xFF4A380A)],
        ).createShader(baseRect2),
    );

    // Curved Balance Beam with slight dynamic angle
    final beamPath = Path();
    final pLeft = Offset(w * 0.18, h * 0.24);
    final pCenter = Offset(w * 0.545, h * 0.19);
    final pRight = Offset(w * 0.90, h * 0.23);

    beamPath.moveTo(pLeft.dx, pLeft.dy);
    beamPath.quadraticBezierTo(w * 0.36, h * 0.17, pCenter.dx, pCenter.dy);
    beamPath.quadraticBezierTo(w * 0.72, h * 0.17, pRight.dx, pRight.dy);

    final beamPaint = Paint()
      ..color = const Color(0xFFE5C07B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(beamPath, beamPaint);

    final beamHighlight = Paint()
      ..color = const Color(0xFFFFF7C2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(beamPath, beamHighlight);

    // Suspension Chains & Pans
    _drawPan(canvas, w, h, pLeft, panCenterY: h * 0.62, panWidth: w * 0.32);
    _drawPan(canvas, w, h, pRight, panCenterY: h * 0.52, panWidth: w * 0.32);
  }

  void _drawPan(Canvas canvas, double w, double h, Offset pivot, {required double panCenterY, required double panWidth}) {
    final chainPaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.85;

    // 3 Golden Suspension Chains
    canvas.drawLine(pivot, Offset(pivot.dx - panWidth * 0.42, panCenterY), chainPaint);
    canvas.drawLine(pivot, Offset(pivot.dx, panCenterY + 2), chainPaint);
    canvas.drawLine(pivot, Offset(pivot.dx + panWidth * 0.42, panCenterY), chainPaint);

    // Golden Curved Weighing Dish
    final dishRect = Rect.fromCenter(center: Offset(pivot.dx, panCenterY + 4), width: panWidth, height: h * 0.07);
    final dishShader = const LinearGradient(
      colors: [
        Color(0xFFFFF5B8),
        Color(0xFFE5C07B),
        Color(0xFF8C6D23),
        Color(0xFFD4AF37),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(dishRect);

    final dishPath = Path()
      ..moveTo(pivot.dx - panWidth * 0.48, panCenterY)
      ..quadraticBezierTo(pivot.dx, panCenterY + h * 0.08, pivot.dx + panWidth * 0.48, panCenterY)
      ..close();

    canvas.drawPath(dishPath, Paint()..shader = dishShader);

    // Dish Rim Specular Line
    final rimPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;
    canvas.drawLine(Offset(pivot.dx - panWidth * 0.46, panCenterY), Offset(pivot.dx + panWidth * 0.46, panCenterY), rimPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Procedural Sun / Moon Medallion Painter for Header Badges
class CelestialMedallionPainter extends CustomPainter {
  final bool isSun;
  CelestialMedallionPainter({required this.isSun});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    if (isSun) {
      // Golden Concentric Solar Disc
      final outerRing = Paint()
        ..color = const Color(0xFFFFD700).withOpacity(0.75)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(center, r * 0.85, outerRing);

      final innerRing = Paint()
        ..color = const Color(0xFFFFD700).withOpacity(0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9;
      canvas.drawCircle(center, r * 0.55, innerRing);

      final corePaint = Paint()
        ..shader = const RadialGradient(
          colors: [Color(0xFFFFF2A3), Color(0xFFF59E0B)],
        ).createShader(Rect.fromCircle(center: center, radius: r * 0.35));
      canvas.drawCircle(center, r * 0.35, corePaint);
    } else {
      // Golden Crescent Moon
      final moonPaint = Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFFFF2A3), Color(0xFFD4AF37)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromCircle(center: center, radius: r * 0.85));

      final moonPath = Path()
        ..addArc(Rect.fromCircle(center: center, radius: r * 0.75), -math.pi / 2, math.pi)
        ..arcTo(Rect.fromCircle(center: Offset(center.dx + r * 0.28, center.dy), radius: r * 0.58), math.pi / 2, -math.pi, false)
        ..close();

      canvas.drawPath(moonPath, moonPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CelestialMedallionPainter oldDelegate) => oldDelegate.isSun != isSun;
}
