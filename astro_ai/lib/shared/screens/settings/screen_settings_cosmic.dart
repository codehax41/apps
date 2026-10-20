// lib/shared/screens/settings/screen_settings_cosmic.dart
// Screen 3: Settings, Profile Management & Complete Privacy Purge
// Direct 1:1 Implementation matching Reference Screenshot (media_1792522755440_2ef99fa0.jpg)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/auth/auth_service.dart';
import '../../../core/localization/language_manager.dart';
import '../../../core/localization/language_registry.dart';
import '../../../core/services/privacy_service.dart';
import '../screen_privacy_policy.dart';
import '../../widgets/batch4_celestial_painters.dart';
import '../../../android/screens/screen01_welcome_android.dart';
import '../../../android/screens/screen24_astro_ai_plus_android.dart';
import '../../../android/screens/screen25_personal_profile_android.dart';

class ScreenSettingsCosmic extends StatefulWidget {
  const ScreenSettingsCosmic({super.key});

  @override
  State<ScreenSettingsCosmic> createState() => _ScreenSettingsCosmicState();
}

class _ScreenSettingsCosmicState extends State<ScreenSettingsCosmic> {
  final _auth = AuthService.instance;
  final _langMgr = LanguageManager.instance;

  void _showDeleteAccountConfirmation() {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16151E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.redAccent.withOpacity(0.3)),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 24),
            SizedBox(width: 8),
            Text(
              "Delete Account?",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        content: const Text(
          "This triggers our certified 15-step permanent cryptographic purge:\n\n"
          "• All natal charts & Kundali divisional matrices\n"
          "• All palmistry biometric scans & reports\n"
          "• Complete chat dialogues & voice audio recordings\n"
          "• Payment authorizations & profile identifiers\n\n"
          "This action is permanent and cannot be undone.",
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12.5,
            color: Colors.white70,
            height: 1.45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Keep Account", style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE55353),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              Navigator.pop(context);
              final uid = _auth.currentUser?.id ?? 'guest_user';
              await PrivacyService.instance.executeCompleteProfilePurge(uid);
              await _auth.deleteEntireProfile();

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("All account data has been permanently deleted."),
                    backgroundColor: Color(0xFFE55353),
                  ),
                );
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Screen01WelcomeAndroid()),
                  (route) => false,
                );
              }
            },
            child: const Text("Delete Permanently", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF13131A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Language",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: LanguageRegistry.supportedLanguages.length,
                itemBuilder: (context, i) {
                  final l = LanguageRegistry.supportedLanguages[i];
                  final isSel = l.id == _langMgr.currentLanguage.id;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    title: Text(
                      l.displayName,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: isSel ? const Color(0xFFD4AF37) : Colors.white,
                        fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      l.nativeName,
                      style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 12),
                    ),
                    trailing: isSel
                        ? const Icon(Icons.check_circle, color: Color(0xFFD4AF37), size: 20)
                        : null,
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

  void _showHelpModal() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF13131A),
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
              "Help & Support Concierge",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Have questions about your Kundali calculations, natal telemetry, or the ₹7 trial pass?\n\n"
              "• Email: support@daivant.ai\n"
              "• Telemetry ID: 3572725729\n"
              "• Response Window: < 2 hours",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Close", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = _langMgr.currentLanguage.displayName;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E13),
      body: SafeArea(
        child: Stack(
          children: [
            // Top Right: 3D Golden Pisces Constellation
            const Positioned(
              top: 10,
              right: 12,
              child: GoldenPiscesConstellationWidget(width: 170, height: 125),
            ),

            // Main Content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1D26),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white70),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Header Title
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Menu Items (Direct 1:1 Match to Screenshot)
                  // 1. Edit Profile
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: "Edit Profile",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Screen25PersonalProfileAndroid()),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  // 2. Subscribe Now
                  _buildMenuItem(
                    icon: Icons.calendar_today_outlined,
                    title: "Subscribe Now",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Screen24AstroAiPlusAndroid()),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  // 3. Reva Policies
                  _buildMenuItem(
                    icon: Icons.shield_outlined,
                    title: "Reva Policies",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreenPrivacyPolicy()),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  // 4. Help & Support
                  _buildMenuItem(
                    icon: Icons.chat_bubble_outline,
                    title: "Help & Support",
                    onTap: _showHelpModal,
                  ),

                  const SizedBox(height: 18),

                  // 5. Language (showing current language on trailing e.g. "Hindi")
                  _buildMenuItem(
                    icon: Icons.chat_outlined,
                    title: "Language",
                    trailingText: currentLang,
                    onTap: _showLanguageSelector,
                  ),

                  const SizedBox(height: 24),

                  // Subtle horizontal divider line
                  Divider(color: Colors.white.withOpacity(0.08), height: 1),

                  const SizedBox(height: 24),

                  // 6. Log out
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: "Log out",
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      await _auth.signOut();
                      if (mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const Screen01WelcomeAndroid()),
                          (route) => false,
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 18),

                  // 7. Delete Account (Red Trash Icon & Red Text)
                  _buildMenuItem(
                    icon: Icons.delete_outline,
                    title: "Delete Account",
                    iconColor: const Color(0xFFE55353),
                    textColor: const Color(0xFFE55353),
                    containerGlowColor: const Color(0xFFE55353).withOpacity(0.18),
                    onTap: _showDeleteAccountConfirmation,
                  ),

                  const SizedBox(height: 60),

                  // Footer Telemetry & Sacred Geometry Watermark
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "User ID: 3572725729",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.40),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Version 2026.17.1",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 11.5,
                            color: Colors.white.withOpacity(0.35),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? trailingText,
    Color iconColor = Colors.white70,
    Color textColor = Colors.white,
    Color? containerGlowColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            // Circular Icon Button
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: containerGlowColor ?? const Color(0xFF1E1D26),
                shape: BoxShape.circle,
                border: Border.all(
                  color: containerGlowColor != null
                      ? containerGlowColor.withOpacity(0.5)
                      : Colors.white.withOpacity(0.08),
                ),
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 16),

            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),

            // Trailing text (e.g. "Hindi")
            if (trailingText != null)
              Text(
                trailingText,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.55),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
