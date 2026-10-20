// android/lib/theme/android_platform_scaffold.dart
// Adaptive Platform Wrapper for Google Android Target (Edge-to-Edge, Predictive Back, Vulkan Blur, VibrationEffect)

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'android_theme.dart';

class AndroidPlatformScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomFloatingDock;
  final VoidCallback? onPredictiveBack;
  final bool enableParallax;

  const AndroidPlatformScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomFloatingDock,
    this.onPredictiveBack,
    this.enableParallax = true,
  });

  void triggerAndroidClockTick() {
    // Android VibrationEffect.createPredefined(EFFECT_TICK)
    HapticFeedback.vibrate();
  }

  void triggerAndroidHeavyClick() {
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    // Enforce Edge-to-Edge transparent navigation & status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          triggerAndroidClockTick();
          onPredictiveBack?.call();
        }
      },
      child: Scaffold(
        backgroundColor: AndroidCosmicTheme.oledVoid,
        resizeToAvoidBottomInset: false,
        appBar: appBar,
        body: Stack(
          children: [
            // Background Bioluminescent Radial Gradient Canvas
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: AndroidCosmicTheme.oledVoid,
                ),
              ),
            ),

            // Hardware-Accelerated Vulkan RenderEffect Blur
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: AndroidCosmicTheme.vulkanBlurSigma,
                  sigmaY: AndroidCosmicTheme.vulkanBlurSigma,
                ),
                child: Container(color: Colors.transparent),
              ),
            ),

            // Edge-to-Edge Padding (24dp top, 16dp bottom)
            SafeArea(
              top: true,
              bottom: true,
              minimum: const EdgeInsets.only(
                top: AndroidCosmicTheme.statusBarTopInset,
                bottom: AndroidCosmicTheme.gestureBarBottomInset,
              ),
              child: ScrollConfiguration(
                // Android ClampingScrollPhysics
                behavior: const ScrollBehavior().copyWith(
                  physics: const ClampingScrollPhysics(),
                  overscroll: false,
                ),
                child: body,
              ),
            ),

            // Floating Glass Bottom Dock (positioned right above gesture bar)
            if (bottomFloatingDock != null)
              Positioned(
                left: 16,
                right: 16,
                bottom: AndroidCosmicTheme.gestureBarBottomInset + 8,
                child: bottomFloatingDock!,
              ),
          ],
        ),
      ),
    );
  }
}
