// lib/shared/screens/screen_auth_unified.dart
// ASTROAI OS v5.0 - Unified Multi-Provider Authentication Screen (Google, Apple, Facebook, Email)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/auth/auth_service.dart';
import '../../core/localization/language_manager.dart';
import '../../core/localization/app_strings.dart';
import '../../android/theme/android_theme.dart';
import 'screen_privacy_policy.dart';

class ScreenAuthUnified extends StatefulWidget {
  final VoidCallback onAuthenticated;

  const ScreenAuthUnified({super.key, required this.onAuthenticated});

  @override
  State<ScreenAuthUnified> createState() => _ScreenAuthUnifiedState();
}

class _ScreenAuthUnifiedState extends State<ScreenAuthUnified> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordMode = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSocialAuth(String providerId) async {
    HapticFeedback.mediumImpact();
    try {
      await AuthService.instance.signInWithProvider(providerId);
      widget.onAuthenticated();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unable to sign you in with $providerId. Please try again.")),
        );
      }
    }
  }

  void _showEmailSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AndroidCosmicTheme.oledVoid,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Continue with Email",
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Sign in or register to sync your birth chart across devices.",
                style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, color: Colors.white70),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email address",
                  labelStyle: const TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.06),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              if (_isPasswordMode) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.06),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AndroidCosmicTheme.champagneGold,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () async {
                    if (!_isPasswordMode) {
                      setSheetState(() => _isPasswordMode = true);
                    } else {
                      Navigator.pop(context);
                      await _handleSocialAuth('email');
                    }
                  },
                  child: Text(
                    _isPasswordMode ? "Sign In / Register" : "Continue",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openPrivacyPolicy() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ScreenPrivacyPolicy()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langId = LanguageManager.instance.currentLanguage.id;

    return Scaffold(
      backgroundColor: AndroidCosmicTheme.oledVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Top Title
              const Text(
                "SECURE VAULT AUTHENTICATION",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 9,
                  letterSpacing: 1.5,
                  color: AndroidCosmicTheme.champagneGold,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              // Central Daivant Brand Emblem
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.55),
                      blurRadius: 32,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: AndroidCosmicTheme.champagneGold.withOpacity(0.2),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/daivant_logo.webp',
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Save Your Cosmic Journey",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Your birth ephemeris and AI consultations are secured with zero-knowledge platform credentials.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.65),
                  height: 1.5,
                ),
              ),

              const Spacer(),

              // 1. Continue with Google
              _buildAuthButton(
                icon: const Text("G", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                label: AppStrings.get('auth_google', langCode: langId),
                onTap: () => _handleSocialAuth('google'),
              ),

              const SizedBox(height: 12),

              // 2. Continue with Apple
              _buildAuthButton(
                icon: const Icon(Icons.apple, size: 22, color: Colors.white),
                label: AppStrings.get('auth_apple', langCode: langId),
                onTap: () => _handleSocialAuth('apple'),
              ),

              const SizedBox(height: 12),

              // 3. Continue with Facebook
              _buildAuthButton(
                icon: const Text("f", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1877F2))),
                label: AppStrings.get('auth_facebook', langCode: langId),
                onTap: () => _handleSocialAuth('facebook'),
              ),

              const SizedBox(height: 12),

              // 4. Continue with Email
              _buildAuthButton(
                icon: const Icon(Icons.mail_outline, size: 18, color: Colors.white70),
                label: AppStrings.get('auth_email', langCode: langId),
                onTap: _showEmailSheet,
              ),

              const SizedBox(height: 24),

              // Legal disclaimers
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _openPrivacyPolicy,
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.55),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text("  •  ", style: TextStyle(color: Colors.white.withOpacity(0.3))),
                  GestureDetector(
                    onTap: _openPrivacyPolicy,
                    child: Text(
                      "Terms of Service",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.55),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.04),
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withOpacity(0.12)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
