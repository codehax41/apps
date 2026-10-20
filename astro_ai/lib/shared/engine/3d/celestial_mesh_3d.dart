// lib/shared/engine/3d/celestial_mesh_3d.dart
// ASTROAI OS v5.0 - True 3D Geometry Generators (UV Spheres, 3D Orbital Curves & Planetary Rings)

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class TriangleFace3D {
  final int i0;
  final int i1;
  final int i2;
  double depth = 0.0; // Calculated during render pass for painter's algorithm

  TriangleFace3D(this.i0, this.i1, this.i2);
}

class CelestialMesh3D {
  final List<Vector3> vertices;
  final List<Vector3> normals;
  final List<TriangleFace3D> faces;
  final Color baseColor;
  final Color emissiveColor;
  final double specularPower;

  CelestialMesh3D({
    required this.vertices,
    required this.normals,
    required this.faces,
    required this.baseColor,
    this.emissiveColor = Colors.transparent,
    this.specularPower = 16.0,
  });

  // Generates a true 3D UV Sphere
  static CelestialMesh3D createSphere({
    required double radius,
    required int rings,
    required int slices,
    required Color color,
    Color emissiveColor = Colors.transparent,
    double specularPower = 24.0,
  }) {
    final List<Vector3> verts = [];
    final List<Vector3> norms = [];
    final List<TriangleFace3D> faces = [];

    // North pole vertex
    verts.add(Vector3(0.0, radius, 0.0));
    norms.add(Vector3(0.0, 1.0, 0.0));

    // Middle latitude rings
    for (int r = 1; r < rings; ++r) {
      final double phi = math.pi * r / rings;
      final double sinPhi = math.sin(phi);
      final double cosPhi = math.cos(phi);

      for (int s = 0; s < slices; ++s) {
        final double theta = 2.0 * math.pi * s / slices;
        final double sinTheta = math.sin(theta);
        final double cosTheta = math.cos(theta);

        final double x = radius * sinPhi * cosTheta;
        final double y = radius * cosPhi;
        final double z = radius * sinPhi * sinTheta;

        verts.add(Vector3(x, y, z));
        norms.add(Vector3(sinPhi * cosTheta, cosPhi, sinPhi * sinTheta));
      }
    }

    // South pole vertex
    final int southPoleIndex = verts.length;
    verts.add(Vector3(0.0, -radius, 0.0));
    norms.add(Vector3(0.0, -1.0, 0.0));

    // North pole triangle cap
    for (int s = 0; s < slices; ++s) {
      const int i0 = 0;
      final int i1 = 1 + s;
      final int i2 = 1 + ((s + 1) % slices);
      faces.add(TriangleFace3D(i0, i1, i2));
    }

    // Body quads (split into 2 triangles each)
    for (int r = 0; r < rings - 2; ++r) {
      final int row1 = 1 + r * slices;
      final int row2 = 1 + (r + 1) * slices;

      for (int s = 0; s < slices; ++s) {
        final int nextS = (s + 1) % slices;
        final int a = row1 + s;
        final int b = row1 + nextS;
        final int c = row2 + nextS;
        final int d = row2 + s;

        faces.add(TriangleFace3D(a, b, c));
        faces.add(TriangleFace3D(a, c, d));
      }
    }

    // South pole triangle cap
    final int lastRow = 1 + (rings - 2) * slices;
    for (int s = 0; s < slices; ++s) {
      final int i0 = southPoleIndex;
      final int i1 = lastRow + ((s + 1) % slices);
      final int i2 = lastRow + s;
      faces.add(TriangleFace3D(i0, i1, i2));
    }

    return CelestialMesh3D(
      vertices: verts,
      normals: norms,
      faces: faces,
      baseColor: color,
      emissiveColor: emissiveColor,
      specularPower: specularPower,
    );
  }

  // Generates 3D Saturn Rings
  static CelestialMesh3D createRingMesh({
    required double innerRadius,
    required double outerRadius,
    required int segments,
    required Color color,
  }) {
    final List<Vector3> verts = [];
    final List<Vector3> norms = [];
    final List<TriangleFace3D> faces = [];

    for (int i = 0; i < segments; ++i) {
      final double theta = 2.0 * math.pi * i / segments;
      final double cosT = math.cos(theta);
      final double sinT = math.sin(theta);

      // Inner vertex
      verts.add(Vector3(innerRadius * cosT, 0.0, innerRadius * sinT));
      norms.add(Vector3(0.0, 1.0, 0.0));

      // Outer vertex
      verts.add(Vector3(outerRadius * cosT, 0.0, outerRadius * sinT));
      norms.add(Vector3(0.0, 1.0, 0.0));
    }

    for (int i = 0; i < segments; ++i) {
      final int nextI = (i + 1) % segments;
      final int i0 = i * 2;
      final int i1 = i * 2 + 1;
      final int i2 = nextI * 2 + 1;
      final int i3 = nextI * 2;

      faces.add(TriangleFace3D(i0, i1, i2));
      faces.add(TriangleFace3D(i0, i2, i3));
    }

    return CelestialMesh3D(
      vertices: verts,
      normals: norms,
      faces: faces,
      baseColor: color,
      specularPower: 12.0,
    );
  }
}

// 3D Orbital Path Curve
class OrbitCurve3D {
  final List<Vector3> points;
  final Color pathColor;
  final double radiusX;
  final double radiusZ;
  final double inclination; // Tilt angle in radians

  OrbitCurve3D({
    required this.radiusX,
    required this.radiusZ,
    required this.inclination,
    required this.pathColor,
    int segments = 96,
  }) : points = _generatePoints(radiusX, radiusZ, inclination, segments);

  static List<Vector3> _generatePoints(double rx, double rz, double inc, int segments) {
    final List<Vector3> pts = [];
    final double cosInc = math.cos(inc);
    final double sinInc = math.sin(inc);

    for (int i = 0; i <= segments; ++i) {
      final double angle = 2.0 * math.pi * i / segments;
      final double x = rx * math.cos(angle);
      final double rawZ = rz * math.sin(angle);
      final double y = rawZ * sinInc;
      final double z = rawZ * cosInc;
      pts.add(Vector3(x, y, z));
    }
    return pts;
  }
}
