// lib/shared/engine/3d/devi_oracle_3d_entity.dart
// ASTROAI OS v5.0 - Living 3D Iridescent Intelligence Entity for Devi AI Oracle

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'cosmic_camera_3d.dart';

enum DeviOracleState {
  idle,
  listening,
  thinking,
  speaking,
}

class DeviOracle3DEntity extends StatefulWidget {
  final DeviOracleState state;
  final double audioLevel; // 0.0 to 1.0 (live mic or speech synthesis amplitude)
  final double size;
  final VoidCallback? onTap;

  const DeviOracle3DEntity({
    super.key,
    this.state = DeviOracleState.idle,
    this.audioLevel = 0.0,
    this.size = 240.0,
    this.onTap,
  });

  @override
  State<DeviOracle3DEntity> createState() => _DeviOracle3DEntityState();
}

class _DeviOracle3DEntityState extends State<DeviOracle3DEntity>
    with SingleTickerProviderStateMixin {
  late AnimationController _ticker;
  late CosmicCamera3D _camera;

  double _simTime = 0.0;
  double _lastTime = 0.0;

  // Touch tracking for 3D rotation
  Offset? _lastPan;
  double _touchRippleProgress = 1.0;
  Offset _touchRippleCenter = Offset.zero;

  @override
  void initState() {
    super.initState();
    _camera = CosmicCamera3D(
      azimuth: 0.0,
      elevation: 0.15,
      distance: 300.0,
      target: Vector3.zero(),
      fovRadians: 50.0 * math.pi / 180.0,
    );

    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1000),
    )..repeat();

    _ticker.addListener(_onTick);
  }

  @override
  void dispose() {
    _ticker.removeListener(_onTick);
    _ticker.dispose();
    super.dispose();
  }

  void _onTick() {
    final now = DateTime.now().millisecondsSinceEpoch / 1000.0;
    if (_lastTime == 0.0) _lastTime = now;
    final dt = (now - _lastTime).clamp(0.001, 0.05);
    _lastTime = now;
    _simTime += dt;

    if (_touchRippleProgress < 1.0) {
      _touchRippleProgress += dt * 1.8;
    }

    // Auto slow celestial drift when not dragging
    if (_lastPan == null) {
      final double rotSpeed = widget.state == DeviOracleState.thinking ? 0.75 : 0.22;
      _camera.azimuth += dt * rotSpeed;
    }

    _camera.update(dt);
    if (mounted) setState(() {});
  }

  void _handlePanStart(DragStartDetails details) {
    _lastPan = details.localPosition;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_lastPan == null) return;
    final delta = details.localPosition - _lastPan!;
    _lastPan = details.localPosition;

    _camera.azimuth -= delta.dx * 0.01;
    _camera.elevation = (_camera.elevation + delta.dy * 0.01).clamp(-0.8, 0.8);
  }

  void _handlePanEnd(DragEndDetails details) {
    _lastPan = null;
  }

  void _handleTapDown(TapDownDetails details) {
    HapticFeedback.mediumImpact();
    setState(() {
      _touchRippleProgress = 0.0;
      _touchRippleCenter = details.localPosition;
    });
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: GestureDetector(
        onPanStart: _handlePanStart,
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        onTapDown: _handleTapDown,
        child: CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _DeviOracle3DPainter(
            camera: _camera,
            state: widget.state,
            audioLevel: widget.audioLevel,
            simTime: _simTime,
            touchRippleProgress: _touchRippleProgress,
            touchRippleCenter: _touchRippleCenter,
          ),
        ),
      ),
    );
  }
}

class _DeviOracle3DPainter extends CustomPainter {
  final CosmicCamera3D camera;
  final DeviOracleState state;
  final double audioLevel;
  final double simTime;
  final double touchRippleProgress;
  final Offset touchRippleCenter;

