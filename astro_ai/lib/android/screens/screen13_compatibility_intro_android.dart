// android/lib/screens/screen13_compatibility_intro_android.dart
// Screen 13: Compatibility Introduction (Google Android Target)
// Features: Android Nearby Share / QR Code Synastry token beam, 3D Dual-Aura additive light spheres,
// Romantic vs Co-Founder mode selection with VibrationEffect, and ClampingScrollPhysics.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen14_partner_details_android.dart';

enum SynastryMode { romantic, cofounder }

class Screen13CompatibilityIntroAndroid extends StatefulWidget {
  const Screen13CompatibilityIntroAndroid({super.key});

  @override
  State<Screen13CompatibilityIntroAndroid> createState() => _Screen13CompatibilityIntroAndroidState();
}

class _Screen13CompatibilityIntroAndroidState extends State<Screen13CompatibilityIntroAndroid>
    with SingleTickerProviderStateMixin {
  SynastryMode _selectedMode = SynastryMode.romantic;
  late AnimationController _spheresController;

  @override
  void initState() {
    super.initState();
    _spheresController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _spheresController.dispose();
    super.dispose();
  }

  void _switchMode(SynastryMode mode) {
    if (_selectedMode != mode) {
      HapticFeedback.vibrate();
      setState(() => _selectedMode = mode);
    }
  }

  void _triggerNearbyShare() {
    HapticFeedback.heavyImpact();
    // Android Nearby Share / QR Code token beam simulation
    showModalBottomSheet(
      context: context,
      backgroundColor: AndroidCosmicTheme.oledVoid,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nearby Share / QR Synastry Beam",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              "Scan partner's QR code or use Nearby Share to exchange encrypted birth chart tokens without revealing raw temporal timestamps.",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, color: Colors.white.withOpacity(0.65)),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AndroidCosmicTheme.nebulaViolet,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text("Scan Partner Chart QR Code"),
            ),
          ],
        ),
      ),
    );
  }

  void _onEnterCoordinates() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen14PartnerDetailsAndroid()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "QUANTUM ASHTAKOOT + SYNASTRY",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Harmonic Resonance",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: _triggerNearbyShare,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AndroidCosmicTheme.auroraPink.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AndroidCosmicTheme.auroraPink.withOpacity(0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.share, size: 13, color: AndroidCosmicTheme.auroraPink),
                        SizedBox(width: 4),
                        Text(
                          "NEARBY",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.auroraPink),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Center 3D Dual-Aura Hero
            AnimatedBuilder(
              animation: _spheresController,
              builder: (context, child) {
                final angle = _spheresController.value * 2 * math.pi;
                final offset = math.sin(angle) * 12;

                return SizedBox(
                  width: 260,
                  height: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Left Sphere
                      Transform.translate(
                        offset: Offset(-36 + offset, 0),
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.55), blurRadius: 40),
                            ],
                          ),
                          child: const Center(
                            child: Text("☉", style: TextStyle(fontSize: 32, color: Colors.white)),
                          ),
                        ),
                      ),
                      // Right Sphere
                      Transform.translate(
                        offset: Offset(36 - offset, 0),
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (_selectedMode == SynastryMode.romantic
                                    ? AndroidCosmicTheme.auroraPink
                                    : AndroidCosmicTheme.champagneGold)
                                .withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                color: (_selectedMode == SynastryMode.romantic
                                        ? AndroidCosmicTheme.auroraPink
                                        : AndroidCosmicTheme.champagneGold)
                                    .withOpacity(0.55),
                                blurRadius: 40,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text("☽", style: TextStyle(fontSize: 32, color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            const Text(
              "Decode the unseen gravity between two birth charts.",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              "Combine Parashari 36-point Guna Milan with western synastry aspects to reveal karmic compatibility, communication flow, and conflict velocity.",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12.5, height: 1.45, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 24),

            // 2-Column Mode Selector Cards
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => _switchMode(SynastryMode.romantic),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedMode == SynastryMode.romantic
                            ? AndroidCosmicTheme.auroraPink.withOpacity(0.2)
                            : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _selectedMode == SynastryMode.romantic
                              ? AndroidCosmicTheme.auroraPink.withOpacity(0.6)
                              : Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("♥", style: TextStyle(color: AndroidCosmicTheme.auroraPink, fontSize: 16)),
                          SizedBox(height: 4),
                          Text("Romantic Bond", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 2),
                          Text("Venus-Mars & 7th House", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => _switchMode(SynastryMode.cofounder),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedMode == SynastryMode.cofounder
                            ? AndroidCosmicTheme.champagneGold.withOpacity(0.2)
                            : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _selectedMode == SynastryMode.cofounder
                              ? AndroidCosmicTheme.champagneGold.withOpacity(0.6)
                              : Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("⚡", style: TextStyle(color: AndroidCosmicTheme.champagneGold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text("Co-Founder Sync", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 2),
                          Text("Mercury-Saturn & 10th H", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Primary CTA
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AndroidCosmicTheme.nebulaViolet,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  elevation: 6,
                ),
                onPressed: _onEnterCoordinates,
                child: const Text(
                  "+ Enter Partner Coordinates →",
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
