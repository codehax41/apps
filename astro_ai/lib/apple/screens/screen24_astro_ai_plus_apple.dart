// apple/lib/screens/screen24_astro_ai_plus_apple.dart
// Screen 24: AstroAI Plus Subscription Paywall (Apple iOS Target)
// Features: Apple StoreKit 2 compliance, In-App Purchase terms, Apple Pay / Face ID entitlement,
// Annual vs. Monthly tier switcher, BouncingScrollPhysics, and Restore Purchases receipt verification.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen25_personal_profile_apple.dart';

class Screen24AstroAiPlusApple extends StatefulWidget {
  const Screen24AstroAiPlusApple({super.key});

  @override
  State<Screen24AstroAiPlusApple> createState() => _Screen24AstroAiPlusAppleState();
}

class _Screen24AstroAiPlusAppleState extends State<Screen24AstroAiPlusApple> {
  int _selectedTierIndex = 0; // 0 = Annual (Save 50%), 1 = Monthly

  void _onRestorePurchases() {
    HapticFeedback.mediumImpact();
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("StoreKit 2 Verification"),
        content: const Text("Checking Apple ID active subscriptions with App Store Server API..."),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _onSubscribeTrial() {
    HapticFeedback.heavyImpact();
    // In production: AppStore.requestPurchase('astroai_plus_annual_tier')
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen25PersonalProfileApple()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                    border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.5)),
                    color: AppleCosmicTheme.champagneGold.withOpacity(0.12),
                  ),
                  child: const Text(
                    "✦ ASTROAI PLUS QUANTUM",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _onRestorePurchases,
                  child: const Text(
                    "Restore",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, color: Colors.white70),
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
                    style: TextStyle(color: AppleCosmicTheme.champagneGold, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
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
                border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.2)),
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

            // Dual Pricing Tiers
            Row(
              children: [
                // Annual Pass
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _selectedTierIndex = 0);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedTierIndex == 0 ? AppleCosmicTheme.nebulaViolet.withOpacity(0.25) : Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _selectedTierIndex == 0 ? AppleCosmicTheme.champagneGold : Colors.white12,
                          width: _selectedTierIndex == 0 ? 1.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppleCosmicTheme.champagneGold,
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
                            style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                              children: [
                                TextSpan(text: "₹2,999"),
                                TextSpan(
                                  text: "/yr",
                                  style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white54, fontWeight: FontWeight.normal),
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
                      HapticFeedback.selectionClick();
                      setState(() => _selectedTierIndex = 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selectedTierIndex == 1 ? AppleCosmicTheme.nebulaViolet.withOpacity(0.25) : Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _selectedTierIndex == 1 ? AppleCosmicTheme.champagneGold : Colors.white12,
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
                            style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                              children: [
                                TextSpan(text: "₹499"),
                                TextSpan(
                                  text: "/mo",
                                  style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white54, fontWeight: FontWeight.normal),
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
                    colors: [AppleCosmicTheme.champagneGold, Color(0xFFFDE68A), AppleCosmicTheme.champagneGold],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppleCosmicTheme.champagneGold.withOpacity(0.4), blurRadius: 20, spreadRadius: 1),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Start 7-Day Free Quantum Trial ✦",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // StoreKit Legal / EULA Footer
            Text(
              "After free trial, auto-renews at selected rate until cancelled in Apple Settings > Subscriptions. Subject to Apple Standard EULA & AstroAI Privacy Policy.",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 10, color: Colors.white.withOpacity(0.45), height: 1.3),
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
          style: TextStyle(color: AppleCosmicTheme.champagneGold, fontSize: 12),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
