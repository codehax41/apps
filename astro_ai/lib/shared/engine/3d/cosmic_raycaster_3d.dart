// lib/shared/engine/3d/cosmic_raycaster_3d.dart
// ASTROAI OS v5.0 - True 3D Screen-to-World Raycaster for Spatial Object Picking

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class Ray3D {
  final Vector3 origin;
  final Vector3 direction;

  Ray3D({required this.origin, required this.direction});

  // Tests intersection with a 3D sphere at center C with radius r
  // Returns distance t from ray origin, or null if no hit
  double? intersectSphere(Vector3 center, double radius) {
    final Vector3 oc = origin - center;
    final double a = direction.dot(direction);
    final double b = 2.0 * oc.dot(direction);
    final double c = oc.dot(oc) - radius * radius;
    final double discriminant = b * b - 4.0 * a * c;

    if (discriminant < 0.0) {
      return null; // Ray misses sphere
    }

    final double sqrtD = math.sqrt(discriminant);
    final double t0 = (-b - sqrtD) / (2.0 * a);
    final double t1 = (-b + sqrtD) / (2.0 * a);

    if (t0 > 0.0) return t0;
    if (t1 > 0.0) return t1;
    return null;
  }
}

class CosmicRaycaster3D {
  // Unprojects 2D screen coordinate to a 3D Ray in world space
  static Ray3D? castRay({
    required Offset screenPoint,
    required Size screenSize,
    required Matrix4 vpMatrix,
  }) {
    final Matrix4? invVp = Matrix4.tryInvert(vpMatrix);
    if (invVp == null) return null;

    // Convert screen point to Normalized Device Coordinates [-1, 1]
    final double ndcX = (screenPoint.dx / screenSize.width) * 2.0 - 1.0;
    final double ndcY = 1.0 - (screenPoint.dy / screenSize.height) * 2.0;

    // Near plane point (Z = -1 in NDC)
    final Vector4 nearClip = Vector4(ndcX, ndcY, -1.0, 1.0);
    final Vector4 nearWorld = invVp.transform(nearClip);
    if (nearWorld.w == 0.0) return null;
    final Vector3 pNear = Vector3(
      nearWorld.x / nearWorld.w,
      nearWorld.y / nearWorld.w,
      nearWorld.z / nearWorld.w,
    );

    // Far plane point (Z = 1 in NDC)
    final Vector4 farClip = Vector4(ndcX, ndcY, 1.0, 1.0);
    final Vector4 farWorld = invVp.transform(farClip);
    if (farWorld.w == 0.0) return null;
    final Vector3 pFar = Vector3(
      farWorld.x / farWorld.w,
      farWorld.y / farWorld.w,
      farWorld.z / farWorld.w,
    );

    final Vector3 direction = (pFar - pNear).normalized();
    return Ray3D(origin: pNear, direction: direction);
  }
}
