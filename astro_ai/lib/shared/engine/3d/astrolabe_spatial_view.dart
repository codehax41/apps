// lib/shared/engine/3d/astrolabe_spatial_view.dart
// ASTROAI OS v5.0 - Hardware-Accelerated 3D Astro-Natal Astrolabe & Dimensional Portal Viewport

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'cosmic_camera_3d.dart';
import 'astrolabe_3d_engine.dart';

class AstrolabeSpatialView extends StatefulWidget {
  final AstrolabeDimension initialDimension;
  final Function(AstrolabePlanetNode)? onPlanetSelected;
  final double height;

  const AstrolabeSpatialView({
    super.key,
    this.initialDimension = AstrolabeDimension.d1Rashi,
    this.onPlanetSelected,
    this.height = 340.0,
  });

  @override
  State<AstrolabeSpatialView> createState() => AstrolabeSpatialViewState();
}

class AstrolabeSpatialViewState extends State<AstrolabeSpatialView>
    with TickerProviderStateMixin {
  late CosmicCamera3D _camera;
  late AnimationController _ticker;
  late AnimationController _portalWarpController;

  AstrolabeDimension _currentDimension = AstrolabeDimension.d1Rashi;
  AstrolabePlanetNode? _selectedPlanet;

  double _simTime = 0.0;
  double _lastFrameTime = 0.0;

  // Touch tracking
  Offset? _lastPanPos;
  double _baseCamDist = 420.0;

  @override
  void initState() {
    super.initState();
    _currentDimension = widget.initialDimension;

    final targetZ = Astrolabe3DEngine.getDimensionZ(_currentDimension);
    _camera = CosmicCamera3D(
      azimuth: 0.6,
      elevation: 0.58,
      distance: 430.0,
      target: Vector3(0.0, targetZ, 0.0),
      fovRadians: 55.0 * math.pi / 180.0,
    );

    _portalWarpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1000),
    )..repeat();

    _ticker.addListener(_onEngineTick);
  }

  @override
  void dispose() {
    _ticker.removeListener(_onEngineTick);
    _ticker.dispose();
    _portalWarpController.dispose();
    super.dispose();
  }

  void _onEngineTick() {
    final now = DateTime.now().millisecondsSinceEpoch / 1000.0;
    if (_lastFrameTime == 0.0) _lastFrameTime = now;
    final dt = (now - _lastFrameTime).clamp(0.001, 0.05);
    _lastFrameTime = now;
    _simTime += dt;

    _camera.update(dt);
    if (mounted) setState(() {});
  }

  // Switch dimensional layer with cinematic Z-axis camera warp travel
  void setDimension(AstrolabeDimension dim) {
    if (_currentDimension == dim) return;
    HapticFeedback.mediumImpact();

    final double targetZ = Astrolabe3DEngine.getDimensionZ(dim);

    setState(() {
      _currentDimension = dim;
      _selectedPlanet = null;
    });

    _portalWarpController.forward(from: 0.0);

    // Camera glides along Z axis with dimensional focus
    _camera.glideTo(
      newTarget: Vector3(0.0, targetZ, 0.0),
      newDistance: 430.0,
      newAzimuth: _camera.azimuth + 0.35,
      newElevation: 0.58,
    );
  }

  void resetCamera() {
    HapticFeedback.lightImpact();
    final targetZ = Astrolabe3DEngine.getDimensionZ(_currentDimension);
    _camera.glideTo(
      newTarget: Vector3(0.0, targetZ, 0.0),
      newDistance: 430.0,
      newAzimuth: 0.6,
      newElevation: 0.58,
    );
  }

  void _handlePanStart(DragStartDetails details) {
    _lastPanPos = details.localPosition;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_lastPanPos == null) return;
    final delta = details.localPosition - _lastPanPos!;
    _lastPanPos = details.localPosition;

    _camera.azimuth -= delta.dx * 0.009;
    _camera.elevation = (_camera.elevation + delta.dy * 0.007).clamp(0.12, 1.45);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseCamDist = _camera.distance;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (details.scale != 1.0) {
      _camera.distance = (_baseCamDist / details.scale).clamp(180.0, 850.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final planets = Astrolabe3DEngine.getPlanetsForDimension(_currentDimension);
    final aspects = Astrolabe3DEngine.computeAspects(planets);

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF04040A),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withOpacity(0.18),
            blurRadius: 35,
            spreadRadius: 2,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // 3D Viewport Gesture Detector
          GestureDetector(
            onPanStart: _handlePanStart,
            onPanUpdate: _handlePanUpdate,
            onScaleStart: _handleScaleStart,
            onScaleUpdate: _handleScaleUpdate,
            child: CustomPaint(
              size: Size.infinite,
              painter: _Astrolabe3DPainter(
                camera: _camera,
                currentDimension: _currentDimension,
                planets: planets,
                aspects: aspects,
                selectedPlanet: _selectedPlanet,
                simTime: _simTime,
                warpProgress: _portalWarpController.value,
                onPlanetHit: (p) {
                  HapticFeedback.vibrate();
                  setState(() => _selectedPlanet = p);
                  widget.onPlanetSelected?.call(p);
                },
              ),
            ),
          ),

          // Dimensional Portal Selector Pill (Top Center)
          Positioned(
            top: 14,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Layer Tabs
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white.withOpacity(0.14)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDimensionTab("D1 RASHI", AstrolabeDimension.d1Rashi),
                      _buildDimensionTab("D9 NAVAMSA", AstrolabeDimension.d9Navamsa),
                      _buildDimensionTab("D10 DASAMSA", AstrolabeDimension.d10Dasamsa),
                    ],
                  ),
                ),

                // Reset Camera Button
                GestureDetector(
                  onTap: resetCamera,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.center_focus_strong, size: 12, color: Color(0xFFF5D485)),
                        SizedBox(width: 4),
                        Text(
                          "RESET 3D",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF5D485),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Selected Planet Telemetry Overlay (Bottom Left)
          if (_selectedPlanet != null)
            Positioned(
              bottom: 12,
              left: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D0D1A).withOpacity(0.92),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _selectedPlanet!.emissiveColor.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: _selectedPlanet!.baseColor.withOpacity(0.25),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _selectedPlanet!.baseColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: _selectedPlanet!.emissiveColor),
                      ),
                      child: Center(
                        child: Text(
                          _selectedPlanet!.symbol,
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${_selectedPlanet!.name.toUpperCase()} (${_selectedPlanet!.sanskritName})",
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5D485).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "H${_selectedPlanet!.houseNumber}",
                                  style: const TextStyle(
                                    fontFamily: 'Space Mono',
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF5D485),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${_selectedPlanet!.nakshatra} • Longitude: ${_selectedPlanet!.eclipticLongitude.toStringAsFixed(2)}°",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 9,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 14, color: Colors.white54),
                      onPressed: () => setState(() => _selectedPlanet = null),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),

          // Bottom Right Dimension Indicator
          Positioned(
            bottom: 12,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              child: Text(
                "Z-AXIS: ${Astrolabe3DEngine.getDimensionZ(_currentDimension).toInt()} pt",
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 8,
                  color: Colors.white54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionTab(String label, AstrolabeDimension dim) {
    final isSelected = _currentDimension == dim;
    return GestureDetector(
      onTap: () => setDimension(dim),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7C3AED) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.white60,
          ),
        ),
      ),
    );
  }
}

