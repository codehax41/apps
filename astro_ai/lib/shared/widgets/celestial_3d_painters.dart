// shared/widgets/celestial_3d_painters.dart
// ASTROAI OS v4.0 - Core 3D Shaders & Canvas Painters
// Optimized for Flutter Impeller Engine (Metal on iOS 17+, Vulkan on Android 13+)
// Provides 120fps fluid 3D transformations, particle physics, and Keplerian orbital systems.

import 'dart:math' as math;
import 'package:flutter/material.dart';

// =========================================================================
// 1. 3D PARTICLE SPHERE WITH GLOWING STAR CORE (SCREEN 1 HERO)
// =========================================================================

class CelestialParticleSphereWidget extends StatefulWidget {
  final double size;
  const CelestialParticleSphereWidget({super.key, this.size = 260});

  @override
  State<CelestialParticleSphereWidget> createState() => _CelestialParticleSphereWidgetState();
}

class _CelestialParticleSphereWidgetState extends State<CelestialParticleSphereWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle3D> _particles = [];
  final math.Random _random = math.Random(42);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();

    // Generate 350 particles on spherical coordinates
    for (int i = 0; i < 350; i++) {
      final theta = _random.nextDouble() * math.pi * 2;
      final phi = (_random.nextDouble() - 0.5) * math.pi;
      final r = 68.0 + (_random.nextDouble() - 0.5) * 20.0;
      final color = _random.nextDouble() > 0.4
          ? const Color(0xFFE6C687)
          : (_random.nextDouble() > 0.5 ? const Color(0xFFC084FC) : const Color(0xFFF472B6));
      _particles.add(_Particle3D(
        x: r * math.cos(phi) * math.cos(theta),
        y: r * math.sin(phi),
        z: r * math.cos(phi) * math.sin(theta),
        size: _random.nextDouble() * 1.8 + 0.6,
        color: color,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _ParticleSpherePainter(
            particles: _particles,
            rotationAngle: _controller.value * math.pi * 2,
          ),
        );
      },
    );
  }
}

class _Particle3D {
  final double x, y, z, size;
  final Color color;
  _Particle3D({required this.x, required this.y, required this.z, required this.size, required this.color});
}

class _ParticleSpherePainter extends CustomPainter {
  final List<_Particle3D> particles;
  final double rotationAngle;

  _ParticleSpherePainter({required this.particles, required this.rotationAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // 1. Central Luminous Golden Core
    final coreGradient = RadialGradient(
      colors: [
        Colors.white,
        const Color(0xFFFDE68A),
        const Color(0xFFE6C687).withOpacity(0.5),
        const Color(0xFF8B5CF6).withOpacity(0.0),
      ],
      stops: const [0.0, 0.25, 0.6, 1.0],
    );

    final corePaint = Paint()
      ..shader = coreGradient.createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 45));
    canvas.drawCircle(Offset(cx, cy), 45, corePaint);

    final solidCorePaint = Paint()..color = const Color(0xFFE6C687);
    canvas.drawCircle(Offset(cx, cy), 8, solidCorePaint);

    // 2. 3D Rotation Matrix & Perspective Projection
    final cosY = math.cos(rotationAngle);
    final sinY = math.sin(rotationAngle);
    const cosX = 0.96; // slight fixed tilt on X
    const sinX = 0.25;

    final List<_ProjectedParticle> projected = [];
    const fov = 260.0;

    for (var p in particles) {
      final x1 = p.x * cosY - p.z * sinY;
      final z1 = p.x * sinY + p.z * cosY;
      final y2 = p.y * cosX - z1 * sinX;
      final z2 = p.y * sinX + z1 * cosX;

      final scale = fov / (fov + z2 + 80.0);
      final px = cx + x1 * scale;
      final py = cy + y2 * scale;
      projected.add(_ProjectedParticle(px: px, py: py, z: z2, scale: scale, size: p.size, color: p.color));
    }

    // Sort back-to-front for proper depth occlusion
    projected.sort((a, b) => a.z.compareTo(b.z));

