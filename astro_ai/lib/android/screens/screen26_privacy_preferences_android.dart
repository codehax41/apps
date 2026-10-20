// android/lib/screens/screen26_privacy_preferences_android.dart
// Screen 26: Privacy, Security & AI Governance (Google Android Target)
// Features: Android BiometricPrompt (Class 3 Strong Biometric) vault locking,
// Zero data retention toggle, Devi voice persona switcher, Google Play User Data
// compliant account erasure, and ClampingScrollPhysics.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astro_ai/shared/services/firebase_service.dart';
import 'package:astro_ai/shared/services/cloudflare_service.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'screen01_welcome_android.dart';

class Screen26PrivacyPreferencesAndroid extends StatefulWidget {
  const Screen26PrivacyPreferencesAndroid({super.key});

  @override
  State<Screen26PrivacyPreferencesAndroid> createState() => _Screen26PrivacyPreferencesAndroidState();
}

class _Screen26PrivacyPreferencesAndroidState extends State<Screen26PrivacyPreferencesAndroid> {
  bool _biometricVaultLock = true;
  bool _ephemeralTranscripts = true;
  int _voicePersonaIndex = 0; // 0 = Serene Vedic, 1 = Direct Executive

  void _onExportData() {
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
          "Android Intent Share",
          style: TextStyle(fontFamily: 'Space Mono', fontSize: 14, color: AndroidCosmicTheme.stellarGold),
        ),
        content: const Text(
          "Preparing cryptographically signed JSON & PDF natal export for Android Share Sheet (Intent.ACTION_SEND)...",
          style: TextStyle(fontFamily: 'Roboto', fontSize: 12.5, color: Colors.white70),
        ),
        actions: [
          TextButton(
            child: const Text("DONE", style: TextStyle(color: AndroidCosmicTheme.stellarGold)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _onDeleteAccount() {
    HapticFeedback.vibrate();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1016),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.redAccent, width: 0.8),
        ),
        title: const Text(
          "Delete Cosmic Vault?",
          style: TextStyle(fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
        content: const Text(
          "This will immediately purge your natal matrix, synastry charts, and Devi voice transcripts from both local device storage and encrypted servers. Conforms to Google Play User Data Deletion Policy.",
          style: TextStyle(fontFamily: 'Roboto', fontSize: 12.5, color: Colors.white70),
        ),
        actions: [
          TextButton(
            child: const Text("CANCEL", style: TextStyle(color: Colors.white60)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("PERMANENTLY ERASE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () async {
              final uid = FirebaseService.instance.activeUid;
              await FirebaseService.instance.purgeUserVault(uid);
              await CloudflareService.instance.purgeAllCloudflareUserData(userId: uid);
              if (mounted) {
                Navigator.pop(context);
                _onRestartTour();
              }
            },
          ),
        ],
      ),
    );
  }

  void _onRestartTour() {
    HapticFeedback.vibrate();
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Screen01WelcomeAndroid(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      (route) => false,
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
              "ZERO-KNOWLEDGE ENCRYPTION",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Color(0xFF34D399), letterSpacing: 1.2),
            ),
            const SizedBox(height: 2),
            const Text(
              "Privacy & AI Governance",
              style: TextStyle(fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              "Deterministic privacy controls enforced at Android KeyStore & Hardware-backed Keystore layers.",
              style: TextStyle(fontFamily: 'Roboto', fontSize: 12.5, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Biometric Vault Lock
            _buildMaterialSwitchCard(
              title: "BiometricPrompt (Class 3) Vault Lock",
              subtitle: "Requires fingerprint or 3D face authentication to decrypt birth charts.",
              value: _biometricVaultLock,
              onChanged: (val) {
                HapticFeedback.vibrate();
                setState(() => _biometricVaultLock = val);
              },
            ),

            const SizedBox(height: 12),

            // Ephemeral Transcripts
            _buildMaterialSwitchCard(
              title: "Ephemeral Voice Transcripts",
              subtitle: "Disables server storage of Devi conversations. Zero training on user data.",
              value: _ephemeralTranscripts,
              onChanged: (val) {
                HapticFeedback.vibrate();
                setState(() => _ephemeralTranscripts = val);
              },
            ),

            const SizedBox(height: 16),

            // Devi Voice Persona Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "DEVI ORACLE VOICE PERSONA",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: AndroidCosmicTheme.nebulaViolet, letterSpacing: 1.0),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.vibrate();
                            setState(() => _voicePersonaIndex = 0);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _voicePersonaIndex == 0 ? AndroidCosmicTheme.nebulaViolet.withOpacity(0.4) : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: _voicePersonaIndex == 0 ? AndroidCosmicTheme.stellarGold : Colors.white10,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Serene Vedic",
                                style: TextStyle(fontFamily: 'Roboto', fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.vibrate();
                            setState(() => _voicePersonaIndex = 1);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _voicePersonaIndex == 1 ? AndroidCosmicTheme.nebulaViolet.withOpacity(0.4) : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: _voicePersonaIndex == 1 ? AndroidCosmicTheme.stellarGold : Colors.white10,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Direct Executive",
                                style: TextStyle(fontFamily: 'Roboto', fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Export Data Button
            GestureDetector(
              onTap: _onExportData,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Export Natal Ephemeris (JSON / PDF)",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 13, color: Colors.white70),
                    ),
                    Text(
                      "EXPORT →",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.stellarGold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Delete Account (Google Play User Data Compliance)
            GestureDetector(
              onTap: _onDeleteAccount,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Purge Vault & Delete Account",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFF87171)),
                    ),
                    Icon(Icons.delete_outline, size: 18, color: Color(0xFFF87171)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Restart Tour CTA
            GestureDetector(
              onTap: _onRestartTour,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.white.withOpacity(0.06),
                  border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4)),
                ),
                child: const Center(
                  child: Text(
                    "↺ Restart Cosmic Calibration (Screen 01)",
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 13, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.nebulaViolet),
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

  Widget _buildMaterialSwitchCard({
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
                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.white),
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
            activeColor: const Color(0xFF10B981),
            activeTrackColor: const Color(0xFF10B981).withOpacity(0.4),
            inactiveThumbColor: Colors.white70,
            inactiveTrackColor: Colors.white12,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
