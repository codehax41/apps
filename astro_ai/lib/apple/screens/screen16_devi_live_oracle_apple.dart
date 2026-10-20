// apple/lib/screens/screen16_devi_live_oracle_apple.dart
// Screen 16: Live Speaking AI Lady Oracle "Devi" (Apple iOS Target)
// Features: Living 3D Iridescent Intelligence Entity with Thin-Film Optical Interference,
// Speech-reactive acoustic shockwaves, 7-Bar voice equalizer, and Apple CoreHaptics.

import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astro_ai/shared/engine/devi_guardrail_router.dart';
import 'package:astro_ai/shared/services/firebase_service.dart';
import 'package:astro_ai/shared/services/cloudflare_service.dart';
import 'package:astro_ai/shared/engine/3d/devi_oracle_3d_entity.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'screen17_guided_questions_apple.dart';

class Screen16DeviLiveOracleApple extends StatefulWidget {
  final String? initialPrompt;

  const Screen16DeviLiveOracleApple({super.key, this.initialPrompt});

  @override
  State<Screen16DeviLiveOracleApple> createState() => _Screen16DeviLiveOracleAppleState();
}

class _Screen16DeviLiveOracleAppleState extends State<Screen16DeviLiveOracleApple>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  final TextEditingController _inputController = TextEditingController();

  DeviOracleState _oracleState = DeviOracleState.idle;
  double _audioAmplitude = 0.0;
  bool _isSpeaking = false;
  bool _isVoiceMuted = false;
  String _currentTag = "NATAL + D10 DASAMSA SYNTHESIS";
  String _currentTranscript =
      "“Namaste Ramsundar. Because your Mercury Antardasha just activated inside your 10th House Mars, November brings a major architecture leadership offer.”";

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat(reverse: true);

    if (widget.initialPrompt != null) {
      _processQuery(widget.initialPrompt!);
    }
  }

  @override
  void dispose() {
    _floatController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _processQuery(String query) {
    HapticFeedback.mediumImpact();

    // 1. Enter 3D Thinking State
    setState(() {
      _oracleState = DeviOracleState.thinking;
      _isSpeaking = false;
      _audioAmplitude = 0.25;
      _currentTag = "NEURAL VEDIC SYNTHESIS IN PROGRESS...";
    });

    // 2. Evaluate against Deterministic Guardrails
    final evaluation = DeviGuardrailRouter.evaluate(query);

    final String responseText = !evaluation.isAllowed
        ? evaluation.enforcedResponse!
        : "“Regarding ‘$query’, your exalted Moon in Rohini Pada 1 grounds your vision while 10th House Mars in Scorpio empowers executive execution. Initiate action during your Abhijit Muhurta at 11:44 AM IST.”";

    // 3. Transition to 3D Speaking State after synthesis
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _oracleState = DeviOracleState.speaking;
        _isSpeaking = true;
        _audioAmplitude = 0.85;
        _currentTag = !evaluation.isAllowed ? "GUARDRAIL REFUSAL ENFORCED" : "VEDIC DIVINATION & SYNTHESIS";
        _currentTranscript = responseText;
      });

      // 4. Persist Chat Session & Generation Telemetry
      CloudflareService.instance.storeChatSession(
        sessionId: "session_${DateTime.now().millisecondsSinceEpoch}",
        userId: FirebaseService.instance.activeUid,
        messages: [
          {"role": "user", "text": query, "timestamp": DateTime.now().toIso8601String()},
          {
            "role": "devi_oracle",
            "text": responseText,
            "guardrail": !evaluation.isAllowed ? evaluation.category.toString() : "passed",
            "timestamp": DateTime.now().toIso8601String()
          },
        ],
        metadata: {
          "tag": _currentTag,
          "platform": "apple_ios",
        },
      );

      // Simulate Speech completion
      Future.delayed(const Duration(seconds: 7), () {
        if (mounted) {
          setState(() {
            _oracleState = DeviOracleState.idle;
            _isSpeaking = false;
            _audioAmplitude = 0.0;
          });
        }
      });
    });
  }

  void _onToggleVoice() {
    HapticFeedback.selectionClick();
    setState(() => _isVoiceMuted = !_isVoiceMuted);
  }

  void _openGuidedQuestions() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen17GuidedQuestionsApple()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
      body: Column(
        children: [
          // Top Navigation & Voice Status Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LIVE 3D ORACLE INTEL",
                      style: TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 9,
                        letterSpacing: 1.2,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Devi AI Entity",
                      style: TextStyle(
                        fontFamily: '.SF Pro Display',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _onToggleVoice,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.12)),
                        ),
                        child: Icon(
                          _isVoiceMuted ? CupertinoIcons.speaker_slash : CupertinoIcons.speaker_2,
                          size: 16,
                          color: _isVoiceMuted ? AppleCosmicTheme.roseWarning : AppleCosmicTheme.champagneGold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _openGuidedQuestions,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppleCosmicTheme.nebulaViolet.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.5)),
                        ),
                        child: const Row(
                          children: [
                            Icon(CupertinoIcons.sparkles, size: 12, color: AppleCosmicTheme.champagneGold),
                            SizedBox(width: 4),
                            Text(
                              "QUESTIONS",
                              style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, fontWeight: FontWeight.bold, color: AppleCosmicTheme.champagneGold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Main Interactive Body
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Living 3D Iridescent Intelligence Entity (Devi 3D Oracle)
                  AnimatedBuilder(
                    animation: _floatController,
                    builder: (context, child) {
                      final floatOffset = math.sin(_floatController.value * 2 * math.pi) * 4;
                      return Transform.translate(
                        offset: Offset(0, floatOffset),
                        child: DeviOracle3DEntity(
                          state: _oracleState,
                          audioLevel: _audioAmplitude,
                          size: 215.0,
                          onTap: () {
                            if (_oracleState == DeviOracleState.idle) {
                              _processQuery("Analyze my 10th House Mars career transit");
                            }
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  // 7-Bar Live Voice Equalizer & Oracle State Telemetry
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildEqBar(10, 0.2),
                      _buildEqBar(18, 0.4),
                      _buildEqBar(26, 0.8),
                      _buildEqBar(16, 0.5),
                      _buildEqBar(24, 0.9),
                      _buildEqBar(18, 0.4),
                      _buildEqBar(12, 0.3),
                      const SizedBox(width: 8),
                      Text(
                        _oracleState == DeviOracleState.speaking
                            ? "DEVI SPEAKING 3D ACOUSTIC WAVE..."
                            : _oracleState == DeviOracleState.thinking
                                ? "DEVI SYNTHESIZING VEDIC MATRICES..."
                                : "3D ORACLE READY • TOUCH TO INTERACT",
                        style: const TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                          color: AppleCosmicTheme.champagneGold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Spoken Live Transcript Card with Ephemeris Tags
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppleCosmicTheme.nebulaViolet.withOpacity(0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _currentTag,
                              style: const TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 8,
                                letterSpacing: 1.1,
                                color: AppleCosmicTheme.nebulaViolet,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppleCosmicTheme.emeraldSync.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "3D NEURAL CORE ACTIVE",
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: AppleCosmicTheme.emeraldSync,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _currentTranscript,
                          style: const TextStyle(
                            fontFamily: 'Cormorant Garamond',
                            fontSize: 18,
                            height: 1.35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Preset Vedic Questions Chips (Horizontal Scroll)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildPromptChip("💼 Career & Dasamsa Pivot", "When is my peak leadership promotion window?"),
                        _buildPromptChip("💎 Wealth & 11th House", "How do I maximize my financial accumulation in Jupiter Dasha?"),
                        _buildPromptChip("💍 Marriage & Synastry", "When will my 7th House Kalatra transit activate?"),
                        _buildPromptChip("🧿 Health & Ayur-Veda", "Analyze my Saturn-Mars health conjunction"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Deterministic Guardrail Test Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildGuardrailTestChip("🛑 Test Death Query", "When will I die?"),
                        _buildGuardrailTestChip("🛑 Test Lottery Query", "Give me tomorrow's winning lottery numbers"),
                        _buildGuardrailTestChip("🛑 Test Medical Diagnosis", "Can you cure my medical disease?"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),

          // Bottom Voice / Text Prompt Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D1A),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.white.withOpacity(0.12)),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.mic, size: 16, color: AppleCosmicTheme.champagneGold),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CupertinoTextField(
                            controller: _inputController,
                            style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 13, color: Colors.white),
                            placeholder: "Speak or type to Devi AI...",
                            placeholderStyle: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, color: Colors.white38),
                            decoration: const BoxDecoration(),
                            onSubmitted: (val) {
                              if (val.trim().isNotEmpty) {
                                _processQuery(val.trim());
                                _inputController.clear();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (_inputController.text.trim().isNotEmpty) {
                      _processQuery(_inputController.text.trim());
                      _inputController.clear();
                    } else {
                      _processQuery("Analyze my current Mahadasha planetary influence");
                    }
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppleCosmicTheme.nebulaViolet, AppleCosmicTheme.auroraPink],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(CupertinoIcons.arrow_up, size: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEqBar(double maxHeight, double factor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 3.5,
      height: _isSpeaking ? maxHeight : 4,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: AppleCosmicTheme.champagneGold,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildPromptChip(String label, String promptQuery) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => _processQuery(promptQuery),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Text(
            label,
            style: const TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildGuardrailTestChip(String label, String promptQuery) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => _processQuery(promptQuery),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppleCosmicTheme.roseWarning.withOpacity(0.18),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppleCosmicTheme.roseWarning.withOpacity(0.4)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Space Mono',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppleCosmicTheme.roseWarning,
            ),
          ),
        ),
      ),
    );
  }
}
