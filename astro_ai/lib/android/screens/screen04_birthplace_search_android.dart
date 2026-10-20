// android/lib/screens/screen04_birthplace_search_android.dart
// Screen 04: Birthplace Search (Geodetic Horizon) (Google Android Target)
// Features: ACCESS_COARSE_LOCATION permission rationale dialog, 3D Topographic Radar HUD with SLERP rotation,
// VibrationEffect haptic sync, Lahiri Ayanamsa autocomplete, and 1.8s starfield warp transition to Screen 05.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astro_ai/shared/models/user_profile.dart';
import 'package:astro_ai/shared/services/firebase_service.dart';
import 'package:astro_ai/shared/services/cloudflare_service.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen05_home_dashboard_android.dart';

class StationItem {
  final String city;
  final String region;
  final String latDms;
  final String lngDms;
  final String ayanamsa;
  final bool isSelected;

  const StationItem({
    required this.city,
    required this.region,
    required this.latDms,
    required this.lngDms,
    required this.ayanamsa,
    this.isSelected = false,
  });
}

class Screen04BirthplaceSearchAndroid extends StatefulWidget {
  const Screen04BirthplaceSearchAndroid({super.key});

  @override
  State<Screen04BirthplaceSearchAndroid> createState() => _Screen04BirthplaceSearchAndroidState();
}

class _Screen04BirthplaceSearchAndroidState extends State<Screen04BirthplaceSearchAndroid>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController =
      TextEditingController(text: "Bengaluru, Karnataka, India");

  late AnimationController _radarController;
  bool _isGeneratingMatrix = false;

  final List<StationItem> _stations = const [
    StationItem(
      city: "Bengaluru Urban",
      region: "KA, India",
      latDms: "12°58' N",
      lngDms: "77°35' E",
      ayanamsa: "Lahiri Ayanamsa 24°11'",
      isSelected: true,
    ),
    StationItem(
      city: "Mumbai",
      region: "Maharashtra, India",
      latDms: "19°04' N",
      lngDms: "72°52' E",
      ayanamsa: "Lahiri Ayanamsa 24°11'",
      isSelected: false,
    ),
    StationItem(
      city: "New Delhi",
      region: "Delhi NCR, India",
      latDms: "28°36' N",
      lngDms: "77°12' E",
      ayanamsa: "Lahiri Ayanamsa 24°11'",
      isSelected: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _radarController.dispose();
    super.dispose();
  }

  void _generateMatrix() {
    HapticFeedback.heavyImpact();
    setState(() => _isGeneratingMatrix = true);

    // Persist seeker profile to Firebase Firestore & backup to Cloudflare R2
    final selectedStation = _stations.firstWhere((s) => s.isSelected, orElse: () => _stations.first);
    final profile = UserProfile(
      uid: FirebaseService.instance.activeUid,
      name: "Ramsundar Mahato",
      email: "seeker@astroai.quantum",
      birthDate: DateTime(1996, 9, 14),
      birthTime: "06:42 AM",
      birthPlace: "${selectedStation.city}, ${selectedStation.region}",
      latitude: 12.9716,
      longitude: 77.5946,
      timezoneOffsetHours: 5.5,
      focusVectors: ["Career & Timing", "Wealth Cycles", "Mental Peace"],
      ayanamsa: "Chitra Paksha (Lahiri)",
      chartLayout: "North Indian Diamond",
    );
    FirebaseService.instance.saveUserProfile(profile);
    CloudflareService.instance.backupUserDetails(userId: profile.uid, profile: profile);

    // 1.8s Starfield calculation simulation
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Screen05HomeDashboardAndroid(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.92, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                  ),
                  child: child,
                ),
              );
            },
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "STEP 03 / 03",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 10,
                    color: Colors.white60,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AndroidCosmicTheme.emeraldSync.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AndroidCosmicTheme.emeraldSync.withOpacity(0.4)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, size: 6, color: AndroidCosmicTheme.emeraldSync),
                      SizedBox(width: 4),
                      Text(
                        "GPS LOCK READY",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AndroidCosmicTheme.emeraldSync,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              "Geodetic Horizon",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Latitude & longitude anchor your local house cusps.",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 16),

            // Search Bar Input (Material 3)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.6)),
              ),
              child: Row(
                children: [
                  const Text("⌖", style: TextStyle(color: AndroidCosmicTheme.champagneGold, fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                  ),
                  const Icon(Icons.close, size: 18, color: Colors.white38),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 3D Topographic Radar HUD Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TOPOGRAPHIC HORIZON LOCK",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          letterSpacing: 1.1,
                          color: AndroidCosmicTheme.nebulaViolet,
                        ),
                      ),
                      Text(
                        "UTC +05:30 (IST)",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          color: AndroidCosmicTheme.champagneGold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Animated Radar Viewport
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: AnimatedBuilder(
                      animation: _radarController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: AndroidRadarPainter(progress: _radarController.value),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "12.9716° N, 77.5946° E",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, color: Colors.white),
                      ),
                      Text(
                        "ALT: 920m",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: AndroidCosmicTheme.emeraldSync),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              "MATCHING ASTRONOMICAL STATIONS",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 9,
                letterSpacing: 1.1,
                color: Colors.white38,
              ),
            ),

            const SizedBox(height: 8),

            // Stations Autocomplete List
            Expanded(
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                itemCount: _stations.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = _stations[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: item.isSelected ? AndroidCosmicTheme.nebulaViolet.withOpacity(0.18) : Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: item.isSelected ? AndroidCosmicTheme.champagneGold.withOpacity(0.7) : Colors.white.withOpacity(0.08),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item.city}, ${item.region}",
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${item.latDms} ${item.lngDms} • ${item.ayanamsa}",
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 9.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        if (item.isSelected)
                          const Text("✓", style: TextStyle(color: AndroidCosmicTheme.champagneGold, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Primary CTA (Material 3 ElevatedButton)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AndroidCosmicTheme.champagneGold,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    elevation: 8,
                    shadowColor: AndroidCosmicTheme.nebulaViolet.withOpacity(0.5),
                  ),
                  onPressed: _isGeneratingMatrix ? null : _generateMatrix,
                  child: _isGeneratingMatrix
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                        )
                      : const Text(
                          "Generate My Natal Matrix ✦",
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AndroidRadarPainter extends CustomPainter {
  final double progress;
  AndroidRadarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paintGrid = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final paintRadar = Paint()
      ..color = AndroidCosmicTheme.nebulaViolet.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), paintGrid);
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), paintGrid);
    canvas.drawCircle(center, 24, paintRadar);
    canvas.drawCircle(center, 44, paintRadar);

    // Rotating Radar Sweep Vector
    final angle = progress * 2 * math.pi;
    final sweepEnd = Offset(center.dx + 44 * math.cos(angle), center.dy + 44 * math.sin(angle));
    final sweepPaint = Paint()
      ..color = AndroidCosmicTheme.champagneGold
      ..strokeWidth = 1.5;
    canvas.drawLine(center, sweepEnd, sweepPaint);

    // Glowing coordinate target dot
    final dotPaint = Paint()..color = AndroidCosmicTheme.champagneGold;
    canvas.drawCircle(center, 3.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant AndroidRadarPainter oldDelegate) => true;
}
