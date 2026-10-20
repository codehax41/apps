// lib/shared/engine/3d/planet_node_3d.dart
// ASTROAI OS v5.0 - True 3D Celestial Body Node with Keplerian Orbits, Axial Rotation & Telemetry Binding

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'celestial_mesh_3d.dart';

class PlanetNode3D {
  final String id;
  final String name;
  final String glyph;
  final String sign;
  final String degreeStr;
  final String house;
  final String dignity;
  final String nakshatra;
  final double radius;
  final double orbitRadiusX;
  final double orbitRadiusZ;
  final double orbitInclination;
  final double orbitSpeed;
  final Color baseColor;
  final Color emissiveColor;
  final bool isSun;
  final bool hasRings;

  double orbitAngle;
  double axialRotation = 0.0;
  Vector3 position = Vector3.zero();
  bool isSelected = false;

  late final CelestialMesh3D mesh;
  CelestialMesh3D? ringsMesh;

  PlanetNode3D({
    required this.id,
    required this.name,
    required this.glyph,
    required this.sign,
    required this.degreeStr,
    required this.house,
    required this.dignity,
    required this.nakshatra,
    required this.radius,
    required this.orbitRadiusX,
    required this.orbitRadiusZ,
    required this.orbitInclination,
    required this.orbitSpeed,
    required this.baseColor,
    this.emissiveColor = Colors.transparent,
    this.isSun = false,
    this.hasRings = false,
    double initialAngle = 0.0,
  }) : orbitAngle = initialAngle {
    // Generate true 3D sphere geometry
    final int rings = isSun ? 24 : 16;
    final int slices = isSun ? 24 : 16;

    mesh = CelestialMesh3D.createSphere(
      radius: radius,
      rings: rings,
      slices: slices,
      color: baseColor,
      emissiveColor: emissiveColor,
      specularPower: isSun ? 1.0 : 28.0,
    );

    if (hasRings) {
      ringsMesh = CelestialMesh3D.createRingMesh(
        innerRadius: radius * 1.5,
        outerRadius: radius * 2.6,
        segments: 48,
        color: baseColor.withOpacity(0.55),
      );
    }

    updatePosition(0.0);
  }

  // Updates Keplerian orbital coordinates and axial spin
  void updatePosition(double dt) {
    if (isSun) {
      position = Vector3.zero();
      axialRotation += dt * 0.15;
      return;
    }

    orbitAngle += orbitSpeed * dt;
    axialRotation += dt * 1.2;

    final double cosAngle = math.cos(orbitAngle);
    final double rawZ = orbitRadiusZ * math.sin(orbitAngle);
    final double cosInc = math.cos(orbitInclination);
    final double sinInc = math.sin(orbitInclination);

    final double x = orbitRadiusX * cosAngle;
    final double y = rawZ * sinInc;
    final double z = rawZ * cosInc;

    position = Vector3(x, y, z);
  }
}
