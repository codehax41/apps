// android/lib/screens/screen08_nakshatra_insight_android.dart
// Screen 08: Nakshatra Insight (Google Android Target)
// Features: Android Intent.ACTION_SEND Story export, 3D Deep-Space Parallax Starfield,
// Aldebaran constellation canvas, and ClampingScrollPhysics.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen09_daily_guidance_android.dart';

class Screen08NakshatraInsightAndroid extends StatefulWidget {
  const Screen08NakshatraInsightAndroid({super.key});

  @override
  State<Screen08NakshatraInsightAndroid> createState() => _Screen08NakshatraInsightAndroidState();
}

class _Screen08NakshatraInsightAndroidState extends State<Screen08NakshatraInsightAndroid>
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
    HapticFeedback.vibrate();
    // Android Intent.ACTION_SEND trigger simulation
    showModalBottomSheet(
      context: context,
      backgroundColor: AndroidCosmicTheme.oledVoid,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Share 1080×1920 Story via Android Intent",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AndroidCosmicTheme.champagneGold),
              title: const Text("Save to Google Photos / Gallery", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share, color: AndroidCosmicTheme.nebulaViolet),
              title: const Text("Share to WhatsApp / Telegram / Instagram", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onNavigateToDailyGuidance() {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen09DailyGuidanceAndroid()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
                    color: AndroidCosmicTheme.champagneGold.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "PADA 1 • TAURUS",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold),
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
                    color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.25),
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
                          painter: AndroidAldebaranPainter(progress: _starfieldController.value),
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
                      color: AndroidCosmicTheme.champagneGold,
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
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.65),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.15)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    ),
                    onPressed: _onShareStory,
                    icon: const Icon(Icons.share, size: 14, color: AndroidCosmicTheme.champagneGold),
                    label: const Text(
                      "Share 1080×1920 Story",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11),
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
                        Text("Prajapati • Chariot", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
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
                        Text("Rohana (Power of Growth)", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold)),
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
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, letterSpacing: 1.1, color: AndroidCosmicTheme.nebulaViolet),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "With your Moon exalted in Rohini Pada 1 (ruled by Mars in Navamsa), you blend magnetic creative elegance with decisive execution. Unlike passive aesthetics, you build systems that achieve commercial scale and technological dominance.",
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12.5, height: 1.5, color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bottom CTA (Material 3 ElevatedButton)
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
                onPressed: _onNavigateToDailyGuidance,
                child: const Text(
                  "Open Daily Guidance (Screen 9) →",
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13.5, fontWeight: FontWeight.w600),
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

class AndroidAldebaranPainter extends CustomPainter {
  final double progress;
  AndroidAldebaranPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final linePaint = Paint()
      ..color = AndroidCosmicTheme.champagneGold.withOpacity(0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final starPaint = Paint()..color = Colors.white;
    final aldebaranPaint = Paint()..color = AndroidCosmicTheme.champagneGold;

    // Draw constellation connecting vectors
    canvas.drawLine(Offset(w * 0.15, h * 0.65), Offset(w * 0.4, h * 0.3), linePaint);
    canvas.drawLine(Offset(w * 0.4, h * 0.3), Offset(w * 0.65, h * 0.45), linePaint);
    canvas.drawLine(Offset(w * 0.65, h * 0.45), Offset(w * 0.85, h * 0.2), linePaint);

    // Stars
    canvas.drawCircle(Offset(w * 0.15, h * 0.65), 3, starPaint);
    // Aldebaran (Alpha Tauri) - Major glowing node
    canvas.drawCircle(Offset(w * 0.4, h * 0.3), 6, aldebaranPaint);
    canvas.drawCircle(Offset(w * 0.4, h * 0.3), 12, Paint()..color = AndroidCosmicTheme.champagneGold.withOpacity(0.25));

    canvas.drawCircle(Offset(w * 0.65, h * 0.45), 4, starPaint);
    canvas.drawCircle(Offset(w * 0.85, h * 0.2), 5, Paint()..color = AndroidCosmicTheme.auroraPink);
  }

  @override
  bool shouldRepaint(covariant AndroidAldebaranPainter oldDelegate) => true;
}
