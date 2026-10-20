// android/lib/screens/screen19_career_report_detail_android.dart
// Screen 19: Career Report Detail (Google Android Target)
// Features: Android MediaStore PDF download & PDF Viewer Intent,
// 8-chapter horizontal slide curl, key execution windows, and VibrationEffect haptic sync.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen20_panchang_calendar_android.dart';

class Screen19CareerReportDetailAndroid extends StatefulWidget {
  const Screen19CareerReportDetailAndroid({super.key});

  @override
  State<Screen19CareerReportDetailAndroid> createState() => _Screen19CareerReportDetailAndroidState();
}

class _Screen19CareerReportDetailAndroidState extends State<Screen19CareerReportDetailAndroid> {
  final int _currentChapter = 3;

  void _exportPdf() {
    HapticFeedback.vibrate();
    // Android MediaStore & PDF Viewer Intent simulation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AndroidCosmicTheme.oledVoid,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Row(
          children: [
            Icon(Icons.download_done, color: AndroidCosmicTheme.champagneGold, size: 18),
            SizedBox(width: 10),
            Expanded(
              child: Text("Dossier saved to Downloads/AstroAI_Career_Dossier.pdf. Opening PDF viewer...", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _onNavigateToPanchang() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen20PanchangCalendarAndroid()),
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
            // Top Reader Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CHAPTER 0$_currentChapter / 08",
                  style: const TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Colors.white54, letterSpacing: 1.2),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.12)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                  onPressed: _exportPdf,
                  icon: const Icon(Icons.file_download, size: 14, color: AndroidCosmicTheme.champagneGold),
                  label: const Text("PDF ↓", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9)),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Chapter Title
            const Text(
              "The Saturn–Mercury Wealth Inflection",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.15,
              ),
            ),

            const SizedBox(height: 8),

            // Badges
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text("D10 LAGNA: LEO", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AndroidCosmicTheme.nebulaViolet, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AndroidCosmicTheme.emeraldSync.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text("STRENGTH: 94%", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AndroidCosmicTheme.emeraldSync, fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Editorial Body Copy
            Text(
              "In your Dasamsa (D10) divisional chart, Mercury simultaneously rules the 2nd house of accumulated institutional treasury and the 11th house of exponential network capitalization. Combined with Mars placed in Scorpio Digbala, this forms a formidable Ruchaka-Budha yoga that favors decisive technological architecture.",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, height: 1.6, color: Colors.white.withOpacity(0.85)),
            ),

            const SizedBox(height: 16),

            // Key Execution Windows Callout Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: const Border(
                  left: BorderSide(color: AndroidCosmicTheme.champagneGold, width: 3),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("KEY EXECUTION WINDOWS", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, letterSpacing: 1.2, color: AndroidCosmicTheme.champagneGold, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nov 04 – Dec 18, 2026", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text("Launch / Pitch →", style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.emeraldSync)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Feb 14 – Apr 02, 2027", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text("Equity Vesting →", style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.nebulaViolet)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Avoid diluting ownership or taking on premature co-founders during Mars retrograde shadow phases. Your natal configuration guarantees compounding equity leverage through organic product mastery.",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, height: 1.6, color: Colors.white.withOpacity(0.7)),
            ),

            const SizedBox(height: 24),

            // Bottom CTA
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
                onPressed: _onNavigateToPanchang,
                child: const Text(
                  "Open Panchang Calendar (Screen 20) →",
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
