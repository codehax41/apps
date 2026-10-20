// lib/shared/engine/3d/palm_scanner_3d_view.dart
// ASTROAI OS v5.0 - Hardware-Accelerated 3D Holographic Palm Scanner & Live Palm Map Engine

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/palmistry/models/palm_reading_model.dart';

class PalmScanner3DView extends StatefulWidget {
  final PalmSideAnalysis? sideAnalysis;
  final bool isLeft;
  final bool isScanning;
  final int scanningStage;
  final String? focusedLineId;
  final ValueChanged<PalmLineFeature>? onLineSelected;
  final ValueChanged<PalmMount>? onMountSelected;
  final bool showMounts;
  final bool showGrid;
  final bool enableGestures;

  const PalmScanner3DView({
    super.key,
    this.sideAnalysis,
    required this.isLeft,
    this.isScanning = false,
    this.scanningStage = 0,
    this.focusedLineId,
    this.onLineSelected,
    this.onMountSelected,
    this.showMounts = true,
    this.showGrid = true,
    this.enableGestures = true,
  });

  @override
  State<PalmScanner3DView> createState() => _PalmScanner3DViewState();
}

class _PalmScanner3DViewState extends State<PalmScanner3DView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  double _rotX = 0.0;
  double _rotY = 0.0;
  double _scale = 1.0;
  double _baseScale = 1.0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onScaleStart(ScaleStartDetails details) {
    _baseScale = _scale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (!widget.enableGestures) return;
    setState(() {
      _scale = (_baseScale * details.scale).clamp(0.8, 1.8);
      _rotY += details.focalPointDelta.dx * 0.005;
      _rotX -= details.focalPointDelta.dy * 0.005;
      _rotX = _rotX.clamp(-0.4, 0.4);
      _rotY = _rotY.clamp(-0.5, 0.5);
    });
  }

  void _resetOrientation() {
    HapticFeedback.selectionClick();
    setState(() {
      _rotX = 0.0;
      _rotY = 0.0;
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onDoubleTap: _resetOrientation,
      child: AnimatedBuilder(
        animation: _animController,
        builder: (context, child) {
          return CustomPaint(
            painter: PalmHologramPainter(
              animationValue: _animController.value,
              rotX: _rotX,
              rotY: _rotY,
              zoom: _scale,
              isLeft: widget.isLeft,
              isScanning: widget.isScanning,
              scanningStage: widget.scanningStage,
              sideAnalysis: widget.sideAnalysis,
              focusedLineId: widget.focusedLineId,
              showMounts: widget.showMounts,
              showGrid: widget.showGrid,
            ),
            child: Container(),
          );
        },
      ),
    );
  }
}

class PalmHologramPainter extends CustomPainter {
  final double animationValue;
  final double rotX;
  final double rotY;
  final double zoom;
  final bool isLeft;
  final bool isScanning;
  final int scanningStage;
  final PalmSideAnalysis? sideAnalysis;
  final String? focusedLineId;
  final bool showMounts;
  final bool showGrid;

