// lib/shared/screens/tarot/screen_tarot_soul_guide.dart
// ASTROAI OS v5.0 - Interactive 3D Tarot Soul Guide with Press-and-Hold Reveal

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TarotCardData {
  final String number;
  final String name;
  final String archetype;
  final String uprightMeaning;
  final String guidance;
  final String elementalAssociation;

  const TarotCardData({
    required this.number,
    required this.name,
    required this.archetype,
    required this.uprightMeaning,
    required this.guidance,
    required this.elementalAssociation,
  });
}

class ScreenTarotSoulGuide extends StatefulWidget {
  const ScreenTarotSoulGuide({super.key});

  @override
  State<ScreenTarotSoulGuide> createState() => _ScreenTarotSoulGuideState();
}

class _ScreenTarotSoulGuideState extends State<ScreenTarotSoulGuide>
    with TickerProviderStateMixin {
  late AnimationController _pressHoldController;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  bool _isFlipped = false;
  int _cardIndex = 0;

  final List<TarotCardData> _deck = const [
    TarotCardData(
      number: "II",
      name: "The High Priestess",
      archetype: "Keeper of the Cosmic Veil",
      uprightMeaning: "Intuition, Sacred Knowledge, Divine Feminine, Subconscious",
      guidance:
          "Trust the quiet whispers of your instinct rather than loud external noise. A hidden truth in your current transit is preparing to surface. Practice patient contemplation.",
      elementalAssociation: "Water (Chandra / Moon)",
    ),
    TarotCardData(
      number: "XVII",
      name: "The Star",
      archetype: "Beacon of Renewal",
      uprightMeaning: "Hope, Faith, Purpose, Cosmic Blessing, Rejuvenation",
      guidance:
          "The turbulent transit has passed. Your spiritual reservoir is replenishing. Continue channeling your creative purpose with calm optimism.",
      elementalAssociation: "Air (Aquarius / Rahu)",
    ),
    TarotCardData(
      number: "I",
      name: "The Magician",
      archetype: "Master of Manifestation",
      uprightMeaning: "Willpower, Resourcefulness, Creation, Alchemical Power",
      guidance:
          "You have every instrument required to materialize your vision. Align your speech, thought, and action into a singular spear of execution.",
      elementalAssociation: "Air (Mercury / Budha)",
    ),
    TarotCardData(
      number: "X",
      name: "The Wheel of Fortune",
      archetype: "Karmic Cycles & Destiny",
      uprightMeaning: "Change, Cycles, Inevitable Turning, Cosmic Alignment",
      guidance:
          "A major karmic cycle is pivoting in your favor. Accept the natural ebb and flow of circumstances while holding your inner core immovable.",
      elementalAssociation: "Fire (Jupiter / Guru)",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pressHoldController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: math.pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutCubic),
    );

    _pressHoldController.addListener(() {
      if (_pressHoldController.value > 0.0 && _pressHoldController.value < 1.0) {
        if ((_pressHoldController.value * 10).toInt() % 2 == 0) {
          HapticFeedback.selectionClick();
        }
      }
    });

    _pressHoldController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_isFlipped) {
        HapticFeedback.heavyImpact();
        _flipController.forward().then((_) {
          setState(() => _isFlipped = true);
        });
      }
    });
  }

  @override
  void dispose() {
    _pressHoldController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  void _onPressStart(TapDownDetails details) {
    if (_isFlipped) return;
    _pressHoldController.forward();
  }

  void _onPressEnd(TapUpDetails details) {
    if (_isFlipped) return;
    if (_pressHoldController.status != AnimationStatus.completed) {
      _pressHoldController.reverse();
    }
  }

  void _onPressCancel() {
    if (_isFlipped) return;
    if (_pressHoldController.status != AnimationStatus.completed) {
      _pressHoldController.reverse();
    }
  }

  void _resetCard() {
    HapticFeedback.mediumImpact();
    _flipController.reverse().then((_) {
      setState(() {
        _isFlipped = false;
        _cardIndex = (_cardIndex + 1) % _deck.length;
        _pressHoldController.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeCard = _deck[_cardIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF05030A),
      body: Stack(
        children: [
          // Deep Mystical Violet Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.2),
                  radius: 1.3,
                  colors: [
                    Color(0xFF260D45),
                    Color(0xFF130626),
                    Color(0xFF05030A),
                  ],
                ),
              ),
            ),
          ),

          // Top Header Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0AAFF).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE0AAFF).withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("✦ ", style: TextStyle(color: Color(0xFFE0AAFF), fontSize: 12)),
                        Text(
                          "ORACLE DECK",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 10,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE0AAFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _resetCard,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Icon(Icons.refresh, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Center Content
          Positioned.fill(
            top: 70,
            bottom: 20,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Awaken the Tarot\nof Destiny",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Tarot Soul Guide Card Frame
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF140D26).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: const Color(0xFF9D4EDD).withOpacity(0.35)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9D4EDD).withOpacity(0.25),
                          blurRadius: 30,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Tarot Soul Guide",
                          style: TextStyle(
                            fontFamily: 'Cormorant Garamond',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFD700),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isFlipped
                              ? "Your celestial card for today is unveiled."
                              : "Focus on what matters most and keep the card pressed until it turns.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.65),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Interactive 3D Flippable Tarot Card
                        GestureDetector(
                          onTapDown: _onPressStart,
                          onTapUp: _onPressEnd,
                          onTapCancel: _onPressCancel,
                          child: AnimatedBuilder(
                            animation: _flipAnimation,
                            builder: (context, child) {
                              final angle = _flipAnimation.value;
                              final isUnder = angle > (math.pi / 2);

                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.0015)
                                  ..rotateY(angle),
                                alignment: Alignment.center,
                                child: isUnder
                                    ? Transform(
                                        transform: Matrix4.identity()..rotateY(math.pi),
                                        alignment: Alignment.center,
                                        child: _buildCardFront(activeCard),
                                      )
                                    : _buildCardBack(),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Press-and-Hold Progress Bar (Visible when not flipped)
                        if (!_isFlipped)
                          AnimatedBuilder(
                            animation: _pressHoldController,
                            builder: (context, child) {
                              return Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: _pressHoldController.value,
                                      backgroundColor: Colors.white12,
                                      valueColor: const AlwaysStoppedAnimation<Color>(
                                        Color(0xFFE0AAFF),
                                      ),
                                      minHeight: 4,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _pressHoldController.value > 0.0
                                        ? "HOLD STEADY TO CHANNEL ENERGY..."
                                        : "PRESS AND HOLD CARD",
                                    style: const TextStyle(
                                      fontFamily: 'Space Mono',
                                      fontSize: 9.5,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE0AAFF),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        else
                          // Card Interpretation Details
                          _buildCardDossier(activeCard),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      width: 210,
      height: 330,
      decoration: BoxDecoration(
        color: const Color(0xFF1B0F33),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF9D4EDD), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B2CBF).withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background celestial star pattern
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
                gradient: const RadialGradient(
                  colors: [Color(0xFF3C1361), Color(0xFF140826)],
                ),
              ),
            ),
          ),

          // Central Triple Moon Symbol & Mystical Goddess Motif
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("☾", style: TextStyle(fontSize: 28, color: const Color(0xFFFFD700).withOpacity(0.9))),
                  const SizedBox(width: 6),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
                      gradient: const RadialGradient(
                        colors: [Color(0xFFFFD700), Color(0xFF9D4EDD)],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text("☽", style: TextStyle(fontSize: 28, color: const Color(0xFFFFD700).withOpacity(0.9))),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "DAIVANT AI",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "TAROT OF DESTINY",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 8,
                  letterSpacing: 1.2,
                  color: const Color(0xFFE0AAFF).withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardFront(TarotCardData card) {
    return Container(
      width: 210,
      height: 330,
      decoration: BoxDecoration(
        color: const Color(0xFF1A102E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFD700), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.35),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE0AAFF).withOpacity(0.4)),
                gradient: const RadialGradient(
                  colors: [Color(0xFF381559), Color(0xFF0F071D)],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.number,
                  style: const TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD700),
                  ),
                ),
                // Triple Moon Goddess Emblem
                Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF9D4EDD), Color(0xFF00E5FF)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withOpacity(0.3),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text("✦", style: TextStyle(color: Colors.white, fontSize: 32)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      card.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      card.archetype,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 8.5,
                        color: const Color(0xFFFFD700).withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
                Text(
                  card.elementalAssociation,
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 8.5,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDossier(TarotCardData card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.auto_awesome, size: 14, color: Color(0xFFFFD700)),
                  SizedBox(width: 8),
                  Text(
                    "UPRIGHT ESSENCE",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                card.uprightMeaning,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "ORACLE GUIDANCE",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 9.5,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00E5FF),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                card.guidance,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  height: 1.45,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _resetCard,
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF9D4EDD), Color(0xFF7B2CBF)],
              ),
            ),
            child: const Center(
              child: Text(
                "DRAW ANOTHER CARD",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 11,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
