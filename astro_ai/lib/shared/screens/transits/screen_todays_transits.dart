// lib/shared/screens/transits/screen_todays_transits.dart
// Screen: Today's Transits - Interactive 3D Sky Dial & Planetary Retrograde Telemetry
// Direct 1:1 Implementation matching Reference Screenshot (media_1792533988975_9ed79922.jpg)

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
  bool _isTodaySelected = false;
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              // Main Transits Card matching screenshot
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1D24),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Card Header with Section Title & Today/Tomorrow Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.chevron_left,
                              size: 18,
                              color: Colors.white.withOpacity(0.6),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Today's Transits",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // Pill Toggle [ Today • Tomorrow ]
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF141318),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  setState(() => _isTodaySelected = true);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: _isTodaySelected ? const Color(0xFFE07A5F) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    "Today",
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _isTodaySelected ? Colors.white : Colors.white60,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  setState(() => _isTodaySelected = false);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: !_isTodaySelected ? const Color(0xFFE07A5F) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    "Tomorrow",
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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

                    const SizedBox(height: 18),

                    // Interactive 3D Movable Planetary Transit Dial Widget
                    PlanetaryTransitDialWidget(
                      size: 260,
                      onPlanetSelected: _onPlanetSelected,
                    ),

                    const SizedBox(height: 24),

                    // Bottom Action Row matching screenshot:
                    // [ Ask Om.AI about this ] & [ Share Icon ]
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE07A5F),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _askOmAi,
                            icon: const Icon(Icons.chat_bubble_outline, size: 18),
                            label: const Text(
                              "Ask Om.AI about this",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: _shareTransitSnapshot,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFF26252C),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.08)),
                            ),
                            child: const Icon(
                              Icons.share_outlined,
                              size: 20,
                              color: Colors.white70,
                            ),
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
