// android/lib/screens/screen23_notification_preferences_android.dart
// Screen 23: Notification Preferences (Google Android Target)
// Features: Android 13+ (API 33+) Notification Channels, POST_NOTIFICATIONS runtime permission,
// Material 3 Switch toggles, ClampingScrollPhysics, and high-frequency Rahu Kaal alert channels.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen24_astro_ai_plus_android.dart';

class Screen23NotificationPreferencesAndroid extends StatefulWidget {
  const Screen23NotificationPreferencesAndroid({super.key});

  @override
  State<Screen23NotificationPreferencesAndroid> createState() => _Screen23NotificationPreferencesAndroidState();
}

class _Screen23NotificationPreferencesAndroidState extends State<Screen23NotificationPreferencesAndroid> {
  bool _morningBriefing = true;
  bool _rahuKaalAlert = true;
  bool _exactTransits = true;
  bool _synastryMoods = false;

  void _onNavigateToPaywall() {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Screen24AstroAiPlusAndroid(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Monospace Subheader
            const Text(
              "ANDROID NOTIFICATION CHANNELS (API 33+)",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
            ),
            const SizedBox(height: 2),
            const Text(
              "Alert Calibration",
              style: TextStyle(fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              "Configures real-time push dispatches synchronized with exact astronomical orb aspects.",
              style: TextStyle(fontFamily: 'Roboto', fontSize: 12.5, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Notification Channel 1
            _buildMaterialToggleCard(
              title: "Morning Cosmic Briefing (07:30 IST)",
              channelId: "channel_morning_briefing",
              subtitle: "Daily Nakshatra, Hora & high-leverage power window digest.",
              value: _morningBriefing,
              onChanged: (val) {
                HapticFeedback.vibrate();
                setState(() => _morningBriefing = val);
              },
            ),

            const SizedBox(height: 12),

            // Notification Channel 2
            _buildMaterialToggleCard(
              title: "Rahu Kaal & Retrograde Warnings",
              channelId: "channel_rahu_kaal_alerts",
              subtitle: "High-priority Android heads-up notification prior to high-friction windows.",
              value: _rahuKaalAlert,
              onChanged: (val) {
                HapticFeedback.vibrate();
                setState(() => _rahuKaalAlert = val);
              },
            ),

            const SizedBox(height: 12),

            // Notification Channel 3
            _buildMaterialToggleCard(
              title: "Exact Degree Transit Triggers",
              channelId: "channel_planetary_transits",
              subtitle: "When transiting planets aspect your natal degrees within 1° orb.",
              value: _exactTransits,
              onChanged: (val) {
                HapticFeedback.vibrate();
                setState(() => _exactTransits = val);
              },
            ),

            const SizedBox(height: 12),

            // Notification Channel 4
            _buildMaterialToggleCard(
              title: "Partner Synastry Mood Shifts",
              channelId: "channel_synastry_moods",
              subtitle: "Dispatches heads-up when partner's Moon enters sensitive 8th/12th houses.",
              value: _synastryMoods,
              onChanged: (val) {
                HapticFeedback.vibrate();
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
                    colors: [AndroidCosmicTheme.stellarGold, AndroidCosmicTheme.nebulaViolet],
                  ),
                  boxShadow: [
                    BoxShadow(color: AndroidCosmicTheme.stellarGold.withOpacity(0.35), blurRadius: 18),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Explore AstroAI Plus (Screen 24) →",
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.black),
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

  Widget _buildMaterialToggleCard({
    required String title,
    required String channelId,
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
                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  "Channel ID: $channelId",
                  style: const TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: AndroidCosmicTheme.stellarGold),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 11, color: Colors.white.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: value,
            activeColor: AndroidCosmicTheme.nebulaViolet,
            activeTrackColor: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4),
            inactiveThumbColor: Colors.white70,
            inactiveTrackColor: Colors.white12,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
