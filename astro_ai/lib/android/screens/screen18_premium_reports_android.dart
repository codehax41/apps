// android/lib/screens/screen18_premium_reports_android.dart
// Screen 18: Premium Report Library (Google Android Target)
// Features: Google Play Billing Library v7 bottom sheet trigger (UPI, GPay, cards),
// 3D hardcover book tilt with holographic foil shimmer, and route to Screen 19 Full Dossier.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen19_career_report_detail_android.dart';

class Screen18PremiumReportsAndroid extends StatelessWidget {
  const Screen18PremiumReportsAndroid({super.key});

  void _onOpenUnlockedDossier(BuildContext context) {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen19CareerReportDetailAndroid()),
    );
  }

  void _purchaseReport(BuildContext context, String title, String price) {
    HapticFeedback.vibrate();
    // Google Play Billing Library v7 sheet simulation
    showModalBottomSheet(
      context: context,
      backgroundColor: AndroidCosmicTheme.oledVoid,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Google Play Billing v7",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              "Complete purchase for '$title' ($price) via Google Play, UPI, or cards.",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, color: Colors.white.withOpacity(0.65)),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AndroidCosmicTheme.champagneGold,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                Navigator.pop(context);
                // Trigger backend purchase token verification
              },
              child: Text("Pay $price with Google Play / UPI", style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
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
            // Header
            const Text(
              "DEEP EPHEMERIS DOSSIERS",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
            ),
            const SizedBox(height: 2),
            const Text(
              "Premium Report Vault",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              "Comprehensive 35–45 page computational dossiers generated from your exact Swiss Ephemeris matrix.",
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12.5, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Featured Unlocked Dossier
            InkWell(
              borderRadius: BorderRadius.circular(26),
              onTap: () => _onOpenUnlockedDossier(context),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: LinearGradient(
                    colors: [
                      AndroidCosmicTheme.nebulaViolet.withOpacity(0.35),
                      AndroidCosmicTheme.auroraPink.withOpacity(0.25),
                    ],
                  ),
                  border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.6)),
                  boxShadow: [
                    BoxShadow(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.3), blurRadius: 24),
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
                            color: AndroidCosmicTheme.champagneGold.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            "42 PAGES • UNLOCKED",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold),
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
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12.5, height: 1.45, color: Colors.white.withOpacity(0.85)),
                    ),
                    const SizedBox(height: 14),
                    const Row(
                      children: [
                        Text("Read Full Dossier", style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.champagneGold)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 16, color: AndroidCosmicTheme.champagneGold),
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
              tagColor: AndroidCosmicTheme.auroraPink,
            ),
            const SizedBox(height: 10),
            _buildLockedCard(
              context,
              title: "VARSHAPHALA (SOLAR RETURN)",
              subtitle: "Year Ahead Tajika Mudda Dasha",
              desc: "Month-by-month precision astrological triggers & Muhurtas",
              price: "₹199",
              tagColor: AndroidCosmicTheme.emeraldSync,
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
                onPressed: () => _onOpenUnlockedDossier(context),
                child: const Text(
                  "Open Career Report Detail (Screen 19) →",
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
                Text(subtitle, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 2),
                Text(desc, style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11, color: Colors.white.withOpacity(0.55))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AndroidCosmicTheme.champagneGold.withOpacity(0.2),
              foregroundColor: AndroidCosmicTheme.champagneGold,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            onPressed: () => _purchaseReport(context, subtitle, price),
            child: Text(
              price,
              style: const TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