  PalmHologramPainter({
    required this.animationValue,
    required this.rotX,
    required this.rotY,
    required this.zoom,
    required this.isLeft,
    required this.isScanning,
    required this.scanningStage,
    this.sideAnalysis,
    this.focusedLineId,
    required this.showMounts,
    required this.showGrid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    canvas.save();
    canvas.translate(center.dx, center.dy);

    // Apply 3D perspective transforms
    final matrix4 = Matrix4.identity()
      ..setEntry(3, 2, 0.0015) // perspective projection
      ..rotateX(rotX)
      ..rotateY(rotY)
      ..scale(zoom);
    canvas.transform(matrix4.storage);
    canvas.translate(-center.dx, -center.dy);

    // 1. Draw Holographic Hand Perimeter Contour
    _drawHandSilhouette(canvas, size);

    // 2. Draw Spatial Scanning Grid (If stage 1 or enabled)
    if (showGrid || (isScanning && scanningStage >= 1)) {
      _drawSpatialGrid(canvas, size);
    }

    // 3. Draw Laser Scanning Beam (If scanning)
    if (isScanning) {
      _drawScanningLaser(canvas, size);
    }

    // 4. Draw Palm Lines (Heart, Head, Life, Fate, Sun)
    if (sideAnalysis != null) {
      _drawPalmLines(canvas, size);
    }

    // 5. Draw Planetary Mounts
    if (showMounts && sideAnalysis != null && (!isScanning || scanningStage >= 7)) {
      _drawMounts(canvas, size);
    }

    // 6. Draw Floating Atmospheric Particles
    _drawCosmicParticles(canvas, size);

    canvas.restore();
  }

  void _drawHandSilhouette(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final handPath = Path();
    // Normalize coordinates around canvas center
    // Left hand vs Right hand mirror

    // Procedural holographic contour of wrist, thumb, 4 fingers
    final points = isLeft
        ? [
            Offset(w * 0.35, h * 0.88), // Wrist left
            Offset(w * 0.28, h * 0.72), // Palm base
            Offset(w * 0.15, h * 0.58), // Thumb knuckle
            Offset(w * 0.12, h * 0.44), // Thumb tip
            Offset(w * 0.24, h * 0.46), // Thumb cleft
            Offset(w * 0.25, h * 0.22), // Index knuckle
            Offset(w * 0.27, h * 0.10), // Index tip
            Offset(w * 0.36, h * 0.18), // Index-middle cleft
            Offset(w * 0.40, h * 0.05), // Middle tip
            Offset(w * 0.50, h * 0.16), // Middle-ring cleft
            Offset(w * 0.56, h * 0.09), // Ring tip
            Offset(w * 0.64, h * 0.20), // Ring-pinky cleft
            Offset(w * 0.73, h * 0.18), // Pinky tip
            Offset(w * 0.78, h * 0.34), // Pinky base
            Offset(w * 0.80, h * 0.60), // Outer palm
            Offset(w * 0.74, h * 0.78), // Outer wrist
            Offset(w * 0.65, h * 0.88), // Wrist base
          ]
        : [
            Offset(w * 0.65, h * 0.88),
            Offset(w * 0.72, h * 0.72),
            Offset(w * 0.85, h * 0.58),
            Offset(w * 0.88, h * 0.44),
            Offset(w * 0.76, h * 0.46),
            Offset(w * 0.75, h * 0.22),
            Offset(w * 0.73, h * 0.10),
            Offset(w * 0.64, h * 0.18),
            Offset(w * 0.60, h * 0.05),
            Offset(w * 0.50, h * 0.16),
            Offset(w * 0.44, h * 0.09),
            Offset(w * 0.36, h * 0.20),
            Offset(w * 0.27, h * 0.18),
            Offset(w * 0.22, h * 0.34),
            Offset(w * 0.20, h * 0.60),
            Offset(w * 0.26, h * 0.78),
            Offset(w * 0.35, h * 0.88),
          ];

    handPath.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      handPath.lineTo(points[i].dx, points[i].dy);
    }
    handPath.close();

    // Subtle dark cosmic glass interior
    final fillPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF1B1838).withOpacity(0.35),
          const Color(0xFF090814).withOpacity(0.85),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(handPath, fillPaint);

    // Glowing Neon Cyan/Violet outline
    final glowPulse = 0.5 + 0.5 * math.sin(animationValue * 2 * math.pi);
    final strokeGlowPaint = Paint()
      ..color = const Color(0xFF8A2BE2).withOpacity(0.3 + 0.2 * glowPulse)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(handPath, strokeGlowPaint);

