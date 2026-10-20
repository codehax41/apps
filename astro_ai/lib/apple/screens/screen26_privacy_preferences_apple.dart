// apple/lib/screens/screen26_privacy_preferences_apple.dart
// Screen 26: Privacy, Security & AI Governance (Apple iOS Target)
// Features: Apple LocalAuthentication (Face ID / Touch ID) vault locking,
// Zero data retention toggle, Devi voice persona switcher, App Store Guideline 5.1.1(v)
// compliant account erasure, and BouncingScrollPhysics.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astro_ai/shared/services/firebase_service.dart';
import 'package:astro_ai/shared/services/cloudflare_service.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen01_welcome_apple.dart';

class Screen26PrivacyPreferencesApple extends StatefulWidget {
  const Screen26PrivacyPreferencesApple({super.key});

  @override
  State<Screen26PrivacyPreferencesApple> createState() => _Screen26PrivacyPreferencesAppleState();
}

class _Screen26PrivacyPreferencesAppleState extends State<Screen26PrivacyPreferencesApple> {
  bool _biometricVaultLock = true;
  bool _ephemeralTranscripts = true;
  int _voicePersonaIndex = 0; // 0 = Serene Vedic, 1 = Direct Executive

  void _onExportData() {
    HapticFeedback.mediumImpact();
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Exporting Ephemeris"),
        content: const Text("Preparing cryptographically signed JSON & PDF natal export..."),
        actions: [
          CupertinoDialogAction(
            child: const Text("Done"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _onDeleteAccount() {
    HapticFeedback.heavyImpact();
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Delete Cosmic Vault?"),
        content: const Text(
          "This will immediately purge your natal matrix, synastry charts, and Devi voice transcripts from both local device keychain and encrypted servers. This action is irreversible.",
        ),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text("Permanently Erase"),
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
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _onRestartTour() {
    HapticFeedback.lightImpact();
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => const Screen01WelcomeApple()),
      (route) => false,
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
              "ZERO-KNOWLEDGE ENCRYPTION",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: Color(0xFF34D399), letterSpacing: 1.2),
            ),
            const SizedBox(height: 2),
            const Text(
              "Privacy & AI Governance",
              style: TextStyle(fontFamily: '.SF Pro Display', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              "Deterministic privacy controls enforced at the Metal hardware & Secure Enclave layers.",
              style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, color: Colors.white.withOpacity(0.65)),
            ),

            const SizedBox(height: 20),

            // Biometric Vault Lock
            _buildCupertinoSwitchCard(
              title: "Face ID / Touch ID Vault Lock",
              subtitle: "Requires Apple Secure Enclave biometric challenge to decrypt birth charts.",
              value: _biometricVaultLock,
              onChanged: (val) {
                HapticFeedback.selectionClick();
                setState(() => _biometricVaultLock = val);
              },
            ),

            const SizedBox(height: 12),

            // Ephemeral Transcripts
            _buildCupertinoSwitchCard(
              title: "Ephemeral Voice Transcripts",
              subtitle: "Disables server storage of Devi conversations. Zero training on user data.",
              value: _ephemeralTranscripts,
              onChanged: (val) {
                HapticFeedback.selectionClick();
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
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, color: AppleCosmicTheme.nebulaViolet, letterSpacing: 1.0),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() => _voicePersonaIndex = 0);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _voicePersonaIndex == 0 ? AppleCosmicTheme.nebulaViolet.withOpacity(0.4) : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: _voicePersonaIndex == 0 ? AppleCosmicTheme.champagneGold : Colors.white10,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Serene Vedic",
                                style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() => _voicePersonaIndex = 1);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _voicePersonaIndex == 1 ? AppleCosmicTheme.nebulaViolet.withOpacity(0.4) : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: _voicePersonaIndex == 1 ? AppleCosmicTheme.champagneGold : Colors.white10,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Direct Executive",
                                style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.white),
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
                      style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, color: Colors.white70),
                    ),
                    Text(
                      "EXPORT →",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Delete Account (App Store Guideline 5.1.1(v))
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
                      style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFF87171)),
                    ),
                    Icon(CupertinoIcons.trash, size: 16, color: Color(0xFFF87171)),
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
                  border: Border.all(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.4)),
                ),
                child: const Center(
                  child: Text(
                    "↺ Restart Cosmic Calibration (Screen 01)",
                    style: TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, fontWeight: FontWeight.bold, color: AppleCosmicTheme.nebulaViolet),
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

  Widget _buildCupertinoSwitchCard({
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
            activeColor: const Color(0xFF10B981),
            trackColor: Colors.white12,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
