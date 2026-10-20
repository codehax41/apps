// lib/shared/engine/3d/cosmic_lighting_3d.dart
// ASTROAI OS v5.0 - Physically-Based Blinn-Phong Lighting Pipeline with Emissive Star Glow

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class CosmicLighting3D {
  final Vector3 sunPosition;
  final Color sunLightColor;
  final double ambientIntensity;
  final double sunIntensity;

  CosmicLighting3D({
    Vector3? sunPosition,
    this.sunLightColor = const Color(0xFFFFF3D6), // Warm solar champagne
    this.ambientIntensity = 0.22,
    this.sunIntensity = 1.0,
  }) : sunPosition = sunPosition ?? Vector3.zero();

  // Computes shaded color for a 3D vertex/face
  Color shadeFace({
    required Vector3 worldVertex,
    required Vector3 worldNormal,
    required Vector3 cameraPosition,
    required Color baseColor,
    Color emissiveColor = Colors.transparent,
    double specularPower = 20.0,
    bool isSun = false,
  }) {
    if (isSun) {
      // The Sun is a pure self-luminous emissive stellar sphere
      return baseColor;
    }

    // Light direction: from vertex to Sun
    final Vector3 L = (sunPosition - worldVertex);
    final double distSq = L.length2;
    if (distSq > 0.0001) L.normalize();

    // Normal vector
    final Vector3 N = worldNormal.normalized();

    // View direction: from vertex to Camera
    final Vector3 V = (cameraPosition - worldVertex).normalized();

    // Diffuse term: Lambertian N . L
    final double NdotL = math.max(0.0, N.dot(L));

    // Specular term: Blinn-Phong N . H
    final Vector3 H = (L + V).normalized();
    final double NdotH = math.max(0.0, N.dot(H));
    final double specular = (NdotL > 0.0) ? math.pow(NdotH, specularPower).toDouble() : 0.0;

    // Headlight subtle fill from camera
    final double headlight = math.max(0.0, N.dot(V)) * 0.15;

    // Total intensity
    final double totalDiffuse = (ambientIntensity + NdotL * sunIntensity + headlight).clamp(0.0, 1.3);

    // Channel modulation
    final double r = (baseColor.red * totalDiffuse + 255.0 * specular * 0.4 + emissiveColor.red).clamp(0.0, 255.0);
    final double g = (baseColor.green * totalDiffuse + 255.0 * specular * 0.4 + emissiveColor.green).clamp(0.0, 255.0);
    final double b = (baseColor.blue * totalDiffuse + 255.0 * specular * 0.4 + emissiveColor.blue).clamp(0.0, 255.0);

    return Color.fromARGB(baseColor.alpha, r.toInt(), g.toInt(), b.toInt());
  }
}
