// apple/lib/screens/screen01_welcome_apple.dart
// Screen 01: Welcome & 3D Cosmic Identity Profile (Apple iOS 17+ Target)
// Features: Dynamic Island 59pt safe inset, Apple CoreHaptics, Sign in with Apple modal sheet,
// True 3D Impeller Viewport, 3D Stellar Core, Volumetric Particle Vortex, and Z-axis camera warp transition.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astro_ai/shared/engine/3d/cosmic_spatial_view.dart';
import '../../shared/screens/screen_language_selection.dart';
import '../../shared/screens/screen_auth_unified.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen02_choose_focus_apple.dart';

class Screen01WelcomeApple extends StatefulWidget {
  const Screen01WelcomeApple({super.key});

  @override
  State<Screen01WelcomeApple> createState() => _Screen01WelcomeAppleState();
}

class _Screen01WelcomeAppleState extends State<Screen01WelcomeApple> {
  void _onBeginCalibration() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ScreenLanguageSelection(
          onContinue: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => ScreenAuthUnified(
                  onAuthenticated: () {
                    Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                        builder: (context) => const Screen02ChooseFocusApple(),
                      ),
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

  void _onAppleAuth() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ScreenAuthUnified(
          onAuthenticated: () {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => const Screen02ChooseFocusApple(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Top Apple Status Space
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "9:41",
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
                        "DAIVANT AI ASTROLOGY • METAL 3D",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppleCosmicTheme.champagneGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            // -------------------------------------------------------------
            // TRUE 3D COSMIC PROFILE STELLAR CORE (Metal GPU Viewport)
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
                color: AppleCosmicTheme.champagneGold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.4)),
              ),
              child: const Text(
                "NASA JPL EPHEMERIS × VEDIC 3D AI",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppleCosmicTheme.champagneGold,
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
                      color: AppleCosmicTheme.champagneGold,
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
                fontFamily: 'SF Pro Text',
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
              child: CupertinoButton(
                color: AppleCosmicTheme.champagneGold,
                borderRadius: BorderRadius.circular(999),
                onPressed: _onBeginCalibration,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Initialize 3D Cosmic Profile",
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(CupertinoIcons.arrow_right, size: 16, color: Colors.black),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Secondary Link: Restore Chart Vault
            CupertinoButton(
              onPressed: _onAppleAuth,
              child: Text(
                "Sign in with Apple",
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
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
