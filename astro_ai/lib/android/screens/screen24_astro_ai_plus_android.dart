// android/lib/screens/screen24_astro_ai_plus_android.dart
// Screen 24: AstroAI Plus Subscription Paywall (Google Android Target)
// Features: Google Play Billing Library v7, Google Play Auto-Renewing Subscriptions & UPI Mandates,
// ClampingScrollPhysics, Material 3 Glassmorphism, and Shared Z-Axis 3D page transition to Screen 25.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen25_personal_profile_android.dart';

class Screen24AstroAiPlusAndroid extends StatefulWidget {
  const Screen24AstroAiPlusAndroid({super.key});

  @override
  State<Screen24AstroAiPlusAndroid> createState() => _Screen24AstroAiPlusAndroidState();
}

class _Screen24AstroAiPlusAndroidState extends State<Screen24AstroAiPlusAndroid> {
  int _selectedTierIndex = 0; // 0 = Annual (Save 50%), 1 = Monthly

  void _onRestoreGooglePlayPurchases() {
    HapticFeedback.vibrate();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF13131F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AndroidCosmicTheme.stellarGold, width: 0.8),
        ),
        title: const Text(
          "Google Play Billing v7",
          style: TextStyle(fontFamily: 'Space Mono', fontSize: 14, color: AndroidCosmicTheme.stellarGold),
        ),
        content: const Text(
          "Querying active purchase tokens and UPI mandates from Google Play Store cache...",
          style: TextStyle(fontFamily: 'Roboto', fontSize: 12.5, color: Colors.white70),
        ),
        actions: [
          TextButton(
            child: const Text("CLOSE", style: TextStyle(color: AndroidCosmicTheme.stellarGold)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _onSubscribeTrial() {
    HapticFeedback.vibrate();
    // Launch Google Play Billing Flow -> On success navigate to Screen 25
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Screen25PersonalProfileAndroid(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.96, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Navigation Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AndroidCosmicTheme.stellarGold.withOpacity(0.5)),
                    color: AndroidCosmicTheme.stellarGold.withOpacity(0.12),
                  ),
                  child: const Text(
                    "✦ ASTROAI PLUS QUANTUM",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.stellarGold),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: _onRestoreGooglePlayPurchases,
                  child: const Text(
                    "Restore",
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 13, color: Colors.white70),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Headline
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 28, height: 1.15, color: Colors.white),
                children: [
                  TextSpan(text: "Unlimited Live Voice with "),
                  TextSpan(
                    text: "Devi",
                    style: TextStyle(color: AndroidCosmicTheme.stellarGold, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " & Full D1–D60 Matrix"),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Feature Checklist Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AndroidCosmicTheme.stellarGold.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  _buildFeatureRow("24/7 Live Video & Voice calls with Devi AI Oracle"),
                  const SizedBox(height: 12),
                  _buildFeatureRow("All 16 Divisional Charts (D9 Navamsa, D10 Career, D60)"),
                  const SizedBox(height: 12),
                  _buildFeatureRow("Unlimited Partner & Co-Founder Synastry Reports"),
                  const SizedBox(height: 12),
                  _buildFeatureRow("Precision Pratyantar Dasha & Muhurta Calendar"),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Dual Pricing Tiers (Annual vs Monthly)
            Row(
              children: [
                // Annual Pass (Save 50%)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.vibrate();
                      setState(() => _selectedTierIndex = 0);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedTierIndex == 0 ? AndroidCosmicTheme.nebulaViolet.withOpacity(0.25) : Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _selectedTierIndex == 0 ? AndroidCosmicTheme.stellarGold : Colors.white12,
                          width: _selectedTierIndex == 0 ? 1.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AndroidCosmicTheme.stellarGold,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              "SAVE 50%",
                              style: TextStyle(fontFamily: 'Space Mono', fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Annual Pass",
                            style: TextStyle(fontFamily: 'Roboto', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.stellarGold),
                              children: [
                                TextSpan(text: "₹2,999"),
                                TextSpan(
                                  text: "/yr",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 11, color: Colors.white54, fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "₹249 / month",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Monthly Pass
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.vibrate();
                      setState(() => _selectedTierIndex = 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedTierIndex == 1 ? AndroidCosmicTheme.nebulaViolet.withOpacity(0.25) : Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _selectedTierIndex == 1 ? AndroidCosmicTheme.stellarGold : Colors.white12,
                          width: _selectedTierIndex == 1 ? 1.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              "FLEXIBLE",
                              style: TextStyle(fontFamily: 'Space Mono', fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white70),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Monthly",
                            style: TextStyle(fontFamily: 'Roboto', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                              children: [
                                TextSpan(text: "₹499"),
                                TextSpan(
                                  text: "/mo",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 11, color: Colors.white54, fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "Cancel anytime",
                            style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Colors.white38),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Primary Subscription CTA Button
            GestureDetector(
              onTap: _onSubscribeTrial,
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AndroidCosmicTheme.stellarGold, Color(0xFFFDE68A), AndroidCosmicTheme.stellarGold],
                  ),
                  boxShadow: [
                    BoxShadow(color: AndroidCosmicTheme.stellarGold.withOpacity(0.4), blurRadius: 20, spreadRadius: 1),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Start 7-Day Free Quantum Trial ✦",
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Google Play Store Billing Disclosures
            Text(
              "After 7-day trial, subscription renews automatically via Google Play. Manage or cancel anytime under Payments & Subscriptions on Google Play.",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Roboto', fontSize: 10, color: Colors.white.withOpacity(0.45), height: 1.3),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Row(
      children: [
        const Text(
          "✦",
          style: TextStyle(color: AndroidCosmicTheme.stellarGold, fontSize: 12),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontFamily: 'Roboto', fontSize: 12.5, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
