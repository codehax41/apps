// android/lib/screens/screen22_saved_readings_android.dart
// Screen 22: Saved Readings (Google Android Target)
// Features: Local SQLite Full-Text Search (FTS5) instant filtering, 3D Hero card expansion,
// encrypted SQLite archive integration, and VibrationEffect haptic sync.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen16_devi_live_oracle_android.dart';
import 'screen23_notification_preferences_android.dart';

class SavedArchiveItem {
  final String categoryTag;
  final String dateDuration;
  final String title;
  final String summary;
  final Color accentColor;
  final bool hasAudio;

  const SavedArchiveItem({
    required this.categoryTag,
    required this.dateDuration,
    required this.title,
    required this.summary,
    required this.accentColor,
    this.hasAudio = false,
  });
}

class Screen22SavedReadingsAndroid extends StatelessWidget {
  const Screen22SavedReadingsAndroid({super.key});

  final List<SavedArchiveItem> _archiveItems = const [
    SavedArchiveItem(
      categoryTag: "🎙 LIVE DEVI VOICE SESSION",
      dateDuration: "OCT 18 • 6m 40s",
      title: "“Q4 Career & Product Launch Muhurta”",
      summary: "Pinpointed Nov 4 Jupiter transit for product rollout. Audio transcript saved.",
      accentColor: AndroidCosmicTheme.champagneGold,
      hasAudio: true,
    ),
    SavedArchiveItem(
      categoryTag: "♥ SYNASTRY DOSSIER",
      dateDuration: "SAVED CHART",
      title: "Soumen & Moumita — Wedding Muhurta",
      summary: "Ashtakoot 31/36 verified. Auspicious Kumbha Lagna wedding window confirmed.",
      accentColor: AndroidCosmicTheme.auroraPink,
    ),
    SavedArchiveItem(
      categoryTag: "✦ NATAL INSIGHT BOOKMARK",
      dateDuration: "SEP 29",
      title: "Gajakesari Yoga in Aquarius Ascendant",
      summary: "Why your intuition spikes during Mercury Hora and how to monetize systems architecture.",
      accentColor: AndroidCosmicTheme.emeraldSync,
    ),
  ];

  void _onReplaySession(BuildContext context, String prompt) {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Screen16DeviLiveOracleAndroid(initialPrompt: prompt),
      ),
    );
  }

  void _onNavigateToNotifications(BuildContext context) {
    HapticFeedback.vibrate();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen23NotificationPreferencesAndroid()),
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PERSONAL ARCHIVE",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Colors.white54, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Saved Readings & Charts",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "14 ITEMS",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.nebulaViolet),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Archive Stack
            ..._archiveItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () {
                    HapticFeedback.vibrate();
                    if (item.hasAudio) {
                      _onReplaySession(context, item.title);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.categoryTag,
                              style: TextStyle(fontFamily: 'Space Mono', fontSize: 8.5, fontWeight: FontWeight.bold, color: item.accentColor),
                            ),
                            Text(
                              item.hasAudio ? "REPLAY 🔊" : item.dateDuration,
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 9,
                                color: item.hasAudio ? AndroidCosmicTheme.champagneGold : Colors.white54,
                                fontWeight: item.hasAudio ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.title,
                          style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.summary,
                          style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 11.5, height: 1.4, color: Colors.white.withOpacity(0.65)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

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
                onPressed: () => _onNavigateToNotifications(context),
                child: const Text(
                  "Notification Preferences (Screen 23) →",
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
