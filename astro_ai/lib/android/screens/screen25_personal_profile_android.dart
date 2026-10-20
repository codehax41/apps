// android/lib/screens/screen25_personal_profile_android.dart
// Screen 25: Personal Profile, Account Management, ₹7 Trial Status & Permanent Deletion (Android Target)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import '../../core/auth/auth_service.dart';
import '../../core/localization/language_manager.dart';
import '../../core/localization/language_registry.dart';
import '../../core/services/privacy_service.dart';
import '../../shared/screens/screen_privacy_policy.dart';
import 'screen01_welcome_android.dart';

class Screen25PersonalProfileAndroid extends StatefulWidget {
  const Screen25PersonalProfileAndroid({super.key});

  @override
  State<Screen25PersonalProfileAndroid> createState() => _Screen25PersonalProfileAndroidState();
}

class _Screen25PersonalProfileAndroidState extends State<Screen25PersonalProfileAndroid> {
  final _auth = AuthService.instance;
  final _langMgr = LanguageManager.instance;

  void _showDeleteConfirmationDialog() {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF13131F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "Delete Entire Profile?",
          style: TextStyle(
            fontFamily: 'Cormorant Garamond',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        content: const Text(
          "This permanently deletes your Astro AI account, birth chart data, conversations, preferences, voice history and associated profile data. This action cannot be undone.",
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 13,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              Navigator.pop(context);
              await _auth.deleteEntireProfile();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Your Astro AI profile has been permanently deleted.")),
                );
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Screen01WelcomeAndroid()),
                  (route) => false,
                );
              }
            },
            child: const Text("Delete Everything", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _exportUserData() async {
    HapticFeedback.lightImpact();
    final jsonString = await PrivacyService.instance.exportUserData(_auth.currentUser?.id ?? 'guest');

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF13131F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Data Export Complete", style: TextStyle(color: Colors.white, fontSize: 18)),
          content: SizedBox(
            height: 220,
            child: SingleChildScrollView(
              child: Text(
                jsonString,
                style: const TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: Colors.white70),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Done", style: TextStyle(color: AndroidCosmicTheme.champagneGold)),
            ),
          ],
        ),
      );
    }
  }

  void _showLanguageSelectorModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AndroidCosmicTheme.oledVoid,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select AI Language",
              style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: LanguageRegistry.supportedLanguages.length,
                itemBuilder: (context, i) {
                  final l = LanguageRegistry.supportedLanguages[i];
                  final isSel = l.id == _langMgr.currentLanguage.id;
                  return ListTile(
                    title: Text(l.displayName, style: TextStyle(color: isSel ? AndroidCosmicTheme.champagneGold : Colors.white)),
                    subtitle: Text(l.nativeName, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    trailing: isSel ? const Icon(Icons.check, color: AndroidCosmicTheme.champagneGold) : null,
                    onTap: () {
                      _langMgr.setLanguage(l);
                      setState(() {});
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final String languageName = _langMgr.currentLanguage.displayName;

    return AndroidPlatformScaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            const Text(
              "PROFILE & ACCOUNT VAULT",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 9.5,
                color: AndroidCosmicTheme.champagneGold,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Holographic Identity Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AndroidCosmicTheme.champagneGold.withOpacity(0.16),
                    AndroidCosmicTheme.nebulaViolet.withOpacity(0.12),
                    Colors.black87,
                  ],
                ),
                border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [AndroidCosmicTheme.champagneGold, AndroidCosmicTheme.nebulaViolet],
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
                          style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
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

            // -------------------------------------------------------------
            // SECTION: CURRENT SUBSCRIPTION PLAN & ₹7 PASS STATUS
            // -------------------------------------------------------------
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AndroidCosmicTheme.champagneGold.withOpacity(0.3)),
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
                          color: AndroidCosmicTheme.emeraldSync.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "ACTIVE • 24H PASS",
                          style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AndroidCosmicTheme.emeraldSync),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "1-Day Astro AI Pass (₹7)",
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Expires: Today at 23:59 IST • 21h Remaining",
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: AndroidCosmicTheme.champagneGold),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Voice Time Used",
                        style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, color: Colors.white70),
                      ),
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
                      valueColor: const AlwaysStoppedAnimation<Color>(AndroidCosmicTheme.nebulaViolet),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------------------------------------------
            // SECTION: PREFERENCES (AI Language, Voice, Haptics)
            // -------------------------------------------------------------
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
                    subtitle: Text(languageName, style: const TextStyle(color: AndroidCosmicTheme.champagneGold, fontSize: 12)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
                    onTap: _showLanguageSelectorModal,
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  ListTile(
                    title: const Text("Voice Provider", style: TextStyle(color: Colors.white, fontSize: 14)),
                    subtitle: Text(
                      _langMgr.currentLanguage.supportsIndianVoice ? "Sarvam Indic Voice AI" : "OpenAI Realtime",
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                    trailing: const Icon(Icons.record_voice_over, size: 18, color: Colors.white54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------------------------------------------
            // SECTION: PRIVACY & SECURITY (Export, Delete, Privacy Policy)
            // -------------------------------------------------------------
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
                    leading: const Icon(Icons.shield_outlined, color: AndroidCosmicTheme.champagneGold, size: 20),
                    title: const Text("Privacy Policy", style: TextStyle(color: Colors.white, fontSize: 14)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenPrivacyPolicy()));
                    },
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  ListTile(
                    leading: const Icon(Icons.description_outlined, color: AndroidCosmicTheme.champagneGold, size: 20),
                    title: const Text("Terms and Conditions", style: TextStyle(color: Colors.white, fontSize: 14)),
                    subtitle: const Text("₹7 trial pass terms, 30-min voice limit & disclaimers", style: TextStyle(color: Colors.white54, fontSize: 11)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenPrivacyPolicy()));
                    },
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  ListTile(
                    leading: const Icon(Icons.download_outlined, color: Colors.white70, size: 20),
                    title: const Text("Export My Data", style: TextStyle(color: Colors.white, fontSize: 14)),
                    subtitle: const Text("Download personal profile, charts & conversations", style: TextStyle(color: Colors.white54, fontSize: 11)),
                    onTap: _exportUserData,
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  ListTile(
                    leading: const Icon(Icons.delete_forever, color: Colors.redAccent, size: 20),
                    title: const Text("Delete Entire Profile", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                    subtitle: const Text("Permanently erase account, birth records & chats", style: TextStyle(color: Colors.white54, fontSize: 11)),
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
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: BorderSide(color: Colors.white.withOpacity(0.2)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () async {
                  await _auth.signOut();
                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Screen01WelcomeAndroid()),
                      (route) => false,
                    );
                  }
                },
                child: const Text("Log Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
