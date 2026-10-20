// apple/lib/screens/screen13_compatibility_intro_apple.dart
// Screen 13: Compatibility Introduction (Apple iOS Target)
// Features: AirDrop & NameDrop Proximity Synastry, 3D Dual-Aura additive light spheres,
// Romantic vs Co-Founder mode selection, and Cupertino navigation.

import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen14_partner_details_apple.dart';

enum SynastryMode { romantic, cofounder }

class Screen13CompatibilityIntroApple extends StatefulWidget {
  const Screen13CompatibilityIntroApple({super.key});

  @override
  State<Screen13CompatibilityIntroApple> createState() => _Screen13CompatibilityIntroAppleState();
}

class _Screen13CompatibilityIntroAppleState extends State<Screen13CompatibilityIntroApple>
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
      HapticFeedback.selectionClick();
      setState(() => _selectedMode = mode);
    }
  }

  void _triggerNameDrop() {
    HapticFeedback.heavyImpact();
    // iOS NameDrop Proximity Sheet simulation
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('AirDrop / NameDrop Synastry'),
        message: const Text('Hold your iPhone near your partner or co-founder\'s iPhone to exchange encrypted chart public tokens.'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Route directly to report with mock partner token
            },
            child: const Text('Simulate Proximity Beam ✦'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void _onEnterCoordinates() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen14PartnerDetailsApple()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
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
                      style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _triggerNameDrop,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppleCosmicTheme.auroraPink.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppleCosmicTheme.auroraPink.withOpacity(0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.antenna_radiowaves_left_right, size: 12, color: AppleCosmicTheme.auroraPink),
                        SizedBox(width: 4),
                        Text(
                          "NAMEDROP",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: AppleCosmicTheme.auroraPink),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Center 3D Dual-Aura Hero (Additive Light Spheres)
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
                      // Left Sphere (User Chart)
                      Transform.translate(
                        offset: Offset(-36 + offset, 0),
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppleCosmicTheme.nebulaViolet.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.55), blurRadius: 40),
                            ],
                          ),
                          child: const Center(
                            child: Text("☉", style: TextStyle(fontSize: 32, color: Colors.white)),
                          ),
                        ),
                      ),
                      // Right Sphere (Partner Chart)
                      Transform.translate(
                        offset: Offset(36 - offset, 0),
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (_selectedMode == SynastryMode.romantic
                                    ? AppleCosmicTheme.auroraPink
                                    : AppleCosmicTheme.champagneGold)
                                .withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                color: (_selectedMode == SynastryMode.romantic
                                        ? AppleCosmicTheme.auroraPink
                                        : AppleCosmicTheme.champagneGold)
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
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, height: 1.45, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 24),

            // 2-Column Mode Selector Cards
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _switchMode(SynastryMode.romantic),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedMode == SynastryMode.romantic
                            ? AppleCosmicTheme.auroraPink.withOpacity(0.2)
                            : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _selectedMode == SynastryMode.romantic
                              ? AppleCosmicTheme.auroraPink.withOpacity(0.6)
                              : Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("♥", style: TextStyle(color: AppleCosmicTheme.auroraPink, fontSize: 16)),
                          SizedBox(height: 4),
                          Text("Romantic Bond", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 2),
                          Text("Venus-Mars & 7th House", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _switchMode(SynastryMode.cofounder),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedMode == SynastryMode.cofounder
                            ? AppleCosmicTheme.champagneGold.withOpacity(0.2)
                            : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _selectedMode == SynastryMode.cofounder
                              ? AppleCosmicTheme.champagneGold.withOpacity(0.6)
                              : Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("⚡", style: TextStyle(color: AppleCosmicTheme.champagneGold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text("Co-Founder Sync", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
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
            GestureDetector(
              onTap: _onEnterCoordinates,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AppleCosmicTheme.nebulaViolet, AppleCosmicTheme.auroraPink],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.35), blurRadius: 18),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "+ Enter Partner Coordinates →",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
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
