// lib/shared/widgets/daily_guidance_3d_painters.dart
// Procedural 3D Golden Diya (Oil Lamp) & Lord Ganesha Idol Painters for Screen 09 Daily Guidance

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 3D Illuminated Golden Diya (Oil Lamp) with burning divine flame
class GoldenDiya3DWidget extends StatelessWidget {
  final double width;
  final double height;
  const GoldenDiya3DWidget({super.key, this.width = 160, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: GoldenDiyaPainter(),
      ),
    );
  }
}

class GoldenDiyaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Ambient Warm Golden Divine Glow behind the Diya
    final ambientGlow = Paint()
      ..color = const Color(0xFFFFB703).withOpacity(0.20)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28);
    canvas.drawCircle(Offset(w * 0.45, h * 0.40), w * 0.40, ambientGlow);

    // 2. Brass Diya Bowl (Outer body)
    final bowlRect = Rect.fromLTWH(w * 0.22, h * 0.38, w * 0.64, h * 0.42);
    final bowlShader = const LinearGradient(
      colors: [
        Color(0xFFFFF2A3),
        Color(0xFFE5C07B),
        Color(0xFF8C6D23),
        Color(0xFFC59E36),
        Color(0xFF4A380A),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bowlRect);

    final bowlPath = Path()
      ..moveTo(w * 0.22, h * 0.48)
      ..quadraticBezierTo(w * 0.20, h * 0.78, w * 0.54, h * 0.80)
      ..quadraticBezierTo(w * 0.86, h * 0.78, w * 0.86, h * 0.48)
      ..quadraticBezierTo(w * 0.54, h * 0.54, w * 0.22, h * 0.48)
      ..close();

    canvas.drawPath(bowlPath, Paint()..shader = bowlShader);

    // Decorative Fluted Rim Embossing
    final rimRect = Rect.fromCenter(center: Offset(w * 0.54, h * 0.48), width: w * 0.65, height: h * 0.16);
    final rimShader = const LinearGradient(
      colors: [
        Color(0xFFFFF7C2),
        Color(0xFFD4AF37),
        Color(0xFF6B4E12),
        Color(0xFFFFF2A3),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(rimRect);

    final rimPaint = Paint()
      ..shader = rimShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawOval(rimRect, rimPaint);

    // 3. Pool of Warm Golden Oil (Interior Liquid)
    final oilRect = Rect.fromCenter(center: Offset(w * 0.54, h * 0.50), width: w * 0.52, height: h * 0.11);
    final oilShader = const RadialGradient(
      center: Alignment(-0.2, -0.2),
      radius: 0.85,
      colors: [
        Color(0xFFFFD166),
        Color(0xFFF59E0B),
        Color(0xFF92400E),
      ],
    ).createShader(oilRect);
    canvas.drawOval(oilRect, Paint()..shader = oilShader);

    // Oil Specular Gloss Line
    final oilGlossPaint = Paint()
      ..color = Colors.white.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.54, h * 0.49), width: w * 0.44, height: h * 0.08),
      math.pi * 0.1,
      math.pi * 0.8,
      false,
      oilGlossPaint,
    );

    // 4. Burning Divine Wick Flame (Left Beak)
    final flameCenterX = w * 0.29;
    final flameBaseY = h * 0.47;

    // Intense Flame Corona Glow
    final flameGlow = Paint()
      ..color = const Color(0xFFFF7A00).withOpacity(0.65)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawCircle(Offset(flameCenterX, flameBaseY - 18), 16, flameGlow);

    // Outer Orange/Gold Flame Teardrop
    final flameOuterPath = Path()
      ..moveTo(flameCenterX - 8, flameBaseY)
      ..cubicTo(
        flameCenterX - 10, flameBaseY - 16,
        flameCenterX - 6, flameBaseY - 34,
        flameCenterX + 1, flameBaseY - 44,
      )
      ..cubicTo(
        flameCenterX + 8, flameBaseY - 34,
        flameCenterX + 10, flameBaseY - 16,
        flameCenterX + 8, flameBaseY,
      )
      ..close();

    final flameOuterShader = const LinearGradient(
      colors: [
        Color(0xFFFF4800),
        Color(0xFFFF9E00),
        Color(0xFFFFD60A),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).createShader(Rect.fromLTWH(flameCenterX - 10, flameBaseY - 44, 20, 44));
    canvas.drawPath(flameOuterPath, Paint()..shader = flameOuterShader);

    // Inner White-Hot Flame Core
    final flameInnerPath = Path()
      ..moveTo(flameCenterX - 4, flameBaseY - 2)
      ..cubicTo(
        flameCenterX - 5, flameBaseY - 12,
        flameCenterX - 2, flameBaseY - 22,
        flameCenterX + 1, flameBaseY - 28,
      )
      ..cubicTo(
        flameCenterX + 4, flameBaseY - 22,
        flameCenterX + 5, flameBaseY - 12,
        flameCenterX + 4, flameBaseY - 2,
      )
      ..close();

    final flameInnerShader = const LinearGradient(
      colors: [
        Color(0xFFFFE600),
        Colors.white,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).createShader(Rect.fromLTWH(flameCenterX - 5, flameBaseY - 28, 10, 26));
    canvas.drawPath(flameInnerPath, Paint()..shader = flameInnerShader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 3D Golden Brass Lord Ganesha Idol Emblem for Mantra Card
class GaneshaIdol3DWidget extends StatelessWidget {
  final double width;
  final double height;
  const GaneshaIdol3DWidget({super.key, this.width = 85, this.height = 90});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: GaneshaIdolPainter(),
      ),
    );
  }
}

class GaneshaIdolPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Golden ambient drop aura
    final auraPaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(Offset(w * 0.50, h * 0.48), w * 0.40, auraPaint);

    final goldShader = const LinearGradient(
      colors: [
        Color(0xFFFFF7C2),
        Color(0xFFE5C07B),
        Color(0xFFC59E36),
        Color(0xFF6B4E12),
        Color(0xFFD4AF37),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    final goldPaint = Paint()..shader = goldShader;

    // 1. Ornate Tapered Crown (Mukuta)
    final crownPath = Path()
      ..moveTo(w * 0.32, h * 0.35)
      ..lineTo(w * 0.44, h * 0.08)
      ..lineTo(w * 0.52, h * 0.05)
      ..lineTo(w * 0.60, h * 0.08)
      ..lineTo(w * 0.72, h * 0.35)
      ..close();
    canvas.drawPath(crownPath, goldPaint);

    // Crown Finial Kalash
    canvas.drawCircle(Offset(w * 0.52, h * 0.05), w * 0.04, goldPaint);

    // Crown Band Details
    final rimPaint = Paint()
      ..color = const Color(0xFFFFF9D2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(w * 0.34, h * 0.33), Offset(w * 0.70, h * 0.33), rimPaint);
    canvas.drawLine(Offset(w * 0.38, h * 0.24), Offset(w * 0.66, h * 0.24), rimPaint);

    // 2. Majestic Elephant Ears
    // Left Ear
    final leftEar = Path()
      ..moveTo(w * 0.34, h * 0.38)
      ..quadraticBezierTo(w * 0.10, h * 0.35, w * 0.14, h * 0.55)
      ..quadraticBezierTo(w * 0.20, h * 0.68, w * 0.36, h * 0.60)
      ..close();
    canvas.drawPath(leftEar, goldPaint);

    // Right Ear
    final rightEar = Path()
      ..moveTo(w * 0.70, h * 0.38)
      ..quadraticBezierTo(w * 0.94, h * 0.35, w * 0.90, h * 0.55)
      ..quadraticBezierTo(w * 0.84, h * 0.68, w * 0.68, h * 0.60)
      ..close();
    canvas.drawPath(rightEar, goldPaint);

    // 3. Serene Head & Forehead with Tilak
    final headRect = Rect.fromCenter(center: Offset(w * 0.52, h * 0.46), width: w * 0.40, height: h * 0.32);
    canvas.drawOval(headRect, goldPaint);

    // Red Vermilion Tilak
    final tilakPaint = Paint()..color = const Color(0xFFDC2626);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.52, h * 0.38), width: 3.5, height: 7.0), const Radius.circular(2)),
      tilakPaint,
    );

    // 4. Graceful Curved Trunk (Vakratunda)
    final trunkPath = Path()
      ..moveTo(w * 0.46, h * 0.52)
      ..quadraticBezierTo(w * 0.47, h * 0.72, w * 0.54, h * 0.84)
      ..quadraticBezierTo(w * 0.64, h * 0.90, w * 0.68, h * 0.82)
      ..quadraticBezierTo(w * 0.68, h * 0.76, w * 0.62, h * 0.76)
      ..quadraticBezierTo(w * 0.55, h * 0.76, w * 0.52, h * 0.65)
      ..quadraticBezierTo(w * 0.54, h * 0.52, w * 0.56, h * 0.52)
      ..close();
    canvas.drawPath(trunkPath, goldPaint);

    // Specular Highlight on Trunk
    final trunkHighlight = Paint()
      ..color = Colors.white.withOpacity(0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.54, h * 0.75), width: w * 0.16, height: h * 0.18),
      math.pi * 0.3,
      math.pi * 0.6,
      false,
      trunkHighlight,
    );

    // Single Left Tusk (Ekadanta)
    final tuskPaint = Paint()..color = Colors.white;
    canvas.drawLine(Offset(w * 0.42, h * 0.56), Offset(w * 0.36, h * 0.60), tuskPaint..strokeWidth = 2.0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Dynamic Audio Waveform Visualizer for Mantra Player
class AudioWaveformVisualizer extends StatelessWidget {
  final bool isPlaying;
  const AudioWaveformVisualizer({super.key, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    final heights = [
      4.0, 7.0, 12.0, 16.0, 22.0, 14.0, 9.0, 18.0, 24.0, 17.0,
      11.0, 15.0, 20.0, 23.0, 16.0, 8.0, 13.0, 19.0, 11.0, 5.0
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(heights.length, (idx) {
        final baseH = heights[idx];
        return Container(
          width: 2.2,
          height: isPlaying ? baseH : (baseH * 0.4).clamp(3.0, 10.0),
          margin: const EdgeInsets.symmetric(horizontal: 1.4),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withOpacity(0.85),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

/// 3D Concentric Orbital Sphere Emblem for Personal Timings
class OrbitalPlanetSphereWidget extends StatelessWidget {
  final double size;
  const OrbitalPlanetSphereWidget({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _OrbitalPlanetSpherePainter(),
      ),
    );
  }
}

class _OrbitalPlanetSpherePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.65, size.height * 0.65);
    final r = size.width * 0.32;

    // Golden Outer Concentric Orbital Ring
    final ringPaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawCircle(center, r * 1.5, ringPaint);

    // 3D Metallic Golden Sphere
    final sphereRect = Rect.fromCircle(center: center, radius: r);
    final sphereShader = const RadialGradient(
      center: Alignment(-0.35, -0.35),
      radius: 0.9,
      colors: [
        Color(0xFFFFF9D2),
        Color(0xFFE5C07B),
        Color(0xFFC59E36),
        Color(0xFF5A4410),
      ],
      stops: [0.0, 0.35, 0.75, 1.0],
    ).createShader(sphereRect);

    canvas.drawCircle(center, r, Paint()..shader = sphereShader);

    // Specular Highlight Spot
    final spec = Paint()..color = Colors.white.withOpacity(0.85);
    canvas.drawCircle(center + Offset(-r * 0.35, -r * 0.35), r * 0.22, spec);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


/// 3D Golden Brass Puja Thali with Diya, Agarbatti, and Marigold Flowers
class GoldenPujaThali3DWidget extends StatelessWidget {
  final double width;
  final double height;
  const GoldenPujaThali3DWidget({super.key, this.width = 100, this.height = 65});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: GoldenPujaThaliPainter(),
      ),
    );
  }
}

class GoldenPujaThaliPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Ambient warm golden glow
    final glow = Paint()
      ..color = const Color(0xFFFFB703).withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.55, h * 0.65), width: w * 0.85, height: h * 0.55), glow);

    // Brass Thali Plate (Circular dish in perspective)
    final plateRect = Rect.fromCenter(center: Offset(w * 0.55, h * 0.65), width: w * 0.82, height: h * 0.48);
    final plateShader = const LinearGradient(
      colors: [
        Color(0xFFFFF7C2),
        Color(0xFFE5C07B),
        Color(0xFFC59E36),
        Color(0xFF6B4E12),
        Color(0xFFD4AF37),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(plateRect);

    canvas.drawOval(plateRect, Paint()..shader = plateShader);

    // Rim embossing line
    final rimPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawOval(plateRect, rimPaint);

    // Mini Brass Diya on the Thali (Left side)
    final diyaRect = Rect.fromCenter(center: Offset(w * 0.35, h * 0.62), width: w * 0.22, height: h * 0.20);
    final diyaShader = const RadialGradient(
      colors: [Color(0xFFFFF2A3), Color(0xFFD4AF37), Color(0xFF78350F)],
    ).createShader(diyaRect);
    canvas.drawOval(diyaRect, Paint()..shader = diyaShader);

    // Diya Flame
    final flamePaint = Paint()
      ..color = const Color(0xFFFF9E00)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(Offset(w * 0.35, h * 0.50), 4.5, flamePaint);
    canvas.drawCircle(Offset(w * 0.35, h * 0.50), 2.5, Paint()..color = Colors.white);

    // Marigold Flowers (Genda Phool - Orange & Yellow Orbs on Right)
    final flowerPaint1 = Paint()..color = const Color(0xFFF97316);
    canvas.drawCircle(Offset(w * 0.72, h * 0.62), 6.5, flowerPaint1);
    final flowerPaint2 = Paint()..color = const Color(0xFFFBBF24);
    canvas.drawCircle(Offset(w * 0.82, h * 0.65), 5.5, flowerPaint2);

    // Incense Sticks (Agarbatti) Rising with subtle smoke
    final stickPaint = Paint()
      ..color = const Color(0xFF78350F)
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(w * 0.60, h * 0.65), Offset(w * 0.62, h * 0.20), stickPaint);
    canvas.drawLine(Offset(w * 0.62, h * 0.65), Offset(w * 0.68, h * 0.22), stickPaint);

    // Incense Smoke trail
    final smokePaint = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    final smokePath = Path()
      ..moveTo(w * 0.62, h * 0.20)
      ..quadraticBezierTo(w * 0.60, h * 0.12, w * 0.65, h * 0.05);
    canvas.drawPath(smokePath, smokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 3D Golden Bow & Arrow Widget for Vijayadashami
class GoldenBowArrowWidget extends StatelessWidget {
  final double size;
  const GoldenBowArrowWidget({super.key, this.size = 28});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: GoldenBowArrowPainter(),
      ),
    );
  }
}

class GoldenBowArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bowPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Curved Bow Arc
    final bowPath = Path()
      ..moveTo(w * 0.15, h * 0.85)
      ..quadraticBezierTo(w * 0.90, h * 0.90, w * 0.85, h * 0.15);
    canvas.drawPath(bowPath, bowPaint);

    // Bow String
    final stringPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;
    canvas.drawLine(Offset(w * 0.15, h * 0.85), Offset(w * 0.85, h * 0.15), stringPaint);

    // Arrow Shaft & Head
    final arrowPaint = Paint()
      ..color = const Color(0xFFFFF2A3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawLine(Offset(w * 0.10, h * 0.10), Offset(w * 0.70, h * 0.70), arrowPaint);

    final tipPath = Path()
      ..moveTo(w * 0.05, h * 0.05)
      ..lineTo(w * 0.18, h * 0.08)
      ..lineTo(w * 0.08, h * 0.18)
      ..close();
    canvas.drawPath(tipPath, Paint()..color = const Color(0xFFFFD700));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 3D Golden Muscle / Flexed Bicep Widget (Physical Energy)
class GoldenMuscleArmWidget extends StatelessWidget {
  final double size;
  const GoldenMuscleArmWidget({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: GoldenMuscleArmPainter(),
      ),
    );
  }
}

class GoldenMuscleArmPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final goldShader = const LinearGradient(
      colors: [
        Color(0xFFFFF7C2),
        Color(0xFFE5C07B),
        Color(0xFFC59E36),
        Color(0xFF8C6D23),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    final paint = Paint()..shader = goldShader;

    // Muscular Arm Contours
    final armPath = Path()
      ..moveTo(w * 0.20, h * 0.75)
      ..quadraticBezierTo(w * 0.10, h * 0.50, w * 0.28, h * 0.35)
      ..quadraticBezierTo(w * 0.45, h * 0.15, w * 0.65, h * 0.25) // Bicep peak
      ..quadraticBezierTo(w * 0.85, h * 0.35, w * 0.80, h * 0.55) // Forearm
      ..quadraticBezierTo(w * 0.75, h * 0.70, w * 0.55, h * 0.70)
      ..quadraticBezierTo(w * 0.40, h * 0.85, w * 0.20, h * 0.75)
      ..close();

    canvas.drawPath(armPath, paint);

    // Specular Highlight line on bicep crest
    final highlight = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.55, h * 0.30), width: w * 0.35, height: h * 0.25),
      math.pi * 0.8,
      math.pi * 0.8,
      false,
      highlight,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 3D Golden Comedy & Tragedy Drama Masks Widget (Emotional Energy)
class GoldenDramaMasksWidget extends StatelessWidget {
  final double size;
  const GoldenDramaMasksWidget({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: GoldenDramaMasksPainter(),
      ),
    );
  }
}

class GoldenDramaMasksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final goldShader = const LinearGradient(
      colors: [
        Color(0xFFFFF7C2),
        Color(0xFFE5C07B),
        Color(0xFFC59E36),
        Color(0xFF6B4E12),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    final paint = Paint()..shader = goldShader;

    // Mask 1 (Smiling Face - Left)
    final mask1 = Path()
      ..addOval(Rect.fromCenter(center: Offset(w * 0.40, h * 0.50), width: w * 0.55, height: h * 0.65));
    canvas.drawPath(mask1, paint);

    // Mask 1 Features (Eyes & Smile)
    final featurePaint = Paint()..color = const Color(0xFF1E1708);
    canvas.drawCircle(Offset(w * 0.30, h * 0.44), 2.2, featurePaint);
    canvas.drawCircle(Offset(w * 0.48, h * 0.44), 2.2, featurePaint);

    final smilePaint = Paint()
      ..color = const Color(0xFF1E1708)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.39, h * 0.58), width: 14, height: 8), 0.1, math.pi * 0.8, false, smilePaint);

    // Mask 2 (Tragedy Mask - Overlapping Right Behind)
    final mask2 = Path()
      ..addOval(Rect.fromCenter(center: Offset(w * 0.68, h * 0.55), width: w * 0.45, height: h * 0.55));
    canvas.drawPath(mask2, paint);

    canvas.drawCircle(Offset(w * 0.62, h * 0.52), 1.8, featurePaint);
    canvas.drawCircle(Offset(w * 0.76, h * 0.52), 1.8, featurePaint);

    final frownPaint = Paint()
      ..color = const Color(0xFF1E1708)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.69, h * 0.68), width: 10, height: 6), math.pi, math.pi * 0.8, false, frownPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 3D Golden Brain Sculpture Widget (Mind Energy)
class GoldenBrainWidget extends StatelessWidget {
  final double size;
  const GoldenBrainWidget({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: GoldenBrainPainter(),
      ),
    );
  }
}

class GoldenBrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final goldShader = const LinearGradient(
      colors: [
        Color(0xFFFFF7C2),
        Color(0xFFE5C07B),
        Color(0xFFC59E36),
        Color(0xFF8C6D23),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    final paint = Paint()..shader = goldShader;

    // Left Hemisphere & Right Hemisphere
    final brainRect = Rect.fromCenter(center: Offset(w * 0.50, h * 0.50), width: w * 0.72, height: h * 0.64);
    canvas.drawOval(brainRect, paint);

    // Sulci / Gyri Convolution lines
    final linePaint = Paint()
      ..color = const Color(0xFF5A4410).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawLine(Offset(w * 0.50, h * 0.22), Offset(w * 0.50, h * 0.78), linePaint);

    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.38, h * 0.40), width: 12, height: 10), 0, math.pi * 1.4, false, linePaint);
    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.38, h * 0.60), width: 14, height: 10), 0.5, math.pi * 1.2, false, linePaint);
    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.62, h * 0.40), width: 12, height: 10), math.pi, math.pi * 1.4, false, linePaint);
    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.62, h * 0.60), width: 14, height: 10), math.pi * 0.5, math.pi * 1.2, false, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 3D Golden Twin Hearts Widget for Kundali Milan (Screen 14)
class GoldenTwinHearts3DWidget extends StatelessWidget {
  final double width;
  final double height;
  const GoldenTwinHearts3DWidget({super.key, this.width = 110, this.height = 95});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: GoldenTwinHeartsPainter(),
      ),
    );
  }
}

class GoldenTwinHeartsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Ambient warm golden glow
    final glow = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawCircle(Offset(w * 0.55, h * 0.48), w * 0.40, glow);

    final goldShader = const LinearGradient(
      colors: [
        Color(0xFFFFF9D2),
        Color(0xFFE5C07B),
        Color(0xFFC59E36),
        Color(0xFF6B4E12),
        Color(0xFFD4AF37),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    final heartPaint = Paint()..shader = goldShader;

    // Left Primary Embossed Heart
    _drawHeart(canvas, Offset(w * 0.38, h * 0.48), scale: w * 0.38, paint: heartPaint);

    // Right Intertwined Heart
    _drawHeart(canvas, Offset(w * 0.68, h * 0.38), scale: w * 0.34, paint: heartPaint);
  }

  void _drawHeart(Canvas canvas, Offset center, {required double scale, required Paint paint}) {
    final path = Path();
    path.moveTo(center.dx, center.dy + scale * 0.55);
    path.cubicTo(
      center.dx - scale * 0.70, center.dy + scale * 0.10,
      center.dx - scale * 0.70, center.dy - scale * 0.55,
      center.dx, center.dy - scale * 0.25,
    );
    path.cubicTo(
      center.dx + scale * 0.70, center.dy - scale * 0.55,
      center.dx + scale * 0.70, center.dy + scale * 0.10,
      center.dx, center.dy + scale * 0.55,
    );
    path.close();

    canvas.drawPath(path, paint);

    // Delicate Filigree Highlight Rim
    final rimPaint = Paint()
      ..color = Colors.white.withOpacity(0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(path, rimPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