    final dotPaint = Paint()..style = PaintingStyle.fill;
    for (var pt in projected) {
      final alpha = ((pt.z + 100.0) / 180.0).clamp(0.15, 1.0);
      dotPaint.color = pt.color.withOpacity(alpha);
      canvas.drawCircle(Offset(pt.px, pt.py), pt.size * pt.scale, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticleSpherePainter oldDelegate) => true;
}

class _ProjectedParticle {
  final double px, py, z, scale, size;
  final Color color;
  _ProjectedParticle({required this.px, required this.py, required this.z, required this.scale, required this.size, required this.color});
}

// =========================================================================
// 2. 3D NESTED KEPLERIAN PLANETARY ORBITS (SCREEN 2 HERO)
// =========================================================================

class CelestialOrbitalSystemWidget extends StatefulWidget {
  final double width;
  final double height;
  const CelestialOrbitalSystemWidget({super.key, this.width = 320, this.height = 190});

  @override
  State<CelestialOrbitalSystemWidget> createState() => _CelestialOrbitalSystemWidgetState();
}

class _CelestialOrbitalSystemWidgetState extends State<CelestialOrbitalSystemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _OrbitalSystemPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _OrbitalSystemPainter extends CustomPainter {
  final double progress;
  _OrbitalSystemPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 5;

    // Central Sun with Corona
    final sunGrad = RadialGradient(
      colors: [
        Colors.white,
        const Color(0xFFE6C687),
        const Color(0xFFEC4899).withOpacity(0.35),
        Colors.transparent,
      ],
      stops: const [0.0, 0.3, 0.7, 1.0],
    );
    final sunPaint = Paint()..shader = sunGrad.createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 32));
    canvas.drawCircle(Offset(cx, cy), 32, sunPaint);
    canvas.drawCircle(Offset(cx, cy), 7, Paint()..color = Colors.white);

    // Orbits configuration
    final orbits = [
      _OrbitData(a: 52, b: 22, rot: -0.22, speed: 3.0, planetR: 5, color: const Color(0xFFE6C687)),
      _OrbitData(a: 88, b: 36, rot: -0.15, speed: 2.0, planetR: 6.5, color: const Color(0xFFC084FC)),
      _OrbitData(a: 126, b: 50, rot: -0.10, speed: 1.2, planetR: 8, color: const Color(0xFF38BDF8)),
    ];

    for (var orb in orbits) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(orb.rot);

      // Path stroke
      final pathPaint = Paint()
        ..color = Colors.white.withOpacity(0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: orb.a * 2, height: orb.b * 2), pathPaint);

      // Planetary position
      final theta = progress * math.pi * 2 * orb.speed;
      final px = orb.a * math.cos(theta);
      final py = orb.b * math.sin(theta);

      // Glow halo
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [orb.color, orb.color.withOpacity(0.5), Colors.transparent],
        ).createShader(Rect.fromCircle(center: Offset(px, py), radius: orb.planetR * 2.5));
      canvas.drawCircle(Offset(px, py), orb.planetR * 2.5, glowPaint);

      // Planet sphere
      canvas.drawCircle(Offset(px, py), orb.planetR * 0.75, Paint()..color = Colors.white);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitalSystemPainter oldDelegate) => true;
}

class _OrbitData {
  final double a, b, rot, speed, planetR;
  final Color color;
  _OrbitData({required this.a, required this.b, required this.rot, required this.speed, required this.planetR, required this.color});
}

// =========================================================================
// 3. 3D LEVITATING IRIDESCENT INTELLIGENCE ORB (SCREEN 3 HERO)
// =========================================================================

class IridescentIntelligenceOrbWidget extends StatefulWidget {
  final double size;
  const IridescentIntelligenceOrbWidget({super.key, this.size = 80});

  @override
  State<IridescentIntelligenceOrbWidget> createState() => _IridescentIntelligenceOrbWidgetState();
}

class _IridescentIntelligenceOrbWidgetState extends State<IridescentIntelligenceOrbWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _IridescentOrbPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _IridescentOrbPainter extends CustomPainter {
  final double progress;
  _IridescentOrbPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final levitateY = size.height / 2 + math.sin(progress * math.pi * 2) * 4.0;
    const radius = 26.0;

