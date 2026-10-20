// apple/lib/screens/screen25_personal_profile_apple.dart
// Screen 25: Personal Profile, Account Management, ₹7 Trial Status & Permanent Deletion (Apple iOS Target)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import '../../core/auth/auth_service.dart';
import '../../core/localization/language_manager.dart';
import '../../core/services/privacy_service.dart';
import '../../shared/screens/screen_privacy_policy.dart';
import 'screen01_welcome_apple.dart';

class Screen25PersonalProfileApple extends StatefulWidget {
  const Screen25PersonalProfileApple({super.key});

  @override
  State<Screen25PersonalProfileApple> createState() => _Screen25PersonalProfileAppleState();
}

class _Screen25PersonalProfileAppleState extends State<Screen25PersonalProfileApple> {
  final _auth = AuthService.instance;
  final _langMgr = LanguageManager.instance;

  void _showDeleteConfirmationDialog() {
    HapticFeedback.heavyImpact();
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Delete Entire Profile?"),
        content: const Text(
          "This permanently deletes your Astro AI account, birth chart data, conversations, preferences, voice history and associated profile data. This action cannot be undone.",
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context);
              await _auth.deleteEntireProfile();
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (context) => const Screen01WelcomeApple()),
                  (route) => false,
                );
              }
            },
            child: const Text("Delete Everything"),
          ),
        ],
      ),
    );
  }

  Future<void> _exportUserData() async {
    HapticFeedback.lightImpact();
    final jsonString = await PrivacyService.instance.exportUserData(_auth.currentUser?.id ?? 'guest');

    if (mounted) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("Data Export Complete"),
          content: SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: Text(
                jsonString,
                style: const TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: Colors.white70),
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Done"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final String languageName = _langMgr.currentLanguage.displayName;

    return ApplePlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            const Text(
              "COSMIC PASSPORT & VAULT",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 9.5,
                color: AppleCosmicTheme.champagneGold,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Identity Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    AppleCosmicTheme.champagneGold.withOpacity(0.16),
                    AppleCosmicTheme.nebulaViolet.withOpacity(0.12),
                    Colors.black87,
                  ],
                ),
                border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [AppleCosmicTheme.champagneGold, AppleCosmicTheme.nebulaViolet],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        (user?.displayName ?? "R")[0].toUpperCase(),
                        style: const TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? "Ramsundar",
                          style: const TextStyle(fontFamily: 'SF Pro Display', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          user?.email ?? "ramsundar.astro@gmail.com",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: Colors.white.withOpacity(0.65)),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/daivant_logo.webp', width: 32, height: 32),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Subscription Section
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppleCosmicTheme.champagneGold.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "CURRENT PLAN",
                        style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, letterSpacing: 1.2, color: Colors.white54),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppleCosmicTheme.emeraldSync.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "ACTIVE • 24H PASS",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AppleCosmicTheme.emeraldSync),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "1-Day Astro AI Pass (₹7)",
                    style: TextStyle(fontFamily: 'SF Pro Display', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Expires: Today at 23:59 IST • 21h Remaining",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: AppleCosmicTheme.champagneGold),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Voice Time Used", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text(
                        "${user?.formattedRemainingVoiceTime ?? "27:40"} remaining of 30:00",
                        style: const TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: (user?.voiceSecondsUsed ?? 140) / (user?.voiceSecondsAllowed ?? 1800),
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppleCosmicTheme.nebulaViolet),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Preferences
            const Text(
              "PREFERENCES",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, letterSpacing: 1.2, color: Colors.white54, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("AI Language", style: TextStyle(color: Colors.white, fontSize: 14)),
                    subtitle: Text(languageName, style: const TextStyle(color: AppleCosmicTheme.champagneGold, fontSize: 12)),
                    trailing: const Icon(CupertinoIcons.chevron_right, size: 14, color: Colors.white54),
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  ListTile(
                    title: const Text("Voice Provider", style: TextStyle(color: Colors.white, fontSize: 14)),
                    subtitle: Text(
                      _langMgr.currentLanguage.supportsIndianVoice ? "Sarvam Indic Voice AI" : "OpenAI Realtime",
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                    trailing: const Icon(CupertinoIcons.mic, size: 18, color: Colors.white54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Privacy & Security
            const Text(
              "PRIVACY & SECURITY",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, letterSpacing: 1.2, color: Colors.white54, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(CupertinoIcons.shield, color: AppleCosmicTheme.champagneGold, size: 20),
                    title: const Text("Privacy Policy", style: TextStyle(color: Colors.white, fontSize: 14)),
                    trailing: const Icon(CupertinoIcons.chevron_right, size: 14, color: Colors.white54),
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => const ScreenPrivacyPolicy()));
                    },
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  ListTile(
                    leading: const Icon(CupertinoIcons.doc_text, color: AppleCosmicTheme.champagneGold, size: 20),
                    title: const Text("Terms and Conditions", style: TextStyle(color: Colors.white, fontSize: 14)),
                    subtitle: const Text("₹7 trial pass terms, 30-min voice limit & disclaimers", style: TextStyle(color: Colors.white54, fontSize: 11)),
                    trailing: const Icon(CupertinoIcons.chevron_right, size: 14, color: Colors.white54),
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => const ScreenPrivacyPolicy()));
                    },
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  ListTile(
                    leading: const Icon(CupertinoIcons.arrow_down_doc, color: Colors.white70, size: 20),
                    title: const Text("Export My Data", style: TextStyle(color: Colors.white, fontSize: 14)),
                    onTap: _exportUserData,
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  ListTile(
                    leading: const Icon(CupertinoIcons.trash, color: Colors.redAccent, size: 20),
                    title: const Text("Delete Entire Profile", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                    onTap: _showDeleteConfirmationDialog,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: CupertinoButton(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14),
                onPressed: () async {
                  await _auth.signOut();
                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(builder: (context) => const Screen01WelcomeApple()),
                      (route) => false,
                    );
                  }
                },
                child: const Text("Log Out", style: TextStyle(color: Colors.white70)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
