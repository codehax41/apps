// lib/shared/engine/3d/cosmic_spatial_view.dart
// ASTROAI OS v5.0 - Master Interactive 3D Cosmic Viewport Widget (Vulkan / Impeller Acceleration)

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vm;
import 'cosmic_camera_3d.dart';
import 'celestial_mesh_3d.dart';
import 'cosmic_lighting_3d.dart';
import 'cosmic_raycaster_3d.dart';
import 'spatial_particle_system_3d.dart';
import 'planet_node_3d.dart';

class CosmicSpatialView extends StatefulWidget {
  final double height;
  final bool enableUserInteraction;
  final bool showOrbits;
  final bool showVortex;
  final double vortexExpansion;
  final ValueChanged<PlanetNode3D?>? onPlanetSelected;
  final PlanetNode3D? initiallySelectedPlanet;

  const CosmicSpatialView({
    super.key,
    this.height = 360,
    this.enableUserInteraction = true,
    this.showOrbits = true,
    this.showVortex = true,
    this.vortexExpansion = 1.0,
    this.onPlanetSelected,
    this.initiallySelectedPlanet,
  });

  @override
  State<CosmicSpatialView> createState() => _CosmicSpatialViewState();
}

class _CosmicSpatialViewState extends State<CosmicSpatialView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ticker;
  late final CosmicCamera3D _camera;
  late final CosmicLighting3D _lighting;
  late final SpatialParticleSystem3D _particles;

  late final List<PlanetNode3D> _planets;
  late final List<OrbitCurve3D> _orbitCurves;

  PlanetNode3D? _selectedPlanet;
  Offset? _hudScreenPosition;
  double _lastFrameTime = 0.0;
  double _vortexAngle = 0.0;

  // Gesture handling state
  Offset? _lastFocalPoint;
  double _baseDistance = 520.0;

  @override
  void initState() {
    super.initState();

    _camera = CosmicCamera3D(
      azimuth: 0.55,
      elevation: 0.38,
      distance: 540.0,
    );

    _lighting = CosmicLighting3D(
      sunPosition: vm.Vector3.zero(),
      ambientIntensity: 0.22,
      sunIntensity: 1.1,
    );

    _particles = SpatialParticleSystem3D.create(
      starCount: 280,
      vortexCount: 320,
      fieldRadius: 1200.0,
      vortexRadius: 85.0,
    );

    _initPlanetarySystem();

    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(days: 365),
    )..addListener(_onTick);
    _ticker.forward();

    if (widget.initiallySelectedPlanet != null) {
      _selectPlanet(widget.initiallySelectedPlanet!);
    }
  }

  void _initPlanetarySystem() {
    _planets = [
      // 1. Surya (The Sun - Central Stellar Core)
      PlanetNode3D(
        id: 'sun',
        name: 'Sun',
        glyph: '☉',
        sign: 'Virgo',
        degreeStr: '27°14\'',
        house: '10th House',
        dignity: 'Friendly',
        nakshatra: 'Uttara Phalguni',
        radius: 20.0,
        orbitRadiusX: 0.0,
        orbitRadiusZ: 0.0,
        orbitInclination: 0.0,
        orbitSpeed: 0.0,
        baseColor: const Color(0xFFFFD580),
        emissiveColor: const Color(0xFFFF9E0B),
        isSun: true,
      ),
      // 2. Budha (Mercury)
      PlanetNode3D(
        id: 'mercury',
        name: 'Mercury',
        glyph: '☿',
        sign: 'Virgo',
        degreeStr: '14°02\'',
        house: '10th House',
        dignity: 'Exalted',
        nakshatra: 'Hasta',
        radius: 5.5,
        orbitRadiusX: 68.0,
        orbitRadiusZ: 62.0,
        orbitInclination: 0.12,
        orbitSpeed: 0.75,
        baseColor: const Color(0xFF34D399),
        initialAngle: 0.8,
      ),
      // 3. Shukra (Venus)
      PlanetNode3D(
        id: 'venus',
        name: 'Venus',
        glyph: '♀',
        sign: 'Libra',
        degreeStr: '08°45\'',
        house: '11th House',
        dignity: 'Moolatrikona',
        nakshatra: 'Chitra',
        radius: 7.8,
        orbitRadiusX: 108.0,
        orbitRadiusZ: 98.0,
        orbitInclination: -0.08,
        orbitSpeed: 0.52,
        baseColor: const Color(0xFFF472B6),
        initialAngle: 2.1,
      ),
      // 4. Chandra (Moon)
      PlanetNode3D(
        id: 'moon',
        name: 'Moon',
        glyph: '☽',
        sign: 'Taurus',
        degreeStr: '03°28\'',
        house: '6th House',
        dignity: 'Exalted',
        nakshatra: 'Rohini',
        radius: 7.2,
        orbitRadiusX: 152.0,
        orbitRadiusZ: 140.0,
        orbitInclination: 0.18,
        orbitSpeed: 0.40,
        baseColor: const Color(0xFFE2E8F0),
        initialAngle: 4.2,
      ),
      // 5. Mangala (Mars)
      PlanetNode3D(
        id: 'mars',
        name: 'Mars',
        glyph: '♂',
        sign: 'Cancer',
        degreeStr: '22°50\'',
        house: '8th House',
        dignity: 'Debilitated',
        nakshatra: 'Ashlesha',
        radius: 6.8,
        orbitRadiusX: 202.0,
        orbitRadiusZ: 186.0,
        orbitInclination: 0.10,
        orbitSpeed: 0.30,
        baseColor: const Color(0xFFF87171),
        initialAngle: 1.2,
      ),
      // 6. Guru (Jupiter)
      PlanetNode3D(
        id: 'jupiter',
        name: 'Jupiter',
        glyph: '♃',
        sign: 'Taurus',
        degreeStr: '19°12\'',
        house: '6th House',
        dignity: 'Neutral',
        nakshatra: 'Rohini',
        radius: 14.0,
        orbitRadiusX: 268.0,
        orbitRadiusZ: 248.0,
        orbitInclination: -0.05,
        orbitSpeed: 0.18,
        baseColor: const Color(0xFFFBBF24),
        initialAngle: 3.5,
      ),
      // 7. Shani (Saturn with 3D Rings)
      PlanetNode3D(
        id: 'saturn',
        name: 'Saturn',
        glyph: '♄',
        sign: 'Aquarius',
        degreeStr: '18°33\'',
        house: '3rd House',
        dignity: 'Moolatrikona',
        nakshatra: 'Shatabhisha',
        radius: 11.5,
        orbitRadiusX: 345.0,
        orbitRadiusZ: 320.0,
        orbitInclination: 0.14,
        orbitSpeed: 0.11,
        baseColor: const Color(0xFFA78BFA),
        hasRings: true,
        initialAngle: 5.4,
      ),
    ];

    _orbitCurves = [
      OrbitCurve3D(radiusX: 68.0, radiusZ: 62.0, inclination: 0.12, pathColor: const Color(0xFF34D399).withOpacity(0.22)),
      OrbitCurve3D(radiusX: 108.0, radiusZ: 98.0, inclination: -0.08, pathColor: const Color(0xFFF472B6).withOpacity(0.22)),
      OrbitCurve3D(radiusX: 152.0, radiusZ: 140.0, inclination: 0.18, pathColor: const Color(0xFFE2E8F0).withOpacity(0.20)),
      OrbitCurve3D(radiusX: 202.0, radiusZ: 186.0, inclination: 0.10, pathColor: const Color(0xFFF87171).withOpacity(0.20)),
      OrbitCurve3D(radiusX: 268.0, radiusZ: 248.0, inclination: -0.05, pathColor: const Color(0xFFFBBF24).withOpacity(0.18)),
      OrbitCurve3D(radiusX: 345.0, radiusZ: 320.0, inclination: 0.14, pathColor: const Color(0xFFA78BFA).withOpacity(0.18)),
    ];
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick() {
    final double currentTime = DateTime.now().millisecondsSinceEpoch / 1000.0;
    if (_lastFrameTime == 0.0) _lastFrameTime = currentTime;
    final double dt = (currentTime - _lastFrameTime).clamp(0.001, 0.05);
    _lastFrameTime = currentTime;

    _vortexAngle += dt * 0.45;

    // Update camera motion and programmatic glide
    _camera.update(dt);

    // Update 3D orbital mechanics
    for (final planet in _planets) {
      planet.updatePosition(dt);
    }

    // Update 3D volumetric particles
    _particles.update(
      dt,
      _vortexAngle,
      expansionFactor: widget.vortexExpansion,
    );

    setState(() {});
  }

  void _selectPlanet(PlanetNode3D planet) {
    HapticFeedback.lightImpact();
    setState(() {
      for (final p in _planets) {
        p.isSelected = (p.id == planet.id);
      }
      _selectedPlanet = planet;
    });

    // Smoothly glide 3D camera to focus on selected planet
    if (planet.isSun) {
      _camera.glideTo(
        newTarget: vm.Vector3.zero(),
        newDistance: 320.0,
      );
    } else {
      _camera.glideTo(
        newTarget: planet.position,
        newDistance: math.max(160.0, planet.radius * 12.0),
      );
    }

    widget.onPlanetSelected?.call(planet);
  }

  void _resetCamera() {
    HapticFeedback.selectionClick();
    setState(() {
      for (final p in _planets) {
        p.isSelected = false;
      }
      _selectedPlanet = null;
      _hudScreenPosition = null;
    });
    _camera.glideTo(
      newTarget: vm.Vector3.zero(),
      newDistance: 540.0,
      newAzimuth: 0.55,
      newElevation: 0.38,
    );
    widget.onPlanetSelected?.call(null);
  }

  void _handleTapUp(TapUpDetails details, Size size) {
    if (!widget.enableUserInteraction) return;

    final vm.Matrix4 vpMatrix = _camera.computeViewProjectionMatrix(size.width / size.height);
    final ray = CosmicRaycaster3D.castRay(
      screenPoint: details.localPosition,
      screenSize: size,
      vpMatrix: vpMatrix,
    );

    if (ray == null) return;

    PlanetNode3D? closestHit;
    double minDistance = double.infinity;

    for (final planet in _planets) {
      // Hit testing with touch padding around the sphere
      final double hitRadius = math.max(planet.radius * 1.6, 16.0);
      final double? dist = ray.intersectSphere(planet.position, hitRadius);
      if (dist != null && dist < minDistance) {
        minDistance = dist;
        closestHit = planet;
      }
    }

    if (closestHit != null) {
      _selectPlanet(closestHit);
    } else {
      // Tapped deep space: dismiss selection
      _resetCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = Size(constraints.maxWidth, widget.height);
        final vm.Matrix4 vpMatrix = _camera.computeViewProjectionMatrix(size.width / size.height);

        // Compute screen coordinate for selected planet's floating HUD capsule
        if (_selectedPlanet != null) {
          _hudScreenPosition = _camera.projectToScreen(
            _selectedPlanet!.position + vm.Vector3(0.0, _selectedPlanet!.radius + 14.0, 0.0),
            vpMatrix,
            size,
          );
        } else {
          _hudScreenPosition = null;
        }

        return GestureDetector(
          onScaleStart: (details) {
            _lastFocalPoint = details.focalPoint;
            _baseDistance = _camera.distance;
          },
          onScaleUpdate: (details) {
            if (!widget.enableUserInteraction) return;

            // 1-Finger Orbit Drag
            if (_lastFocalPoint != null) {
              final double dx = details.focalPoint.dx - _lastFocalPoint!.dx;
              final double dy = details.focalPoint.dy - _lastFocalPoint!.dy;

              _camera.azimuth -= dx * 0.007;
              _camera.elevation = (_camera.elevation + dy * 0.007).clamp(-1.3, 1.3);

              _camera.azimuthVelocity = -dx * 0.05;
              _camera.elevationVelocity = dy * 0.05;

              _lastFocalPoint = details.focalPoint;
            }

            // Pinch-to-zoom
            if (details.scale != 1.0) {
              _camera.distance = (_baseDistance / details.scale).clamp(140.0, 1100.0);
            }
          },
          onTapUp: (details) => _handleTapUp(details, size),
          onDoubleTap: _resetCamera,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. Hardware-Accelerated 3D Viewport Canvas
              CustomPaint(
                size: size,
                painter: _CosmicScenePainter(
                  camera: _camera,
                  lighting: _lighting,
                  particles: _particles,
                  planets: _planets,
                  orbitCurves: _orbitCurves,
                  showOrbits: widget.showOrbits,
                  showVortex: widget.showVortex,
                  vortexExpansion: widget.vortexExpansion,
                ),
              ),

              // 2. Spatial HUD Floating Capsule (Anchored in 3D Space)
              if (_selectedPlanet != null && _hudScreenPosition != null)
                Positioned(
                  left: (_hudScreenPosition!.dx - 85).clamp(16.0, size.width - 186.0),
                  top: (_hudScreenPosition!.dy - 46).clamp(16.0, size.height - 70.0),
                  child: _buildSpatialHUDCapsule(_selectedPlanet!),
                ),

              // 3. 3D Spatial Navigation Controls
              if (widget.enableUserInteraction)
                Positioned(
                  right: 14,
                  bottom: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_selectedPlanet != null)
                        InkWell(
                          onTap: _resetCamera,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: Colors.white.withOpacity(0.18)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.refresh, size: 12, color: Colors.white70),
                                SizedBox(width: 4),
                                Text(
                                  "Reset View",
                                  style: TextStyle(
                                    fontFamily: 'Space Mono',
                                    fontSize: 9,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpatialHUDCapsule(PlanetNode3D planet) {
    return Container(
      width: 170,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A14).withOpacity(0.88),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: planet.baseColor.withOpacity(0.6), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: planet.baseColor.withOpacity(0.25),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    planet.glyph,
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: planet.baseColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    planet.name.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: planet.baseColor.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  planet.dignity,
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: planet.baseColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${planet.sign} ${planet.degreeStr}",
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 9,
                  color: Colors.white70,
                ),
              ),
              Text(
                planet.house,
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 9,
                  color: Color(0xFFE6C687),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            planet.nakshatra,
            style: TextStyle(
              fontFamily: 'Space Mono',
              fontSize: 8,
              color: Colors.white.withOpacity(0.45),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3D Scene CustomPainter (Hardware Accelerated via Impeller)
// -----------------------------------------------------------------------------

class _CosmicScenePainter extends CustomPainter {
  final CosmicCamera3D camera;
  final CosmicLighting3D lighting;
  final SpatialParticleSystem3D particles;
  final List<PlanetNode3D> planets;
  final List<OrbitCurve3D> orbitCurves;
  final bool showOrbits;
  final bool showVortex;
  final double vortexExpansion;

  _CosmicScenePainter({
    required this.camera,
    required this.lighting,
    required this.particles,
    required this.planets,
    required this.orbitCurves,
    required this.showOrbits,
    required this.showVortex,
    required this.vortexExpansion,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final double aspect = size.width / size.height;
    final vm.Matrix4 vpMatrix = camera.computeViewProjectionMatrix(aspect);
    final vm.Vector3 camPos = camera.position;

    // 1. Render Deep Space 3D Parallax Starfield
    final starPaint = Paint()..style = PaintingStyle.fill;
    for (final star in particles.stars) {
      final screenOffset = camera.projectToScreen(star.position, vpMatrix, size);
      if (screenOffset != null) {
        // Perspective depth scale
        final double dist = (star.position - camPos).length;
        final double scale = (800.0 / dist).clamp(0.4, 2.5);
        final double alpha = (math.sin(star.phase) * 0.3 + 0.7).clamp(0.2, 1.0);
        starPaint.color = star.color.withOpacity(alpha);
        canvas.drawCircle(screenOffset, star.radius * scale, starPaint);
      }
    }

    // 2. Render 3D Keplerian Orbital Curves
    if (showOrbits) {
      final orbitPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      for (final orbit in orbitCurves) {
        orbitPaint.color = orbit.pathColor;
        final path = Path();
        bool started = false;

        for (final pt in orbit.points) {
          final screenPt = camera.projectToScreen(pt, vpMatrix, size);
          if (screenPt != null) {
            if (!started) {
              path.moveTo(screenPt.dx, screenPt.dy);
              started = true;
            } else {
              path.lineTo(screenPt.dx, screenPt.dy);
            }
          } else {
            started = false;
          }
        }
        if (started) canvas.drawPath(path, orbitPaint);
      }
    }

    // 3. Render 3D Central Volumetric Particle Vortex (Birth Chart Stellar Core)
    if (showVortex) {
      final vortexPaint = Paint()..style = PaintingStyle.fill;
      for (final p in particles.vortexParticles) {
        final screenPt = camera.projectToScreen(p.position, vpMatrix, size);
        if (screenPt != null) {
          final double dist = (p.position - camPos).length;
          final double scale = (450.0 / dist).clamp(0.5, 3.0);
          final double pulse = (math.sin(p.phase) * 0.35 + 0.65).clamp(0.2, 1.0);
          vortexPaint.color = p.color.withOpacity(pulse * 0.85);
          canvas.drawCircle(screenPt, p.radius * scale, vortexPaint);
        }
      }
    }

    // 4. Sort and Render 3D Celestial Bodies (Depth-Sorted Painter's Algorithm)
    final List<PlanetNode3D> sortedPlanets = List.from(planets)
      ..sort((a, b) {
        final double distA = (a.position - camPos).length2;
        final double distB = (b.position - camPos).length2;
        return distB.compareTo(distA); // Furthest first
      });

    for (final planet in sortedPlanets) {
      _renderPlanet3D(canvas, size, planet, vpMatrix, camPos);
    }
  }

  void _renderPlanet3D(
    Canvas canvas,
    Size size,
    PlanetNode3D planet,
    vm.Matrix4 vpMatrix,
    vm.Vector3 camPos,
  ) {
    final mesh = planet.mesh;
    final vm.Vector3 pCenter = planet.position;

    // Project center to screen
    final Offset? screenCenter = camera.projectToScreen(pCenter, vpMatrix, size);
    if (screenCenter == null) return;

    final double camDist = (pCenter - camPos).length;
    final double projectedRadius = (planet.radius * 500.0 / camDist).clamp(2.0, 150.0);

    // 1. Emissive atmospheric glow halo (for Sun and focused planets)
    if (planet.isSun || planet.isSelected) {
      final double haloRadius = projectedRadius * (planet.isSun ? 2.2 : 1.6);
      final haloPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            planet.emissiveColor.withOpacity(planet.isSun ? 0.65 : 0.45),
            planet.baseColor.withOpacity(planet.isSun ? 0.25 : 0.15),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: screenCenter, radius: haloRadius));
      canvas.drawCircle(screenCenter, haloRadius, haloPaint);
    }

    // 2. Transform vertices to world space and screen coordinates
    final List<Offset?> screenVerts = List.filled(mesh.vertices.length, null);
    final List<vm.Vector3> worldNorms = List.filled(mesh.normals.length, vm.Vector3.zero());

    // Compute axial rotation matrix
    final double cosRot = math.cos(planet.axialRotation);
    final double sinRot = math.sin(planet.axialRotation);

    for (int i = 0; i < mesh.vertices.length; ++i) {
      final v = mesh.vertices[i];
      // Axial spin around local Y
      final double rx = v.x * cosRot - v.z * sinRot;
      final double rz = v.x * sinRot + v.z * cosRot;
      final vm.Vector3 worldV = pCenter + vm.Vector3(rx, v.y, rz);

      screenVerts[i] = camera.projectToScreen(worldV, vpMatrix, size);

      final n = mesh.normals[i];
      final double rnx = n.x * cosRot - n.z * sinRot;
      final double rnz = n.x * sinRot + n.z * cosRot;
      worldNorms[i] = vm.Vector3(rnx, n.y, rnz);
    }

    // 3. Render 3D shaded polygon faces
    final facePaint = Paint()..style = PaintingStyle.fill;
    final faceStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.4
      ..color = Colors.black12;

    for (final face in mesh.faces) {
      final p0 = screenVerts[face.i0];
      final p1 = screenVerts[face.i1];
      final p2 = screenVerts[face.i2];

      if (p0 == null || p1 == null || p2 == null) continue;

      // Backface culling in 2D screen space: cross product of edges
      final double cross = (p1.dx - p0.dx) * (p2.dy - p0.dy) - (p1.dy - p0.dy) * (p2.dx - p0.dx);
      if (cross >= 0.0) continue; // Face points away from viewer

      // Compute physically-based lighting
      final n0 = worldNorms[face.i0];
      final faceColor = lighting.shadeFace(
        worldVertex: pCenter,
        worldNormal: n0,
        cameraPosition: camPos,
        baseColor: planet.baseColor,
        emissiveColor: planet.emissiveColor,
        specularPower: planet.mesh.specularPower,
        isSun: planet.isSun,
      );

      final path = Path()
        ..moveTo(p0.dx, p0.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..close();

      facePaint.color = faceColor;
      canvas.drawPath(path, facePaint);
      canvas.drawPath(path, faceStroke);
    }

    // 4. Render Saturn's 3D Rings
    if (planet.hasRings && planet.ringsMesh != null) {
      _renderSaturnRings(canvas, size, planet, vpMatrix, camPos);
    }

    // 5. Selection pulse indicator ring
    if (planet.isSelected) {
      final pulsePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = planet.baseColor;
      canvas.drawCircle(screenCenter, projectedRadius + 6.0, pulsePaint);
    }
  }

  void _renderSaturnRings(
    Canvas canvas,
    Size size,
    PlanetNode3D planet,
    vm.Matrix4 vpMatrix,
    vm.Vector3 camPos,
  ) {
    final ringMesh = planet.ringsMesh!;
    final vm.Vector3 pCenter = planet.position;
    final ringPaint = Paint()..style = PaintingStyle.fill;

    // Saturn's axial ring tilt (approx 26.7 degrees)
    const double tilt = 26.7 * math.pi / 180.0;
    final double cosTilt = math.cos(tilt);
    final double sinTilt = math.sin(tilt);

    final List<Offset?> screenVerts = List.filled(ringMesh.vertices.length, null);
    for (int i = 0; i < ringMesh.vertices.length; ++i) {
      final v = ringMesh.vertices[i];
      final double ry = v.y * cosTilt - v.z * sinTilt;
      final double rz = v.y * sinTilt + v.z * cosTilt;
      final vm.Vector3 worldV = pCenter + vm.Vector3(v.x, ry, rz);
      screenVerts[i] = camera.projectToScreen(worldV, vpMatrix, size);
    }

    ringPaint.color = planet.baseColor.withOpacity(0.5);
    for (final face in ringMesh.faces) {
      final p0 = screenVerts[face.i0];
      final p1 = screenVerts[face.i1];
      final p2 = screenVerts[face.i2];

      if (p0 == null || p1 == null || p2 == null) continue;

      final path = Path()
        ..moveTo(p0.dx, p0.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..close();

      canvas.drawPath(path, ringPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CosmicScenePainter oldDelegate) => true;
}
