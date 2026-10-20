// lib/shared/engine/3d/spatial_particle_system_3d.dart
// ASTROAI OS v5.0 - 3D Volumetric Particle Vortex & Deep Space Parallax Starfield

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class SpatialParticle3D {
  Vector3 position;
  final Vector3 basePosition;
  final double radius;
  final Color color;
  final double pulseSpeed;
  double phase;

  SpatialParticle3D({
    required this.position,
    required this.radius,
    required this.color,
    required this.pulseSpeed,
    required this.phase,
  }) : basePosition = position.clone();
}

class SpatialParticleSystem3D {
  final List<SpatialParticle3D> stars;
  final List<SpatialParticle3D> vortexParticles;

  SpatialParticleSystem3D({
    required this.stars,
    required this.vortexParticles,
  });

  // Creates the deep-space 3D starfield
  static SpatialParticleSystem3D create({
    int starCount = 350,
    int vortexCount = 400,
    double fieldRadius = 1400.0,
    double vortexRadius = 90.0,
  }) {
    final math.Random rng = math.Random(42);
    final List<SpatialParticle3D> starList = [];

    // 1. Deep space background stars (outer sphere shell)
    for (int i = 0; i < starCount; ++i) {
      final double theta = rng.nextDouble() * 2.0 * math.pi;
      final double phi = math.acos(2.0 * rng.nextDouble() - 1.0);
      final double r = fieldRadius * (0.6 + 0.4 * rng.nextDouble());

      final double x = r * math.sin(phi) * math.cos(theta);
      final double y = r * math.cos(phi);
      final double z = r * math.sin(phi) * math.sin(theta);

      final double starRadius = 0.8 + rng.nextDouble() * 1.6;
      final double brightness = 0.3 + rng.nextDouble() * 0.7;
      final Color col = rng.nextBool()
          ? Color.fromRGBO(255, 245, 230, brightness)
          : Color.fromRGBO(210, 220, 255, brightness);

      starList.add(SpatialParticle3D(
        position: Vector3(x, y, z),
        radius: starRadius,
        color: col,
        pulseSpeed: 1.0 + rng.nextDouble() * 3.0,
        phase: rng.nextDouble() * math.pi * 2,
      ));
    }

    // 2. Dense central cosmic identity vortex (for onboarding stellar core & Devi AI)
    final List<SpatialParticle3D> vortexList = [];
    for (int i = 0; i < vortexCount; ++i) {
      // Golden spiral distribution on sphere surface
      final double y = 1.0 - (i / (vortexCount - 1)) * 2.0; // from 1 to -1
      final double radiusAtY = math.sqrt(1.0 - y * y);
      final double phi = i * 2.399963229728653; // Golden ratio in radians

      final double r = vortexRadius * (0.85 + rng.nextDouble() * 0.3);
      final double x = math.cos(phi) * radiusAtY * r;
      final double z = math.sin(phi) * radiusAtY * r;

      // Color spectrum: ultraviolet, iridescent magenta, champagne gold
      final double t = rng.nextDouble();
      final Color col;
      if (t < 0.4) {
        col = const Color(0xFF8B5CF6); // Nebula violet
      } else if (t < 0.75) {
        col = const Color(0xFFF472B6); // Aurora pink
      } else {
        col = const Color(0xFFE6C687); // Champagne gold
      }

      vortexList.add(SpatialParticle3D(
        position: Vector3(x, y * r, z),
        radius: 1.0 + rng.nextDouble() * 1.5,
        color: col,
        pulseSpeed: 2.0 + rng.nextDouble() * 4.0,
        phase: rng.nextDouble() * math.pi * 2,
      ));
    }

    return SpatialParticleSystem3D(stars: starList, vortexParticles: vortexList);
  }

  // Updates particle rotational vortex and pulse
  void update(double dt, double vortexRotationAngle, {double expansionFactor = 1.0}) {
    final double cosR = math.cos(vortexRotationAngle);
    final double sinR = math.sin(vortexRotationAngle);

    for (final p in vortexParticles) {
      p.phase += dt * p.pulseSpeed;
      // Rotate base position around Y axis
      final double rx = p.basePosition.x * expansionFactor;
      final double ry = p.basePosition.y * expansionFactor;
      final double rz = p.basePosition.z * expansionFactor;

      final double x = rx * cosR - rz * sinR;
      final double z = rx * sinR + rz * cosR;

      // Subtle breathing float on Y
      final double breathe = math.sin(p.phase) * 2.0;
      p.position = Vector3(x, ry + breathe, z);
    }

    for (final s in stars) {
      s.phase += dt * s.pulseSpeed;
    }
  }
}
