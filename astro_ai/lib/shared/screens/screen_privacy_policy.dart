// lib/shared/screens/screen_privacy_policy.dart
// ASTROAI OS v5.0 - Dedicated Transparency, Data Retention & Privacy Policy Screen

import 'package:flutter/material.dart';
import '../../core/config/app_config.dart';
import '../../android/theme/android_theme.dart';

class ScreenPrivacyPolicy extends StatelessWidget {
  const ScreenPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AndroidCosmicTheme.oledVoid,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Privacy Policy & Security",
          style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ASTROAI OS ZERO-KNOWLEDGE PRIVACY CHARTER",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 9,
                letterSpacing: 1.4,
                color: AndroidCosmicTheme.champagneGold,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Effective: October 2026 • v5.0",
              style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: Colors.white54),
            ),
            const SizedBox(height: 18),

            _buildSection(
              "1. What Data We Collect",
              "We collect your Date of Birth, Exact Time of Birth, and Birthplace Coordinates solely to calculate mathematical astronomical ephemeris positions (Vedic Kundali, planetary longitudes, and divisional charts). We do not sell your personal information.",
            ),
            _buildSection(
              "2. How AI & Voice Audio is Handled",
              "When interacting with Devi AI via voice or text, audio packets are streamed in real-time through secure, encrypted backend gateways. We do not store raw audio recordings permanently. Text interactions are retained for ${AppConfig.aiConversationRetentionDays} days to maintain context before automated rolling deletion.",
            ),
            _buildSection(
              "3. Third-Party AI & Infrastructure",
              "AstroAI interfaces with enterprise AI providers (OpenAI Realtime and Sarvam AI for Indic voice streaming) via secure server-side tokens. Your birth coordinates are never used to train third-party foundation models.",
            ),
            _buildSection(
              "4. Payment Processing & Retention",
              "Payments for the 1-Day Astro AI Pass (₹7 INR) and subscriptions are processed by PCI-DSS certified payment providers. We retain only statutory transaction identifiers and invoice receipts required by financial regulations.",
            ),
            _buildSection(
              "5. How to Delete Your Data (Right to Erasure)",
              "You have absolute ownership of your cosmic profile. You can permanently erase all your data at any time directly in the app:\n\n"
              "Navigate to: Profile → Privacy & Security → Delete Entire Profile.\n\n"
              "This triggers a 15-step irreversible purge that deletes your account, birth records, Kundali caches, and chat histories.",
            ),
            _buildSection(
              "6. Contact Our Data Protection Officer",
              "For inquiries or data subject access requests, contact our compliance team at:\n${AppConfig.privacyContactEmail}",
            ),
            const SizedBox(height: 10),

            // Live Web Links for App Store & Google Play
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PUBLIC COMPLIANCE REPOSITORY",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: AndroidCosmicTheme.champagneGold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Online Policy URL:\n${AppConfig.privacyPolicyUrl}",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Data Deletion URL:\n${AppConfig.dataDeletionPolicyUrl}",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
