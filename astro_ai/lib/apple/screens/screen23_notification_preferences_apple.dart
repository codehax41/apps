// apple/lib/screens/screen23_notification_preferences_apple.dart
// Screen 23: Notification Preferences (Apple iOS Target)
// Features: Apple UNUserNotificationCenter Time-Sensitive Notification entitlements,
// CupertinoSwitch ergonomics with fluid spring physics, and telemetry alerts calibration.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen24_astro_ai_plus_apple.dart';

class Screen23NotificationPreferencesApple extends StatefulWidget {
  const Screen23NotificationPreferencesApple({super.key});

  @override
  State<Screen23NotificationPreferencesApple> createState() => _Screen23NotificationPreferencesAppleState();
}

class _Screen23NotificationPreferencesAppleState extends State<Screen23NotificationPreferencesApple> {
  bool _morningBriefing = true;
  bool _rahuKaalAlert = true;
  bool _exactTransits = true;
  bool _synastryMoods = false;

  void _onNavigateToPaywall() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen24AstroAiPlusApple()),
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
              "CELESTIAL TELEMETRY PINGS",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
            ),
            const SizedBox(height: 2),
            const Text(
              "Alert Calibration",
              style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              "Configures real-time push dispatches synchronized with exact astronomical orb aspects.",
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Toggles Stack
            _buildCupertinoToggleCard(
              title: "Morning Cosmic Briefing (07:30 IST)",
              subtitle: "Daily Nakshatra, Hora & high-leverage power window digest.",
              value: _morningBriefing,
              onChanged: (val) {
                HapticFeedback.selectionClick();
                setState(() => _morningBriefing = val);
              },
            ),

            const SizedBox(height: 12),

            _buildCupertinoToggleCard(
              title: "Rahu Kaal & Retrograde Warnings",
              subtitle: "15-minute Time-Sensitive iOS alert prior to high-friction windows.",
              value: _rahuKaalAlert,
              onChanged: (val) {
                HapticFeedback.selectionClick();
                setState(() => _rahuKaalAlert = val);
              },
            ),

            const SizedBox(height: 12),

            _buildCupertinoToggleCard(
              title: "Exact Degree Transit Triggers",
              subtitle: "When transiting planets aspect your natal degrees within 1° orb.",
              value: _exactTransits,
              onChanged: (val) {
                HapticFeedback.selectionClick();
                setState(() => _exactTransits = val);
              },
            ),

            const SizedBox(height: 12),

            _buildCupertinoToggleCard(
              title: "Partner Synastry Mood Shifts",
              subtitle: "Dispatches heads-up when partner's Moon enters sensitive 8th/12th houses.",
              value: _synastryMoods,
              onChanged: (val) {
                HapticFeedback.selectionClick();
                setState(() => _synastryMoods = val);
              },
            ),

            const SizedBox(height: 28),

            // Bottom CTA
            GestureDetector(
              onTap: _onNavigateToPaywall,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AppleCosmicTheme.champagneGold, AppleCosmicTheme.nebulaViolet],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppleCosmicTheme.champagneGold.withOpacity(0.35), blurRadius: 18),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Explore AstroAI Plus (Screen 24) →",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.black),
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

  Widget _buildCupertinoToggleCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
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
                Text(
                  title,
                  style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CupertinoSwitch(
            value: value,
            activeColor: AppleCosmicTheme.nebulaViolet,
            trackColor: Colors.white12,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
