// android/lib/screens/screen01_welcome_android.dart
// Screen 01: Welcome & 3D Cosmic Identity Profile (Google Android 13+ Target)
// Features: True 3D Impeller Viewport, 3D Stellar Core, Volumetric Particle Vortex,
// Touch-based 3D orbit rotation, Google One-Tap Credential Manager, and Predictive Back.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astro_ai/shared/engine/3d/cosmic_spatial_view.dart';
import '../../shared/screens/screen_language_selection.dart';
import '../../shared/screens/screen_auth_unified.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen02_choose_focus_android.dart';

class Screen01WelcomeAndroid extends StatefulWidget {
  const Screen01WelcomeAndroid({super.key});

  @override
  State<Screen01WelcomeAndroid> createState() => _Screen01WelcomeAndroidState();
}

class _Screen01WelcomeAndroidState extends State<Screen01WelcomeAndroid> {
  void _onBeginCalibration() {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScreenLanguageSelection(
          onContinue: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ScreenAuthUnified(
                  onAuthenticated: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Screen02ChooseFocusAndroid()),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onRestoreVault() {
    HapticFeedback.vibrate();
    showModalBottomSheet(
      context: context,
      backgroundColor: AndroidCosmicTheme.oledVoid,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Google One-Tap Sign-In",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Restore your cryptographic birth chart vault with zero-knowledge hardware authentication.",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("G", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(width: 10),
                  Text("Continue with Google One-Tap", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Top Android Telemetry Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "12:45",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset('assets/images/daivant_logo.webp', width: 16, height: 16),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "DAIVANT AI ASTROLOGY • 3D SPATIAL",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AndroidCosmicTheme.champagneGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            // -------------------------------------------------------------
            // TRUE 3D COSMIC PROFILE STELLAR CORE (Impeller GPU Viewport)
            // -------------------------------------------------------------
            SizedBox(
              width: 270,
              height: 270,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: const CosmicSpatialView(
                  height: 270,
                  enableUserInteraction: true,
                  showOrbits: true,
                  showVortex: true,
                  vortexExpansion: 1.0,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "DRAG TO ROTATE 3D COSMIC CORE • PINCH TO ZOOM",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 8,
                letterSpacing: 1.1,
                color: Colors.white.withOpacity(0.4),
              ),
            ),

            const SizedBox(height: 18),

            // NASA JPL Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AndroidCosmicTheme.champagneGold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.4)),
              ),
              child: const Text(
                "NASA JPL EPHEMERIS × VEDIC 3D AI",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AndroidCosmicTheme.champagneGold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Cormorant Garamond Headline
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 34,
                  height: 1.1,
                  color: Color(0xFFF8FAFC),
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: "Decode the cosmos written in your "),
                  TextSpan(
                    text: "exact second",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: AndroidCosmicTheme.champagneGold,
                    ),
                  ),
                  TextSpan(text: " of birth."),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Interactive 3D planetary telemetry, spatial Kundali synthesis, and real-time voice divination with Devi.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                color: Colors.white.withOpacity(0.65),
                height: 1.5,
              ),
            ),

            const Spacer(),

            // CTA Button 1: Calibrate Ephemeris
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AndroidCosmicTheme.champagneGold,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 8,
                ),
                onPressed: _onBeginCalibration,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Initialize 3D Cosmic Profile",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Secondary Link: Restore Chart Vault
            TextButton(
              onPressed: _onRestoreVault,
              child: Text(
                "Restore Existing Chart Vault",
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
