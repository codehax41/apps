// apple/lib/screens/screen18_premium_reports_apple.dart
// Screen 18: Premium Report Library (Apple iOS Target)
// Features: Apple StoreKit 2 In-App Purchase sheet trigger, 3D hardcover book tilt with holographic foil shimmer,
// Unlocked vs locked report storefront, and route to Screen 19 Full Dossier.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen19_career_report_detail_apple.dart';

class Screen18PremiumReportsApple extends StatelessWidget {
  const Screen18PremiumReportsApple({super.key});

  void _onOpenUnlockedDossier(BuildContext context) {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen19CareerReportDetailApple()),
    );
  }

  void _purchaseReport(BuildContext context, String title, String price) {
    HapticFeedback.selectionClick();
    // Apple StoreKit 2 Purchase Sheet simulation
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text("Apple StoreKit 2 In-App Purchase"),
        message: Text("Purchase '$title' for $price using Apple Pay / Face ID."),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Unlock report
            },
            child: Text("Pay $price with Apple Pay "),
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

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              "DEEP EPHEMERIS DOSSIERS",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
            ),
            const SizedBox(height: 2),
            const Text(
              "Premium Report Vault",
              style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              "Comprehensive 35–45 page computational dossiers generated from your exact Swiss Ephemeris matrix.",
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Featured Unlocked Dossier (GlassActiveCard)
            GestureDetector(
              onTap: () => _onOpenUnlockedDossier(context),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: LinearGradient(
                    colors: [
                      AppleCosmicTheme.nebulaViolet.withOpacity(0.35),
                      AppleCosmicTheme.auroraPink.withOpacity(0.25),
                    ],
                  ),
                  border: Border.all(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.6)),
                  boxShadow: [
                    BoxShadow(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.3), blurRadius: 24),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppleCosmicTheme.champagneGold.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            "42 PAGES • UNLOCKED",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                          ),
                        ),
                        const Text("D10 + D1", style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white70)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "2026–2028 Executive & Venture Blueprint",
                      style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Complete breakdown of your Saturn-Mercury Dasha, equity windows, and leadership alignment across AI architectures.",
                      style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, height: 1.45, color: Colors.white.withOpacity(0.85)),
                    ),
                    const SizedBox(height: 14),
                    const Row(
                      children: [
                        Text("Read Full Dossier", style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold)),
                        SizedBox(width: 4),
                        Icon(CupertinoIcons.arrow_right, size: 14, color: AppleCosmicTheme.champagneGold),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Locked Storefront Cards
            const Text(
              "AVAILABLE DOSSIERS IN STORE",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, color: Colors.white38),
            ),
            const SizedBox(height: 10),

            _buildLockedCard(
              context,
              title: "D9 NAVAMSA CODEX",
              subtitle: "Sacred Marriage & Soulmate Timing",
              desc: "34-page synastry, karmic bond & Navamsa transit analysis",
              price: "₹299",
              tagColor: AppleCosmicTheme.auroraPink,
            ),
            const SizedBox(height: 10),
            _buildLockedCard(
              context,
              title: "VARSHAPHALA (SOLAR RETURN)",
              subtitle: "Year Ahead Tajika Mudda Dasha",
              desc: "Month-by-month precision astrological triggers & Muhurtas",
              price: "₹199",
              tagColor: AppleCosmicTheme.emeraldSync,
            ),

            const SizedBox(height: 20),

            // Bottom CTA
            GestureDetector(
              onTap: () => _onOpenUnlockedDossier(context),
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
                    "Open Career Report Detail (Screen 19) →",
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

  Widget _buildLockedCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String desc,
    required String price,
    required Color tagColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: tagColor)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 2),
                Text(desc, style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white.withOpacity(0.55))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: AppleCosmicTheme.champagneGold.withOpacity(0.18),
            borderRadius: BorderRadius.circular(999),
            onPressed: () => _purchaseReport(context, subtitle, price),
            child: Text(
              price,
              style: const TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
            ),
          ),
        ],
      ),
    );
  }
}
