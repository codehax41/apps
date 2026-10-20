// apple/lib/screens/screen19_career_report_detail_apple.dart
// Screen 19: Career Report Detail (Apple iOS Target)
// Features: Apple QuickLook (QLPreviewController) & AirPrint PDF export,
// 8-chapter horizontal slide curl, key execution windows, and high-contrast typography.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen20_panchang_calendar_apple.dart';

class Screen19CareerReportDetailApple extends StatefulWidget {
  const Screen19CareerReportDetailApple({super.key});

  @override
  State<Screen19CareerReportDetailApple> createState() => _Screen19CareerReportDetailAppleState();
}

class _Screen19CareerReportDetailAppleState extends State<Screen19CareerReportDetailApple> {
  final int _currentChapter = 3;

  void _exportPdf() {
    HapticFeedback.mediumImpact();
    // Apple QuickLook / AirPrint simulation sheet
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text("Export Executive Dossier PDF"),
        message: const Text("Open in Apple QuickLook, AirPrint directly, or Save to iOS Files app."),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Open in QuickLook 📄"),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Print via AirPrint 🖨"),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Save to Files 📂"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  void _onNavigateToPanchang() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen20PanchangCalendarApple()),
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
            // Top Reader Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CHAPTER 0$_currentChapter / 08",
                  style: const TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Colors.white54, letterSpacing: 1.2),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(999),
                  onPressed: _exportPdf,
                  child: const Row(
                    children: [
                      Icon(CupertinoIcons.arrow_down_doc, size: 13, color: AppleCosmicTheme.champagneGold),
                      SizedBox(width: 4),
                      Text("PDF ↓", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white)),
                    ],
                  ),
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
                    color: AppleCosmicTheme.nebulaViolet.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text("D10 LAGNA: LEO", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AppleCosmicTheme.nebulaViolet, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppleCosmicTheme.emeraldSync.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text("STRENGTH: 94%", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: AppleCosmicTheme.emeraldSync, fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Editorial Body Copy
            Text(
              "In your Dasamsa (D10) divisional chart, Mercury simultaneously rules the 2nd house of accumulated institutional treasury and the 11th house of exponential network capitalization. Combined with Mars placed in Scorpio Digbala, this forms a formidable Ruchaka-Budha yoga that favors decisive technological architecture.",
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, height: 1.6, color: Colors.white.withOpacity(0.85)),
            ),

            const SizedBox(height: 16),

            // Key Execution Windows Callout Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: const Border(
                  left: BorderSide(color: AppleCosmicTheme.champagneGold, width: 3),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("KEY EXECUTION WINDOWS", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, letterSpacing: 1.2, color: AppleCosmicTheme.champagneGold, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nov 04 – Dec 18, 2026", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text("Launch / Pitch →", style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: AppleCosmicTheme.emeraldSync)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Feb 14 – Apr 02, 2027", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text("Equity Vesting →", style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: AppleCosmicTheme.nebulaViolet)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Avoid diluting ownership or taking on premature co-founders during Mars retrograde shadow phases. Your natal configuration guarantees compounding equity leverage through organic product mastery.",
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, height: 1.6, color: Colors.white.withOpacity(0.7)),
            ),

            const SizedBox(height: 24),

            // Bottom CTA
            GestureDetector(
              onTap: _onNavigateToPanchang,
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
                    "Open Panchang Calendar (Screen 20) →",
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
