// lib/shared/engine/3d/cosmic_camera_3d.dart
// ASTROAI OS v5.0 - True 3D Perspective Camera System with Quaternion Orbit & Glide Interpolation

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class CosmicCamera3D {
  // Spherical orbit coordinates
  double azimuth; // Horizontal rotation angle (radians)
  double elevation; // Vertical elevation angle (radians, clamped to avoid gimbal lock)
  double distance; // Distance from target

  // Camera target (look-at focal point in 3D world space)
  Vector3 target;

  // Projection frustum parameters
  double fovRadians;
  double nearPlane;
  double farPlane;

  // Inertia velocities
  double azimuthVelocity = 0.0;
  double elevationVelocity = 0.0;
  double zoomVelocity = 0.0;

  // Programmatic glide animation state
  bool isGliding = false;
  double glideProgress = 0.0;
  Vector3 glideStartTarget = Vector3.zero();
  Vector3 glideEndTarget = Vector3.zero();
  double glideStartDistance = 400.0;
  double glideEndDistance = 400.0;
  double glideStartAzimuth = 0.0;
  double glideEndAzimuth = 0.0;
  double glideStartElevation = 0.3;
  double glideEndElevation = 0.3;

  CosmicCamera3D({
    this.azimuth = 0.4,
    this.elevation = 0.35,
    this.distance = 520.0,
    Vector3? target,
    this.fovRadians = 60.0 * math.pi / 180.0,
    this.nearPlane = 1.0,
    this.farPlane = 5000.0,
  }) : target = target ?? Vector3.zero();

  // Computes the eye (camera position) in 3D cartesian coordinates
  Vector3 get position {
    final double cosElev = math.cos(elevation);
    final double x = target.x + distance * cosElev * math.sin(azimuth);
    final double y = target.y + distance * math.sin(elevation);
    final double z = target.z + distance * cosElev * math.cos(azimuth);
    return Vector3(x, y, z);
  }

  // Generates the View Matrix: LookAt(position, target, up)
  Matrix4 computeViewMatrix() {
    final Vector3 eye = position;
    final Vector3 up = Vector3(0.0, 1.0, 0.0);
    return makeViewMatrix(eye, target, up);
  }

  // Generates the Perspective Projection Matrix
  Matrix4 computeProjectionMatrix(double aspectRatio) {
    return makePerspectiveMatrix(fovRadians, aspectRatio, nearPlane, farPlane);
  }

  // Combined View-Projection Matrix: M_vp = M_proj * M_view
  Matrix4 computeViewProjectionMatrix(double aspectRatio) {
    final Matrix4 proj = computeProjectionMatrix(aspectRatio);
    final Matrix4 view = computeViewMatrix();
    return proj * view;
  }

  // Update inertia damping and programmatic glide interpolation
  void update(double dt) {
    if (isGliding) {
      glideProgress += dt * 2.2; // ~450ms smooth curve
      if (glideProgress >= 1.0) {
        glideProgress = 1.0;
        isGliding = false;
      }
      // Ease-out cubic curve: 1 - (1-t)^3
      final double t = 1.0 - math.pow(1.0 - glideProgress, 3.0);
      target = glideStartTarget + (glideEndTarget - glideStartTarget) * t;
      distance = glideStartDistance + (glideEndDistance - glideStartDistance) * t;
      azimuth = glideStartAzimuth + (glideEndAzimuth - glideStartAzimuth) * t;
      elevation = glideStartElevation + (glideEndElevation - glideStartElevation) * t;
      return;
    }

    // Apply inertia damping
    azimuth += azimuthVelocity * dt;
    elevation += elevationVelocity * dt;
    distance += zoomVelocity * dt;

    // Damping decay
    azimuthVelocity *= 0.90;
    elevationVelocity *= 0.90;
    zoomVelocity *= 0.85;

    // Clamp elevation to prevent pole flip
    elevation = elevation.clamp(-1.3, 1.3);
    // Clamp zoom distance
    distance = distance.clamp(140.0, 1200.0);
  }

  // Smoothly glides the camera to focus on an object in 3D space
  void glideTo({
    required Vector3 newTarget,
    required double newDistance,
    double? newAzimuth,
    double? newElevation,
  }) {
    isGliding = true;
    glideProgress = 0.0;
    glideStartTarget = target.clone();
    glideEndTarget = newTarget.clone();
    glideStartDistance = distance;
    glideEndDistance = newDistance.clamp(140.0, 1200.0);
    glideStartAzimuth = azimuth;
    glideEndAzimuth = newAzimuth ?? azimuth;
    glideStartElevation = elevation;
    glideEndElevation = (newElevation ?? elevation).clamp(-1.3, 1.3);
    azimuthVelocity = 0.0;
    elevationVelocity = 0.0;
    zoomVelocity = 0.0;
  }

  // Project a 3D world position (X, Y, Z) to 2D screen coordinate (x, y)
  Offset? projectToScreen(Vector3 worldPos, Matrix4 vpMatrix, Size screenSize) {
    final Vector4 clip = vpMatrix.transform(Vector4(worldPos.x, worldPos.y, worldPos.z, 1.0));
    if (clip.w <= 0.0) return null; // Behind camera plane

    // Perspective divide
    final double ndcX = clip.x / clip.w;
    final double ndcY = clip.y / clip.w;
    final double ndcZ = clip.z / clip.w;

    if (ndcZ < -1.0 || ndcZ > 1.0) return null; // Outside depth bounds

    final double screenX = (ndcX + 1.0) * 0.5 * screenSize.width;
    final double screenY = (1.0 - ndcY) * 0.5 * screenSize.height;

    return Offset(screenX, screenY);
  }
}
