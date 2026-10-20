// lib/shared/screens/onboarding/screen_start_free_om_ai.dart
// Screen 2: Start Free - "Your first question is free"
// Direct 1:1 Implementation matching Reference Screenshot (media_1792523863346_01e09b8f.jpg)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screen_voice_session.dart';
import '../../../android/screens/screen24_astro_ai_plus_android.dart';

class ScreenStartFreeOmAi extends StatelessWidget {
  const ScreenStartFreeOmAi({super.key});

  final List<String> _promptSuggestions = const [
    "Should I switch jobs this year?",
    "When will I get married?",
    "When will my money problems end?",
    "Is this the right time to start a business?",
  ];

  void _onSelectPrompt(BuildContext context, String question) {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScreenVoiceSession(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131217),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Back Arrow
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
                  child: const Icon(Icons.arrow_back, size: 20, color: Colors.white70),
                ),
              ),

              const SizedBox(height: 28),

              // ॐ AI Logo Graphic
              Row(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFE07A5F), Color(0xFFF4A261)],
                    ).createShader(bounds),
                    child: const Text(
                      "ॐ AI",
                      style: TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Subtitle in terracotta uppercase
              const Text(
                "START FREE",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFFE07A5F),
                ),
              ),

              const SizedBox(height: 8),

              // Headline: "Your first question is free"
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.15,
                  ),
                  children: [
                    TextSpan(text: "Your "),
                    TextSpan(
                      text: "first\nquestion ",
                      style: TextStyle(color: Color(0xFFE07A5F)),
                    ),
                    TextSpan(text: "is free"),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Section Label: ASK ABOUT
              const Text(
                "ASK ABOUT",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  color: Colors.white54,
                ),
              ),

              const SizedBox(height: 14),

              // Suggestion Pills
              ..._promptSuggestions.map((q) => _buildPromptBubble(context, q)),

              const SizedBox(height: 30),

              // Free Features Checklist Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1D24),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  children: [
                    _buildChecklistRow("Free Kundli"),
                    const SizedBox(height: 14),
                    _buildChecklistRow("Free daily horoscope"),
                    const SizedBox(height: 14),
                    _buildChecklistRow("First Gun Milan match free"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Footer: More questions with Om.AI Premium
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Screen24AstroAiPlusAndroid()),
                    );
                  },
                  child: Text(
                    "More questions with Om.AI Premium",
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.55),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromptBubble(BuildContext context, String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _onSelectPrompt(context, question),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1D24),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.06)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white38),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistRow(String title) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Color(0xFFE07A5F),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 14, color: Colors.white),
        ),
        const SizedBox(width: 14),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