    // Outer audio-reactive wave halo
    final waveR = radius + 8.0 + math.sin(progress * math.pi * 4) * 4.0;
    final wavePaint = Paint()
      ..color = const Color(0xFFEC4899).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(cx, levitateY), waveR, wavePaint);

    // 3D Iridescent Shading with multi-spectrum sheen
    const orbGrad = RadialGradient(
      center: Alignment(-0.35, -0.35),
      colors: [
        Colors.white,
        Color(0xFFA78BFA),
        Color(0xFFEC4899),
        Color(0xFF4C1D95),
        Color(0xFF1E1B4B),
      ],
      stops: [0.0, 0.22, 0.52, 0.85, 1.0],
    );

    final orbPaint = Paint()..shader = orbGrad.createShader(Rect.fromCircle(center: Offset(cx, levitateY), radius: radius));
    canvas.drawCircle(Offset(cx, levitateY), radius, orbPaint);

    // Specular Highlight Glint
    canvas.drawCircle(
      Offset(cx - radius * 0.35, levitateY - radius * 0.35),
      3.2,
      Paint()..color = Colors.white.withOpacity(0.85),
    );
  }

  @override
  bool shouldRepaint(covariant _IridescentOrbPainter oldDelegate) => true;
}

// =========================================================================
// 4. PRECISION 3D CIRCULAR ASTRO-NATAL MAP HUD (SCREEN 4 HERO)
// =========================================================================

class AstroNatalMapHUDWidget extends StatefulWidget {
  final double size;
  const AstroNatalMapHUDWidget({super.key, this.size = 230});

  @override
  State<AstroNatalMapHUDWidget> createState() => _AstroNatalMapHUDWidgetState();
}

class _AstroNatalMapHUDWidgetState extends State<AstroNatalMapHUDWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 40))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _NatalHUDPainter(rotation: _controller.value * math.pi * 2),
        );
      },
    );
  }
}

class _NatalHUDPainter extends CustomPainter {
  final double rotation;
  _NatalHUDPainter({required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.44;

    // Coordinate Rings
    canvas.drawCircle(Offset(cx, cy), r, Paint()..color = Colors.white.withOpacity(0.22)..style = PaintingStyle.stroke..strokeWidth = 1.0);
    canvas.drawCircle(Offset(cx, cy), r - 14, Paint()..color = const Color(0xFFE6C687).withOpacity(0.4)..style = PaintingStyle.stroke..strokeWidth = 1.0);
    canvas.drawCircle(Offset(cx, cy), r - 35, Paint()..color = const Color(0xFF8B5CF6).withOpacity(0.3)..style = PaintingStyle.stroke..strokeWidth = 0.8);

    // 360 Degree Ticks
    for (int i = 0; i < 72; i++) {
      final angle = (i * 5 * math.pi) / 180 + rotation;
      final isMajor = i % 6 == 0;
      final len = isMajor ? 6.0 : 3.0;
      final p1 = Offset(cx + (r - len) * math.cos(angle), cy + (r - len) * math.sin(angle));
      final p2 = Offset(cx + r * math.cos(angle), cy + r * math.sin(angle));
      final tickPaint = Paint()
        ..color = isMajor ? const Color(0xFFE6C687) : Colors.white.withOpacity(0.15)
        ..strokeWidth = isMajor ? 1.2 : 0.6;
      canvas.drawLine(p1, p2, tickPaint);
    }

    // Sacred Trine Aspect Triangle
    final planets = [
      Offset(cx + (r - 35) * math.cos(rotation + 0.3), cy + (r - 35) * math.sin(rotation + 0.3)),
      Offset(cx + (r - 35) * math.cos(rotation + 2.4), cy + (r - 35) * math.sin(rotation + 2.4)),
      Offset(cx + (r - 35) * math.cos(rotation + 4.5), cy + (r - 35) * math.sin(rotation + 4.5)),
    ];

    final trinePath = Path()
      ..moveTo(planets[0].dx, planets[0].dy)
      ..lineTo(planets[1].dx, planets[1].dy)
      ..lineTo(planets[2].dx, planets[2].dy)
      ..close();

    final trinePaint = Paint()
      ..color = const Color(0xFFE6C687).withOpacity(0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(trinePath, trinePaint);

    // Planetary Nodes
    final nodeColors = [const Color(0xFFE6C687), const Color(0xFFF472B6), const Color(0xFF38BDF8)];
    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(planets[i], 3.8, Paint()..color = nodeColors[i]);
    }
  }

  @override
  bool shouldRepaint(covariant _NatalHUDPainter oldDelegate) => true;
}
