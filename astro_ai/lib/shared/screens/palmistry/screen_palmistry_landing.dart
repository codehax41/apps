// lib/shared/screens/palmistry/screen_palmistry_landing.dart
// ASTROAI OS v5.0 - Cinematic AI Palmistry Entry Portal

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../engine/3d/palm_scanner_3d_view.dart';
import 'screen_palm_capture.dart';
import 'screen_palm_history.dart';

class ScreenPalmistryLanding extends StatelessWidget {
  const ScreenPalmistryLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05050A),
      body: Stack(
        children: [
          // Background Cosmic Nebula Atmosphere
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.2),
                  radius: 1.1,
                  colors: [
                    Color(0xFF221345),
                    Color(0xFF0F0B20),
                    Color(0xFF05050A),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Central Hero 3D Palm Visualization
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: 20,
            right: 20,
            height: MediaQuery.of(context).size.height * 0.44,
            child: const PalmScanner3DView(
              isLeft: true,
              isScanning: true,
              scanningStage: 2,
              showMounts: true,
              showGrid: true,
              enableGestures: true,
            ),
          ),

          // Top Header Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("✦ ", style: TextStyle(color: Color(0xFFFFD700), fontSize: 12)),
                        Text(
                          "PREMIUM 3D SCAN",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 10,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFD700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenPalmHistory(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: const Icon(Icons.history, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Content Dossier
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "AI PALMISTRY",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 12,
                    letterSpacing: 3.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00E5FF),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Discover the story\nwritten in your hands.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "A bilateral cosmic mapping of classical Samudrika lines, planetary mounts, and subconscious potential.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 24),

                // Privacy Trust Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_outline, size: 14, color: Color(0xFF00FF66)),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          "Private & Encrypted • Purge data anytime",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 9,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Begin CTA Button
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScreenPalmCapture(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF9D4EDD),
                          Color(0xFF00E5FF),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00E5FF).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("✦ ", style: TextStyle(color: Colors.white, fontSize: 16)),
                          Text(
                            "BEGIN PALM READING",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 13,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