    final crispStrokePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF00E5FF), Color(0xFFE0AAFF), Color(0xFF9D4EDD)],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawPath(handPath, crispStrokePaint);
  }

  void _drawSpatialGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF00E5FF).withOpacity(0.08)
      ..strokeWidth = 0.75
      ..style = PaintingStyle.stroke;

    const step = 28.0;
    for (double x = 20; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 20), Offset(x, size.height - 20), gridPaint);
    }
    for (double y = 20; y < size.height; y += step) {
      canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), gridPaint);
    }
  }

  void _drawScanningLaser(Canvas canvas, Size size) {
    // Vertical sweep
    final scanY = (animationValue * (size.height - 80)) + 40;

    final laserGradient = LinearGradient(
      colors: [
        Colors.transparent,
        const Color(0xFF00E5FF).withOpacity(0.85),
        const Color(0xFFFFFFFF),
        const Color(0xFF00E5FF).withOpacity(0.85),
        Colors.transparent,
      ],
      stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
    );

    final laserGlowPaint = Paint()
      ..shader = laserGradient.createShader(
        Rect.fromLTWH(size.width * 0.1, scanY - 6, size.width * 0.8, 12),
      )
      ..strokeWidth = 4.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawLine(
      Offset(size.width * 0.1, scanY),
      Offset(size.width * 0.9, scanY),
      laserGlowPaint,
    );

    final crispLaser = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(size.width * 0.18, scanY),
      Offset(size.width * 0.82, scanY),
      crispLaser,
    );
  }

  void _drawPalmLines(Canvas canvas, Size size) {
    final analysis = sideAnalysis!;
    final lines = [
      analysis.heartLine,
      analysis.headLine,
      analysis.lifeLine,
      analysis.fateLine,
      if (analysis.sunLine != null) analysis.sunLine!,
    ];

    for (final line in lines) {
      if (!line.visible || line.pathPoints.isEmpty) continue;

      // Filter lines dynamically during scanning stages
      if (isScanning) {
        if (line.id == 'heart_line' && scanningStage < 3) continue;
        if (line.id == 'head_line' && scanningStage < 4) continue;
        if (line.id == 'life_line' && scanningStage < 5) continue;
        if (line.id == 'fate_line' && scanningStage < 6) continue;
      }

      final isFocused = focusedLineId == line.id;
      final baseColor = _parseColor(line.colorHex);

      final path = Path();
      final offsets = line.pathPoints
          .map((p) => p.toOffset(size.width, size.height))
          .toList();

      path.moveTo(offsets[0].dx, offsets[0].dy);
      for (int i = 1; i < offsets.length; i++) {
        final p0 = offsets[i - 1];
        final p1 = offsets[i];
        final mid = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
        path.quadraticBezierTo(p0.dx, p0.dy, mid.dx, mid.dy);
      }
      path.lineTo(offsets.last.dx, offsets.last.dy);

      // Deep outer atmospheric blur
      final glowPaint = Paint()
        ..color = baseColor.withOpacity(isFocused ? 0.9 : 0.45)
        ..strokeWidth = isFocused ? 10.0 : 6.0
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, isFocused ? 12 : 7);
      canvas.drawPath(path, glowPaint);

      // Crisp core luminous line
      final corePaint = Paint()
        ..color = isFocused ? Colors.white : baseColor
        ..strokeWidth = isFocused ? 3.0 : 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, corePaint);

      // Draw node beads along the line
      for (int i = 0; i < offsets.length; i++) {
        final off = offsets[i];
        final beadGlow = Paint()
          ..color = baseColor.withOpacity(0.8)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
        canvas.drawCircle(off, isFocused ? 5.5 : 3.5, beadGlow);

        final beadCore = Paint()..color = Colors.white;
        canvas.drawCircle(off, isFocused ? 2.5 : 1.5, beadCore);
      }
    }
  }

  void _drawMounts(Canvas canvas, Size size) {
    for (final mount in sideAnalysis!.mounts) {
      final center = mount.centerPoint.toOffset(size.width, size.height);

      // Circular radiating mount aura
      final auraPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFFD700).withOpacity(0.25),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: 24));
      canvas.drawCircle(center, 24, auraPaint);

      // Ring boundary
      final ringPaint = Paint()
        ..color = const Color(0xFFFFD700).withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8;
      canvas.drawCircle(center, 12, ringPaint);

      final centerDot = Paint()..color = const Color(0xFFFFD700);
      canvas.drawCircle(center, 2.0, centerDot);
    }
  }

  void _drawCosmicParticles(Canvas canvas, Size size) {
    final rnd = math.Random(42);
    final particlePaint = Paint()..color = Colors.white.withOpacity(0.4);

    for (int i = 0; i < 28; i++) {
      final px = rnd.nextDouble() * size.width;
      final py = (rnd.nextDouble() * size.height + animationValue * 30) % size.height;
      final rad = rnd.nextDouble() * 1.5 + 0.5;
      canvas.drawCircle(Offset(px, py), rad, particlePaint);
    }
  }

  Color _parseColor(String hex) {
    try {
      final clean = hex.replaceAll('#', '');
      if (clean.length == 6) {
        return Color(int.parse('0xFF$clean'));
      }
      return const Color(0xFF00E5FF);
    } catch (_) {
      return const Color(0xFF00E5FF);
    }
  }

  @override
  bool shouldRepaint(covariant PalmHologramPainter oldDelegate) => true;
}
