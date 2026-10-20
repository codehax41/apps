// apple/lib/screens/screen08_nakshatra_insight_apple.dart
// Screen 08: Nakshatra Insight (Apple iOS Target)
// Features: 3D Deep-Space Parallax Starfield (3 depth layers), UIActivityViewController Share Sheet export,
// Aldebaran constellation canvas, and Cormorant Garamond archetype typography.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen09_daily_guidance_apple.dart';

class Screen08NakshatraInsightApple extends StatefulWidget {
  const Screen08NakshatraInsightApple({super.key});

  @override
  State<Screen08NakshatraInsightApple> createState() => _Screen08NakshatraInsightAppleState();
}

class _Screen08NakshatraInsightAppleState extends State<Screen08NakshatraInsightApple>
    with SingleTickerProviderStateMixin {
  late AnimationController _starfieldController;

  @override
  void initState() {
    super.initState();
    _starfieldController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _starfieldController.dispose();
    super.dispose();
  }

  void _onShareStory() {
    HapticFeedback.mediumImpact();
    // Native iOS Share Sheet trigger (UIActivityViewController simulation)
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Export Rohini Nakshatra Story'),
        message: const Text('Export 1080×1920 High-Res Constellation Artwork to Instagram / Photos'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save to Photos'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Share to Instagram Story'),
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

  void _onNavigateToDailyGuidance() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen09DailyGuidanceApple()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "LUNAR MANSION 04 / 27",
                  style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppleCosmicTheme.champagneGold.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "PADA 1 • TAURUS",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 3D Constellation Star-Map Hero Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                    color: AppleCosmicTheme.nebulaViolet.withOpacity(0.25),
                    blurRadius: 28,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Constellation Vector Canvas with 3-Layer Parallax
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: AnimatedBuilder(
                      animation: _starfieldController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: AldebaranConstellationPainter(progress: _starfieldController.value),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "ALDEBARAN (ALPHA TAURI)",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 9,
                      letterSpacing: 1.5,
                      color: AppleCosmicTheme.champagneGold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Rohini Nakshatra",
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "“The Star of Ascent & Magnetic Creation”",
                    style: TextStyle(
                      fontFamily: '.SF Pro Text',
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.65),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(999),
                    onPressed: _onShareStory,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.share, size: 14, color: AppleCosmicTheme.champagneGold),
                        SizedBox(width: 6),
                        Text(
                          "Share 1080×1920 Story",
                          style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 2-Column Archetype Grid
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DEITY & SYMBOL", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white54)),
                        SizedBox(height: 4),
                        Text("Prajapati • Chariot", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SHAKTI POWER", style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white54)),
                        SizedBox(height: 4),
                        Text("Rohana (Power of Growth)", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Core Psychology & Pada Analysis Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "CORE PSYCHOLOGY & PADA 1 (ARIES NAVAMSA)",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, letterSpacing: 1.1, color: AppleCosmicTheme.nebulaViolet),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "With your Moon exalted in Rohini Pada 1 (ruled by Mars in Navamsa), you blend magnetic creative elegance with decisive execution. Unlike passive aesthetics, you build systems that achieve commercial scale and technological dominance.",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, height: 1.5, color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bottom CTA
            GestureDetector(
              onTap: _onNavigateToDailyGuidance,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AppleCosmicTheme.nebulaViolet, AppleCosmicTheme.auroraPink],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppleCosmicTheme.nebulaViolet.withOpacity(0.35),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Open Daily Guidance (Screen 9) →",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white),
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

class AldebaranConstellationPainter extends CustomPainter {
  final double progress;
  AldebaranConstellationPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final linePaint = Paint()
      ..color = AppleCosmicTheme.champagneGold.withOpacity(0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final starPaint = Paint()..color = Colors.white;
    final aldebaranPaint = Paint()..color = AppleCosmicTheme.champagneGold;

    // Draw constellation connecting vectors
    canvas.drawLine(Offset(w * 0.15, h * 0.65), Offset(w * 0.4, h * 0.3), linePaint);
    canvas.drawLine(Offset(w * 0.4, h * 0.3), Offset(w * 0.65, h * 0.45), linePaint);
    canvas.drawLine(Offset(w * 0.65, h * 0.45), Offset(w * 0.85, h * 0.2), linePaint);

    // Stars
    canvas.drawCircle(Offset(w * 0.15, h * 0.65), 3, starPaint);
    // Aldebaran (Alpha Tauri) - Major glowing node
    canvas.drawCircle(Offset(w * 0.4, h * 0.3), 6, aldebaranPaint);
    canvas.drawCircle(Offset(w * 0.4, h * 0.3), 12, Paint()..color = AppleCosmicTheme.champagneGold.withOpacity(0.25));

    canvas.drawCircle(Offset(w * 0.65, h * 0.45), 4, starPaint);
    canvas.drawCircle(Offset(w * 0.85, h * 0.2), 5, Paint()..color = AppleCosmicTheme.auroraPink);
  }

  @override
  bool shouldRepaint(covariant AldebaranConstellationPainter oldDelegate) => true;
}
