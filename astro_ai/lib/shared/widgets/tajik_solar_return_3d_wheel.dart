// lib/shared/widgets/tajik_solar_return_3d_wheel.dart
// ASTROAI OS v4.2 - 3D Movable Geometric Tajik Solar Return Astrolabe
// Direct 1:1 Implementation matching Screenshot (media_1792533988974_743a125a.jpg)
// Features: Full 3D touch tilt (Pitch, Yaw, Roll), momentum inertia spin,
// multi-layer metallic brass rings, 12 Tajik planetary gems, and glowing purple solar core.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TajikSolarReturn3DWheelWidget extends StatefulWidget {
  final double size;
  final String title;

  const TajikSolarReturn3DWheelWidget({
    super.key,
    this.size = 280,
    this.title = "VARSHPHAL (ANNUAL SOLAR RETURN)",
  });

  @override
  State<TajikSolarReturn3DWheelWidget> createState() => _TajikSolarReturn3DWheelWidgetState();
}

class _TajikSolarReturn3DWheelWidgetState extends State<TajikSolarReturn3DWheelWidget>
    with TickerProviderStateMixin {
  late AnimationController _idleSpinController;
  late AnimationController _resetController;

  // 3D Perspective Angles (in radians)
  double _tiltX = 0.0; // Pitch: -0.55 to 0.55
  double _tiltY = 0.0; // Yaw: -0.55 to 0.55
  double _spinZ = 0.0; // Roll / Wheel rotation
  final double _scale = 1.0;

  // Inertia and Momentum Physics
  bool _isInteracting = false;

  late Animation<double> _resetAnimX;
  late Animation<double> _resetAnimY;

  @override
  void initState() {
    super.initState();

    // Idle slow celestial rotation (45s per revolution)
    _idleSpinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 45),
    )..addListener(() {
        if (!_isInteracting) {
          setState(() {
            _spinZ += 0.003;
          });
        }
      })
      ..repeat();

    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _idleSpinController.dispose();
    _resetController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _isInteracting = true;
    if (_resetController.isAnimating) {
      _resetController.stop();
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {

      // 3D Tilt calculation (Yaw on X drag, Pitch on Y drag)
      _tiltY = (_tiltY + details.delta.dx * 0.007).clamp(-0.50, 0.50);
      _tiltX = (_tiltX - details.delta.dy * 0.007).clamp(-0.50, 0.50);

      // Rotational torque on wheel
      _spinZ += (details.delta.dx + details.delta.dy) * 0.006;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _isInteracting = false;
    HapticFeedback.selectionClick();
  }

  void _resetToCenter() {
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
    // 3D Transform Matrix with perspective projection
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.0018) // Perspective factor
      ..rotateX(_tiltX)
      ..rotateY(_tiltY)
      ..scale(_scale);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF13121A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            onDoubleTap: _resetToCenter,
            child: Transform(
              alignment: Alignment.center,
              transform: transform,
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 1. Interactive 3D Tajik Geometric Canvas
                    CustomPaint(
                      size: Size(widget.size, widget.size),
                      painter: TajikAstrolabe3DPainter(
                        spinAngle: _spinZ,
                        tiltX: _tiltX,
                        tiltY: _tiltY,
                      ),
                    ),

                    // 2. Center Solar Return Title Overlay
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Color(0xFFC084FC),
                              blurRadius: 14,
                            ),
                            Shadow(
                              color: Colors.black,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Touch hint
          Text(
            "DRAG TO ROTATE IN 3D • DOUBLE TAP TO RESET",
            style: TextStyle(
              fontFamily: 'Space Mono',
              fontSize: 8.5,
              letterSpacing: 1.2,
              color: const Color(0xFFD4AF37).withOpacity(0.55),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom 3D Painter rendering the multi-layered Tajik Astrolabe Solar Return Wheel
class TajikAstrolabe3DPainter extends CustomPainter {
  final double spinAngle;
  final double tiltX;
  final double tiltY;

  TajikAstrolabe3DPainter({
    required this.spinAngle,
    required this.tiltX,
    required this.tiltY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width * 0.44;

    // 1. Dynamic Parallax Shading based on 3D Tilt

    // 2. Central Radiant Purple Solar Core (Pulsing Glow)
    final double coreR = radius * 0.36;
    final coreGlowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment(tiltY * 0.3, tiltX * 0.3),
        colors: [
          const Color(0xFFE879F9),
          const Color(0xFFA855F7).withOpacity(0.9),
          const Color(0xFF6B21A8).withOpacity(0.55),
          const Color(0xFF3B0764).withOpacity(0.18),
          Colors.transparent,
        ],
        stops: const [0.0, 0.30, 0.60, 0.85, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: coreR * 1.6));

    canvas.drawCircle(center, coreR * 1.6, coreGlowPaint);

    // 3. Multi-Tier Concentric Gold & Brass Rings
    const Color goldBright = Color(0xFFF3C969);
    const Color goldDeep = Color(0xFFB48328);

    final outerRingPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(-1.0 + tiltY, -1.0 + tiltX),
        end: Alignment(1.0 - tiltY, 1.0 - tiltX),
        colors: const [
          goldBright,
          goldDeep,
          Color(0xFFFFF0C2),
          goldDeep,
          goldBright,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;

    // Outer double track
    canvas.drawCircle(center, radius, outerRingPaint);
    canvas.drawCircle(
      center,
      radius - 6,
      Paint()
        ..color = goldBright.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9,
    );

    // 4. Middle Brass Track
    final double middleR = radius * 0.72;
    canvas.drawCircle(
      center,
      middleR,
      Paint()
        ..color = goldBright.withOpacity(0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    // 5. Inner Core Boundary Ring
    final double innerR = radius * 0.44;
    canvas.drawCircle(
      center,
      innerR,
      Paint()
        ..color = goldBright.withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // 6. 12 Tajik Astrological Houses / Solar Sectors & Spokes
    final spokePaint = Paint()
      ..color = goldBright.withOpacity(0.42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < 12; i++) {
      final double angle = spinAngle + (i * 2 * math.pi / 12);

      // Spoke from inner ring to outer ring
      final pInner = Offset(
        center.dx + innerR * math.cos(angle),
        center.dy + innerR * math.sin(angle),
      );
      final pOuter = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(pInner, pOuter, spokePaint);

      // Radial degree subdivisions
      final double subAngle = angle + (math.pi / 12);
      final pSub1 = Offset(
        center.dx + (radius - 6) * math.cos(subAngle),
        center.dy + (radius - 6) * math.sin(subAngle),
      );
      final pSub2 = Offset(
        center.dx + radius * math.cos(subAngle),
        center.dy + radius * math.sin(subAngle),
      );
      canvas.drawLine(pSub1, pSub2, spokePaint);
    }

    // 7. Outer 36 Degree Ticks
    for (int i = 0; i < 36; i++) {
      final double angle = spinAngle + (i * 2 * math.pi / 36);
      final double tickLen = (i % 3 == 0) ? 6.0 : 3.5;
      final p1 = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + (radius + tickLen) * math.cos(angle),
        center.dy + (radius + tickLen) * math.sin(angle),
      );
      canvas.drawLine(
        p1,
        p2,
        Paint()
          ..color = goldBright.withOpacity(0.7)
          ..strokeWidth = (i % 3 == 0) ? 1.4 : 0.8,
      );
    }

    // 8. 12 Tajik Planetary Gems (Alternating Imperial Gold & Purple Nodes)
    final double gemOrbitR = radius - 3;
    for (int i = 0; i < 12; i++) {
      final double angle = spinAngle + (i * 2 * math.pi / 12) + (math.pi / 24);
      final gemPos = Offset(
        center.dx + gemOrbitR * math.cos(angle),
        center.dy + gemOrbitR * math.sin(angle),
      );

      final bool isPurple = (i % 2 == 1);
      final Color gemColor = isPurple ? const Color(0xFFC084FC) : const Color(0xFFFDE68A);

      // Gem Shadow & Outer Glow
      canvas.drawCircle(
        gemPos,
        5.2,
        Paint()
          ..color = gemColor.withOpacity(0.35)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );

      // Gem Body with 3D Spherical Radial Highlight
      final gemPaint = Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.35, -0.35),
          colors: [
            Colors.white,
            gemColor,
            isPurple ? const Color(0xFF581C87) : const Color(0xFF78350F),
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(Rect.fromCircle(center: gemPos, radius: 3.5));

      canvas.drawCircle(gemPos, 3.5, gemPaint);
    }
  }

  @override
  bool shouldRepaint(covariant TajikAstrolabe3DPainter oldDelegate) {
    return oldDelegate.spinAngle != spinAngle ||
        oldDelegate.tiltX != tiltX ||
        oldDelegate.tiltY != tiltY;
  }
}