// CustomPainter performing full 3D matrix transformations, multi-layer astrolabe rings,
// floating planetary nodes with Z-hover bobbing, and dynamic aspect energy arcs.
class _Astrolabe3DPainter extends CustomPainter {
  final CosmicCamera3D camera;
  final AstrolabeDimension currentDimension;
  final List<AstrolabePlanetNode> planets;
  final List<AstrolabeAspectConnection> aspects;
  final AstrolabePlanetNode? selectedPlanet;
  final double simTime;
  final double warpProgress;
  final Function(AstrolabePlanetNode) onPlanetHit;

  _Astrolabe3DPainter({
    required this.camera,
    required this.currentDimension,
    required this.planets,
    required this.aspects,
    required this.selectedPlanet,
    required this.simTime,
    required this.warpProgress,
    required this.onPlanetHit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double aspect = size.width / size.height;
    final Matrix4 vp = camera.computeViewProjectionMatrix(aspect);
    final double cx = size.width / 2.0;
    final double cy = size.height / 2.0;

    // Project 3D point (world space) to 2D screen viewport
    Offset project(Vector3 p) {
      final Vector4 v4 = vp.transform(Vector4(p.x, p.y, p.z, 1.0));
      if (v4.w <= 0.001) return const Offset(-9999, -9999);
      final double ndcX = v4.x / v4.w;
      final double ndcY = v4.y / v4.w;
      return Offset(cx + ndcX * (size.width / 2.0), cy - ndcY * (size.height / 2.0));
    }

    // 1. Draw Starfield & Parallax Background
    _drawStarfield(canvas, size);

    // 2. Draw Stacked Dimensional Strata (All 3 layers: D1, D9, D10)
    for (final dim in AstrolabeDimension.values) {
      final double z = Astrolabe3DEngine.getDimensionZ(dim);
      final bool isCurrent = dim == currentDimension;
      final double baseAlpha = isCurrent ? 1.0 : 0.22;
      _drawAstrolabeStrata(canvas, project, z, isCurrent, baseAlpha);
    }

    // 3. Draw Dimensional Flux Pillars connecting identical planets across strata
    _drawDimensionalFluxPillars(canvas, project);

    // 4. Draw Active Dynamic Aspect Energy Lines (3D Curved Arcs)
    final double currentZ = Astrolabe3DEngine.getDimensionZ(currentDimension);
    _drawAspectEnergyArcs(canvas, project, currentZ);

    // 5. Draw Floating 3D Planetary Nodes
    _drawPlanetaryNodes(canvas, project, currentZ);

    // 6. Draw Dimensional Portal Warp Ripple Effect if animating
    if (warpProgress > 0.0 && warpProgress < 1.0) {
      _drawPortalWarpWave(canvas, cx, cy);
    }
  }

  void _drawStarfield(Canvas canvas, Size size) {
    final starPaint = Paint()..color = Colors.white.withOpacity(0.35);
    final rand = math.Random(42);
    for (int i = 0; i < 60; i++) {
      final x = (rand.nextDouble() * size.width);
      final y = (rand.nextDouble() * size.height);
      final r = (rand.nextDouble() * 1.5) + 0.4;
      final flicker = (math.sin(simTime * 3.0 + i) * 0.3) + 0.7;
      starPaint.color = Colors.white.withOpacity(0.30 * flicker);
      canvas.drawCircle(Offset(x, y), r, starPaint);
    }
  }

  void _drawAstrolabeStrata(Canvas canvas, Offset Function(Vector3) project, double z, bool isCurrent, double alpha) {
    const double radius = 145.0;
    const int segments = 72;

    // Outer Ecliptic Coordinate Ring
    final ringPoints = <Offset>[];
    for (int i = 0; i <= segments; i++) {
      final angle = (i * 2.0 * math.pi) / segments;
      final p = Vector3(radius * math.cos(angle), z, radius * math.sin(angle));
      ringPoints.add(project(p));
    }

    final ringPaint = Paint()
      ..color = (isCurrent ? const Color(0xFFF5D485) : Colors.white).withOpacity(0.35 * alpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isCurrent ? 1.2 : 0.6;

    for (int i = 0; i < ringPoints.length - 1; i++) {
      canvas.drawLine(ringPoints[i], ringPoints[i + 1], ringPaint);
    }

    // Inner Nakshatra Ring
    const double innerRadius = 95.0;
    final innerPoints = <Offset>[];
    for (int i = 0; i <= segments; i++) {
      final angle = (i * 2.0 * math.pi) / segments;
      final p = Vector3(innerRadius * math.cos(angle), z, innerRadius * math.sin(angle));
      innerPoints.add(project(p));
    }
    final innerPaint = Paint()
      ..color = const Color(0xFF7C3AED).withOpacity(0.30 * alpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (int i = 0; i < innerPoints.length - 1; i++) {
      canvas.drawLine(innerPoints[i], innerPoints[i + 1], innerPaint);
    }

    // 12 Zodiac Radial Dividers (30° each)
    for (int s = 0; s < 12; s++) {
      final angle = (s * 30.0 * math.pi) / 180.0;
      final pInner = Vector3(innerRadius * math.cos(angle), z, innerRadius * math.sin(angle));
      final pOuter = Vector3(radius * math.cos(angle), z, radius * math.sin(angle));

      final sectorMeta = Astrolabe3DEngine.zodiacSectors[s];
      final Color sectorColor = (sectorMeta["color"] as Color).withOpacity(0.45 * alpha);

      canvas.drawLine(project(pInner), project(pOuter), Paint()..color = sectorColor..strokeWidth = 1.0);

      // Zodiac Glyph at midpoint of sector
      if (isCurrent) {
        final midAngle = angle + (15.0 * math.pi / 180.0);
        final pGlyph = Vector3((innerRadius + 25) * math.cos(midAngle), z, (innerRadius + 25) * math.sin(midAngle));
        final sPos = project(pGlyph);

        final textPainter = TextPainter(
          text: TextSpan(
            text: sectorMeta["symbol"] as String,
            style: TextStyle(
              fontSize: 10,
              color: (sectorMeta["color"] as Color).withOpacity(0.85),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(canvas, Offset(sPos.dx - 5, sPos.dy - 6));
      }
    }

    // Central Cosmic Core Axis Ring
    final centerPos = project(Vector3(0.0, z, 0.0));
    canvas.drawCircle(centerPos, isCurrent ? 5.0 : 2.5, Paint()..color = const Color(0xFFF5D485).withOpacity(0.6 * alpha));
  }

  void _drawDimensionalFluxPillars(Canvas canvas, Offset Function(Vector3) project) {
    const double radius = 120.0;
    // Draw 4 cardinal vertical flux pillars connecting all dimensions
    final fluxPaint = Paint()
      ..color = const Color(0xFF38BDF8).withOpacity(0.18)
      ..strokeWidth = 0.8;

    for (int i = 0; i < 4; i++) {
      final angle = (i * 90.0 * math.pi) / 180.0;
      final pBottom = Vector3(radius * math.cos(angle), 0.0, radius * math.sin(angle));
      final pTop = Vector3(radius * math.cos(angle), 440.0, radius * math.sin(angle));
      canvas.drawLine(project(pBottom), project(pTop), fluxPaint);
    }
  }

  void _drawAspectEnergyArcs(Canvas canvas, Offset Function(Vector3) project, double currentZ) {
    for (final aspect in aspects) {
      final double radA = aspect.planetA.eclipticLongitude * math.pi / 180.0;
      final double radB = aspect.planetB.eclipticLongitude * math.pi / 180.0;

      const double dist = 120.0;
      final posA = Vector3(dist * math.cos(radA), currentZ, dist * math.sin(radA));
      final posB = Vector3(dist * math.cos(radB), currentZ, dist * math.sin(radB));

      // Compute 3D midpoint elevated in Y/Z space to form an arc
      final mid = (posA + posB) * 0.5;
      final double arcHeight = (aspect.type == AspectType.trikona) ? 45.0 : 25.0;
      mid.y += arcHeight; // Arches upward into 3D space

      // Sample parabolic curve points
      const int steps = 14;
      final pathPoints = <Offset>[];
      for (int i = 0; i <= steps; i++) {
        final t = i / steps;
        // Quadratic bezier formula: (1-t)^2 P0 + 2(1-t)t P1 + t^2 P2
        final p = (posA * ((1 - t) * (1 - t))) + (mid * (2 * (1 - t) * t)) + (posB * (t * t));
        pathPoints.add(project(p));
      }

      Color arcColor;
      double strokeW;
      switch (aspect.type) {
        case AspectType.trikona:
          arcColor = const Color(0xFFF5D485); // Golden Trine
          strokeW = 1.4;
          break;
        case AspectType.kendra:
          arcColor = const Color(0xFFF472B6); // Magenta Square
          strokeW = 1.2;
          break;
        case AspectType.opposition:
          arcColor = const Color(0xFF38BDF8); // Cyan Opposition Axis
          strokeW = 1.0;
          break;
        case AspectType.conjunction:
          arcColor = const Color(0xFF10B981); // Emerald Fusion
          strokeW = 1.6;
          break;
      }

      final arcPaint = Paint()
        ..color = arcColor.withOpacity(0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeW;

      for (int i = 0; i < pathPoints.length - 1; i++) {
        canvas.drawLine(pathPoints[i], pathPoints[i + 1], arcPaint);
      }

      // Traveling Energy Particle Spark along the 3D curve
      final double particleT = (simTime * 0.45 + (aspect.angleDifference * 0.1)) % 1.0;
      final sparkPoint = (posA * ((1 - particleT) * (1 - particleT))) +
                         (mid * (2 * (1 - particleT) * particleT)) +
                         (posB * (particleT * particleT));
      final sparkScreen = project(sparkPoint);
      canvas.drawCircle(sparkScreen, 2.5, Paint()..color = arcColor);
      canvas.drawCircle(sparkScreen, 4.5, Paint()..color = arcColor.withOpacity(0.35));
    }
  }

  void _drawPlanetaryNodes(Canvas canvas, Offset Function(Vector3) project, double currentZ) {
    const double radius = 120.0;

    for (final planet in planets) {
      final double angle = planet.eclipticLongitude * math.pi / 180.0;
      // Sinusoidal Z-hover oscillation bobbing
      final double hoverBob = math.sin(simTime * 2.2 + planet.eclipticLongitude) * 6.0;
      final Vector3 nodePos = Vector3(
        radius * math.cos(angle),
        currentZ + hoverBob,
        radius * math.sin(angle),
      );

      // Baseplate shadow point
      final Vector3 shadowPos = Vector3(
        radius * math.cos(angle),
        currentZ,
        radius * math.sin(angle),
      );

      final screenShadow = project(shadowPos);
      final screenNode = project(nodePos);

      // 1. Drop shadow / projection line connecting floating node to baseplate
      canvas.drawLine(
        screenShadow,
        screenNode,
        Paint()
          ..color = planet.baseColor.withOpacity(0.35)
          ..strokeWidth = 0.8
          ..style = PaintingStyle.stroke,
      );
      canvas.drawCircle(screenShadow, 3.2, Paint()..color = planet.baseColor.withOpacity(0.4));

      // 2. Multi-Layered 3D Planetary Sphere with Atmospheric Corona Glow
      final double nodeRadius = planet.radius;
      final bool isSelected = selectedPlanet?.id == planet.id;

      // Outer Glow Halo
      canvas.drawCircle(
        screenNode,
        nodeRadius * (isSelected ? 2.4 : 1.7),
        Paint()..color = planet.emissiveColor.withOpacity(isSelected ? 0.45 : 0.22),
      );

      // Inner Core Sphere
      canvas.drawCircle(
        screenNode,
        nodeRadius,
        Paint()..color = planet.baseColor,
      );

      // Specular Highlight Spot
      final Offset specularOffset = Offset(screenNode.dx - nodeRadius * 0.28, screenNode.dy - nodeRadius * 0.28);
      canvas.drawCircle(
        specularOffset,
        nodeRadius * 0.32,
        Paint()..color = Colors.white.withOpacity(0.75),
      );

      // 3. Saturn's 3D Tilted Planar Ring
      if (planet.hasRing) {
        final ringRect = Rect.fromCenter(center: screenNode, width: nodeRadius * 3.2, height: nodeRadius * 1.0);
        canvas.drawOval(
          ringRect,
          Paint()
            ..color = const Color(0xFFF5D485).withOpacity(0.65)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.4,
        );
      }

      // 4. Billboard Symbol & Sanskrit Name
      final textSpan = TextSpan(
        text: "${planet.symbol} ${planet.sanskritName}",
        style: TextStyle(
          fontFamily: 'Space Mono',
          fontSize: isSelected ? 10 : 8,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? const Color(0xFFF5D485) : Colors.white70,
        ),
      );
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(screenNode.dx - tp.width / 2, screenNode.dy + nodeRadius + 3));
    }
  }

  void _drawPortalWarpWave(Canvas canvas, double cx, double cy) {
    final double radius = warpProgress * 220.0;
    final double alpha = (1.0 - warpProgress).clamp(0.0, 1.0);
    final wavePaint = Paint()
      ..color = const Color(0xFF7C3AED).withOpacity(0.6 * alpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0 * alpha;
    canvas.drawCircle(Offset(cx, cy), radius, wavePaint);
  }

  @override
  bool shouldRepaint(covariant _Astrolabe3DPainter oldDelegate) => true;
}