  _DeviOracle3DPainter({
    required this.camera,
    required this.state,
    required this.audioLevel,
    required this.simTime,
    required this.touchRippleProgress,
    required this.touchRippleCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2.0;
    final double cy = size.height / 2.0;
    final double aspect = size.width / size.height;
    final Matrix4 vp = camera.computeViewProjectionMatrix(aspect);

    Offset project(Vector3 p) {
      final Vector4 v4 = vp.transform(Vector4(p.x, p.y, p.z, 1.0));
      if (v4.w <= 0.001) return const Offset(-9999, -9999);
      final double ndcX = v4.x / v4.w;
      final double ndcY = v4.y / v4.w;
      return Offset(cx + ndcX * (size.width / 2.0), cy - ndcY * (size.height / 2.0));
    }

    // Dynamic state modifiers
    double pulseScale = 1.0;
    double energyRate = 1.0;
    Color primaryAura = const Color(0xFF7C3AED);

    switch (state) {
      case DeviOracleState.idle:
        pulseScale = 1.0 + (math.sin(simTime * 1.6) * 0.04);
        energyRate = 1.0;
        primaryAura = const Color(0xFF7C3AED);
        break;
      case DeviOracleState.listening:
        pulseScale = 0.94 + (audioLevel * 0.12);
        energyRate = 1.8;
        primaryAura = const Color(0xFF38BDF8); // Cyan listening
        break;
      case DeviOracleState.thinking:
        pulseScale = 1.0 + (math.sin(simTime * 6.0) * 0.08);
        energyRate = 3.2;
        primaryAura = const Color(0xFFF472B6); // Magenta thinking
        break;
      case DeviOracleState.speaking:
        pulseScale = 1.0 + (audioLevel * 0.28) + (math.sin(simTime * 4.0) * 0.06);
        energyRate = 2.4;
        primaryAura = const Color(0xFFF5D485); // Gold speaking
        break;
    }

    // 1. Draw Bioluminescent Volumetric Outer Glow
    final glowPaint = Paint()
      ..color = primaryAura.withOpacity(0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 35);
    canvas.drawCircle(Offset(cx, cy), (size.width * 0.38) * pulseScale, glowPaint);

    // 2. Draw Orbiting Sacred Geometry Astrolabe Rings in 3D
    _drawRotatingSacredRings(canvas, project, pulseScale, energyRate);

    // 3. Draw Living 3D Iridescent Geodesic Core Mesh
    _drawIridescentCoreMesh(canvas, project, pulseScale, energyRate);

    // 4. Draw Radial Acoustic Energy Shockwaves (when speaking or listening)
    if (state == DeviOracleState.speaking || state == DeviOracleState.listening) {
      _drawAcousticShockwaves(canvas, cx, cy, pulseScale);
    }

    // 5. Draw Interactive Touch Ripple
    if (touchRippleProgress < 1.0) {
      final double r = touchRippleProgress * 90.0;
      final double a = (1.0 - touchRippleProgress).clamp(0.0, 1.0);
      final rPaint = Paint()
        ..color = const Color(0xFFF5D485).withOpacity(0.55 * a)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0 * a;
      canvas.drawCircle(touchRippleCenter, r, rPaint);
    }
  }

  void _drawRotatingSacredRings(
    Canvas canvas,
    Offset Function(Vector3) project,
    double scale,
    double speed,
  ) {
    const int segments = 48;
    final double radius1 = 78.0 * scale;
    final double radius2 = 92.0 * scale;

    // Ring 1 (Tilted 35° on X/Z)
    final ring1Points = <Offset>[];
    final double angleOffset1 = simTime * 0.6 * speed;
    for (int i = 0; i <= segments; i++) {
      final th = (i * 2.0 * math.pi) / segments + angleOffset1;
      final p = Vector3(
        radius1 * math.cos(th),
        radius1 * math.sin(th) * 0.6,
        radius1 * math.sin(th) * 0.8,
      );
      ring1Points.add(project(p));
    }
    final ring1Paint = Paint()
      ..color = const Color(0xFFF5D485).withOpacity(0.40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    for (int i = 0; i < ring1Points.length - 1; i++) {
      canvas.drawLine(ring1Points[i], ring1Points[i + 1], ring1Paint);
    }

    // Ring 2 (Tilted -45° on Y/Z)
    final ring2Points = <Offset>[];
    final double angleOffset2 = -simTime * 0.45 * speed;
    for (int i = 0; i <= segments; i++) {
      final th = (i * 2.0 * math.pi) / segments + angleOffset2;
      final p = Vector3(
        radius2 * math.sin(th) * 0.7,
        radius2 * math.cos(th),
        radius2 * math.sin(th) * 0.7,
      );
      ring2Points.add(project(p));
    }
    final ring2Paint = Paint()
      ..color = const Color(0xFF38BDF8).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    for (int i = 0; i < ring2Points.length - 1; i++) {
      canvas.drawLine(ring2Points[i], ring2Points[i + 1], ring2Paint);
    }
  }

  void _drawIridescentCoreMesh(
    Canvas canvas,
    Offset Function(Vector3) project,
    double scale,
    double speed,
  ) {
    // Generate an icosahedron-like 3D golden core with thin-film iridescence
    const double baseR = 48.0;
    final double phi = (1.0 + math.sqrt(5.0)) / 2.0; // Golden ratio 1.618

    // 12 Normalized Golden Vertices
    final rawVerts = [
      Vector3(-1,  phi, 0),
      Vector3( 1,  phi, 0),
      Vector3(-1, -phi, 0),
      Vector3( 1, -phi, 0),
      Vector3(0, -1,  phi),
      Vector3(0,  1,  phi),
      Vector3(0, -1, -phi),
      Vector3(0,  1, -phi),
      Vector3( phi, 0, -1),
      Vector3( phi, 0,  1),
      Vector3(-phi, 0, -1),
      Vector3(-phi, 0,  1),
    ];

    // Normalize and scale with audio deformation
    final List<Vector3> verts = [];
    for (int i = 0; i < rawVerts.length; i++) {
      final v = rawVerts[i].normalized();
      // Wave surface displacement
      final double wave = math.sin(simTime * 4.0 * speed + (i * 0.75)) * 4.0 * (1.0 + audioLevel * 1.5);
      verts.add(v * (baseR * scale + wave));
    }

    // 20 Triangular Faces of Icosahedron
    const faces = [
      [0, 11, 5], [0, 5, 1], [0, 1, 7], [0, 7, 10], [0, 10, 11],
      [1, 5, 9], [5, 11, 4], [11, 10, 2], [10, 7, 6], [7, 1, 8],
      [3, 9, 4], [3, 4, 2], [3, 2, 6], [3, 6, 8], [3, 8, 9],
      [4, 9, 5], [2, 4, 11], [6, 2, 10], [8, 6, 7], [9, 8, 1],
    ];

    // Sort faces by depth for correct painter's algorithm rendering
    final List<Map<String, dynamic>> sortedFaces = [];
    for (final f in faces) {
      final v0 = verts[f[0]];
      final v1 = verts[f[1]];
      final v2 = verts[f[2]];

      final centroid = (v0 + v1 + v2) * (1.0 / 3.0);
      // Eye-distance depth
      final depth = camera.position.distanceToSquared(centroid);

      // Normal
      final edge1 = v1 - v0;
      final edge2 = v2 - v0;
      final normal = edge1.cross(edge2).normalized();

      sortedFaces.add({
        'face': f,
        'depth': depth,
        'normal': normal,
        'centroid': centroid,
      });
    }

    sortedFaces.sort((a, b) => (b['depth'] as double).compareTo(a['depth'] as double));

    // Render sorted faces with thin-film iridescent dispersion
    for (final item in sortedFaces) {
      final List<int> f = item['face'] as List<int>;
      final Vector3 normal = item['normal'] as Vector3;
      final Vector3 centroid = item['centroid'] as Vector3;

      final p0 = project(verts[f[0]]);
      final p1 = project(verts[f[1]]);
      final p2 = project(verts[f[2]]);

      // View vector
      final viewDir = (camera.position - centroid).normalized();
      final double ndotv = normal.dot(viewDir).clamp(0.0, 1.0);

      // Compute thin-film iridescent color blending
      final Color faceColor = _computeIridescentColor(ndotv, simTime * speed);

      final path = Path()
        ..moveTo(p0.dx, p0.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..close();

      // Face fill
      canvas.drawPath(
        path,
        Paint()
          ..color = faceColor.withOpacity(0.68)
          ..style = PaintingStyle.fill,
      );

      // Wireframe crystal edge
      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.white.withOpacity(0.40)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8,
      );
    }
  }

  // Thin-film optical interference blending
  Color _computeIridescentColor(double ndotv, double t) {
    // Phase calculation: cos(omega * t + phase)
    final double r = 0.5 + 0.5 * math.cos(ndotv * math.pi * 2.0 + t + 0.0);
    final double g = 0.5 + 0.5 * math.cos(ndotv * math.pi * 2.0 + t + 2.0);
    final double b = 0.5 + 0.5 * math.cos(ndotv * math.pi * 2.0 + t + 4.0);

    return Color.fromARGB(
      255,
      (r * 255).toInt().clamp(0, 255),
      (g * 255).toInt().clamp(0, 255),
      (b * 255).toInt().clamp(0, 255),
    );
  }

  void _drawAcousticShockwaves(Canvas canvas, double cx, double cy, double scale) {
    final double progress = (simTime * 2.0) % 1.0;
    final double r = (45.0 + progress * 65.0) * scale;
    final double a = (1.0 - progress).clamp(0.0, 1.0) * (0.35 + audioLevel * 0.45);

    final shockPaint = Paint()
      ..color = const Color(0xFFF5D485).withOpacity(a)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    canvas.drawCircle(Offset(cx, cy), r, shockPaint);
  }

  @override
  bool shouldRepaint(covariant _DeviOracle3DPainter oldDelegate) => true;
}
