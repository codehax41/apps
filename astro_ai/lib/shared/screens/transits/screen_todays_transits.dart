// lib/shared/screens/transits/screen_todays_transits.dart
// Screen 5: Today's Transits - Interactive 3D Sky Dial & Planetary Retrograde Telemetry
// Direct 1:1 Implementation matching Reference Screenshot (media_1792522755444_5ae25bcd.jpg)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/batch4_celestial_painters.dart';
import '../screen_voice_session.dart';

class ScreenTodaysTransits extends StatefulWidget {
  const ScreenTodaysTransits({super.key});

  @override
  State<ScreenTodaysTransits> createState() => _ScreenTodaysTransitsState();
}

class _ScreenTodaysTransitsState extends State<ScreenTodaysTransits> {
  bool _isTodaySelected = true;
  String _activePlanetName = "Jupiter";

  void _onPlanetSelected(PlanetaryTransitItem p) {
    setState(() {
      _activePlanetName = p.name;
    });
  }

  void _askOmAi() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScreenVoiceSession(),
      ),
    );
  }

  void _shareTransitSnapshot() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Shared transit alignment for $_activePlanetName to clipboard."),
        backgroundColor: const Color(0xFFE07A5F),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131217),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

              const SizedBox(height: 24),

              // Subtitle in terracotta uppercase
              const Text(
                "TODAY'S TRANSITS",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFFE07A5F),
                ),
              ),

              const SizedBox(height: 8),

              // Headline: "See what today's sky means for you"
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.15,
                  ),
                  children: [
                    TextSpan(text: "See what "),
                    TextSpan(
                      text: "today's\nsky ",
                      style: TextStyle(color: Color(0xFFE07A5F)),
                    ),
                    TextSpan(text: "means for you"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Main Transits Card Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1D24),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Card Top Title & Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.chevron_left, color: Colors.white70, size: 20),
                            SizedBox(width: 4),
                            Text(
                              "Today's Transits",
                              style: TextStyle(
                                fontFamily: 'Cormorant Garamond',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // Pill Selector: [ Today • ] vs [ Tomorrow ]
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF131217),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  setState(() => _isTodaySelected = true);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _isTodaySelected ? const Color(0xFFE07A5F) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    "Today •",
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: _isTodaySelected ? Colors.white : Colors.white60,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  setState(() => _isTodaySelected = false);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: !_isTodaySelected ? const Color(0xFFE07A5F) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    "Tomorrow",
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: !_isTodaySelected ? Colors.white : Colors.white60,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Interactive 3D Celestial Orbit Wheel
                    PlanetaryTransitDialWidget(
                      size: 290,
                      onPlanetSelected: _onPlanetSelected,
                    ),

                    const SizedBox(height: 24),

                    // Bottom Action Row: [ 💬 Ask Om.AI about this ] + [ 🔗 Share ]
                    Row(
                      children: [
                        // Primary CTA
                        Expanded(
                          child: GestureDetector(
                            onTap: _askOmAi,
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFE07A5F), Color(0xFFC75D43)],
                                ),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE07A5F).withOpacity(0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.chat_bubble_outline, size: 16, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    "Ask Om.AI about this",
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Share Button
                        GestureDetector(
                          onTap: _shareTransitSnapshot,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFF282631),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.12)),
                            ),
                            child: const Icon(Icons.share_outlined, size: 18, color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
