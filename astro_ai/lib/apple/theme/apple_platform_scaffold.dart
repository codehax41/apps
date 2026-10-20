// apple/lib/theme/apple_platform_scaffold.dart
// Adaptive Platform Wrapper for Apple iOS Target (Cupertino, Metal Blur, CoreHaptics)

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'apple_theme.dart';

class ApplePlatformScaffold extends StatelessWidget {
  final Widget body;
  final ObstructingPreferredSizeWidget? navigationBar;
  final Widget? bottomFloatingDock;
  final bool enableParallax;

  const ApplePlatformScaffold({
    super.key,
    required this.body,
    this.navigationBar,
    this.bottomFloatingDock,
    this.enableParallax = true,
  });

  void triggerHapticTick() {
    HapticFeedback.selectionClick();
  }

  void triggerHapticMedium() {
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppleCosmicTheme.oledVoid,
      navigationBar: navigationBar,
      child: Stack(
        children: [
          // Background Bioluminescent Radial Gradient Canvas
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: AppleCosmicTheme.oledVoid,
                image: DecorationImage(
                  image: AssetImage('assets/images/nebula_void.png'),
                  fit: BoxFit.cover,
                  opacity: 0.85,
                ),
              ),
            ),
          ),

          // Native Metal Gaussian Blur Backdrop Layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: AppleCosmicTheme.metalBlurSigma,
                sigmaY: AppleCosmicTheme.metalBlurSigma,
              ),
              child: Container(color: CupertinoColors.transparent),
            ),
          ),

          // Safe Area with Apple Insets (Dynamic Island 59pt + Home Indicator 34pt)
          SafeArea(
            top: true,
            bottom: true,
            minimum: const EdgeInsets.only(
              top: AppleCosmicTheme.dynamicIslandTopInset,
              bottom: AppleCosmicTheme.homeIndicatorBottomInset,
            ),
            child: ScrollConfiguration(
              // Strict iOS BouncingScrollPhysics
              behavior: const CupertinoScrollBehavior(),
              child: body,
            ),
          ),

          // Floating Glass Bottom Dock (if present)
          if (bottomFloatingDock != null)
            Positioned(
              left: 20,
              right: 20,
              bottom: AppleCosmicTheme.homeIndicatorBottomInset + 10,
              child: bottomFloatingDock!,
            ),
        ],
      ),
    );
  }
}
