// lib/shared/screens/screen_voice_session.dart
// ASTROAI OS v5.0 - True 3D Voice Oracle Session with Hard 30-Minute Server-Side Metering

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/entitlements/server_voice_meter.dart';
import '../../core/localization/language_manager.dart';
import '../../core/localization/app_strings.dart';
import '../../android/theme/android_theme.dart';

enum VoiceOrbState {
  idle,
  listening,
  thinking,
  speaking,
  error,
  ending,
}

class ScreenVoiceSession extends StatefulWidget {
  const ScreenVoiceSession({super.key});

  @override
  State<ScreenVoiceSession> createState() => _ScreenVoiceSessionState();
}

class _ScreenVoiceSessionState extends State<ScreenVoiceSession>
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbController;
  final _voiceMeter = ServerVoiceMeter.instance;
  final _langMgr = LanguageManager.instance;

  VoiceOrbState _orbState = VoiceOrbState.listening;
  String _activeTranscript = "“Listening to your voice through the cosmic frequency...”";
  String _aiSpokenResponse = "";

  @override
  void initState() {
    super.initState();
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _initSession();
  }

  Future<void> _initSession() async {
    try {
      await _voiceMeter.startVoiceSession(
        userId: "usr_astro_master_88",
        currentRecordedUsedSeconds: 140, // 2:20 used
      );
    } catch (e) {
      setState(() {
        _orbState = VoiceOrbState.error;
        _activeTranscript = e.toString();
      });
    }

    // Simulate conversational spoken flow for demonstration
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _orbState = VoiceOrbState.thinking;
        _activeTranscript = "“Calculating Saturn's 10th house aspect on Dasamsa...”";
      });
    });

    Future.delayed(const Duration(seconds: 6), () {
      if (!mounted) return;
      final langId = _langMgr.currentLanguage.id;
      final bool isHindi = (langId == 'hi');

      setState(() {
        _orbState = VoiceOrbState.speaking;
        _aiSpokenResponse = isHindi
            ? "Bilkul. Aapke chart mein Saturn 10th house ko strongly activate kar raha hai. Career mein patience aur strategic leadership ka time chal raha hai..."
            : "Indeed. Your natal Saturn is actively illuminating the 10th house of career legacy, indicating focused long-term authority and karmic responsibility...";
        _activeTranscript = _aiSpokenResponse;
      });
    });
  }

  @override
  void dispose() {
    _orbController.dispose();
    _voiceMeter.endVoiceSession(userId: "usr_astro_master_88");
    super.dispose();
  }

  void _onToggleMic() {
    HapticFeedback.mediumImpact();
    setState(() {
      if (_orbState == VoiceOrbState.listening) {
        _orbState = VoiceOrbState.thinking;
        _activeTranscript = "“Devi is meditating on your inquiry...”";
      } else {
        _orbState = VoiceOrbState.listening;
        _activeTranscript = "“Speak freely with Devi in ${_langMgr.currentLanguage.displayName}...”";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final langId = _langMgr.currentLanguage.id;
    final session = _voiceMeter.currentSession;
    final warningState = _voiceMeter.warningState;

    final int remainingSec = session?.remainingSeconds ?? 1660;
    final int minutes = remainingSec ~/ 60;
    final int seconds = remainingSec % 60;
    final String remainingStr = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    Color timerColor = Colors.white70;
    if (warningState == VoiceWarningState.warning5Min) {
      timerColor = const Color(0xFFFBBF24); // Gold warning
    } else if (warningState == VoiceWarningState.critical1Min) {
      timerColor = Colors.redAccent; // Red critical
    }

    return Scaffold(
      backgroundColor: AndroidCosmicTheme.oledVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Top Bar with Hard Server-Side Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: timerColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: timerColor.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.timer_outlined, size: 14, color: timerColor),
                        const SizedBox(width: 6),
                        Text(
                          "$remainingStr REMAINING",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: timerColor,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _langMgr.currentLanguage.id.toUpperCase(),
                      style: const TextStyle(fontFamily: 'Space Mono', fontSize: 10, color: AndroidCosmicTheme.champagneGold, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              // Quota Warnings
              if (warningState == VoiceWarningState.warning5Min)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBBF24).withOpacity(0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppStrings.get('voice_cap_warning', langCode: langId),
                    style: const TextStyle(fontSize: 11, color: Color(0xFFFBBF24)),
                  ),
                ),

              if (warningState == VoiceWarningState.critical1Min)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppStrings.get('voice_cap_critical', langCode: langId),
                    style: const TextStyle(fontSize: 11, color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                ),

              const Spacer(),

              // -------------------------------------------------------------
              // 3D DYNAMIC VOLUMETRIC VOICE ORACLE (Impeller GPU Viewport)
              // -------------------------------------------------------------
              SizedBox(
                width: 250,
                height: 250,
                child: AnimatedBuilder(
                  animation: _orbController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _VoiceOrb3DPainter(
                        animationValue: _orbController.value,
                        state: _orbState,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Oracle State Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Image.asset('assets/images/daivant_logo.webp', width: 14, height: 14),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "DAIVANT ORACLE • ${_orbState.name.toUpperCase()}",
                      style: const TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 9,
                        letterSpacing: 1.5,
                        color: AndroidCosmicTheme.champagneGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Live Spoken Transcript Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Text(
                  _activeTranscript,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ),

              const Spacer(),

              // Bottom Interaction Dock
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _onToggleMic,
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            _orbState == VoiceOrbState.listening ? Colors.redAccent : AndroidCosmicTheme.nebulaViolet,
                            AndroidCosmicTheme.auroraPink,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.4),
                            blurRadius: 25,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        _orbState == VoiceOrbState.listening ? Icons.mic : Icons.mic_off,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _VoiceOrb3DPainter extends CustomPainter {
  final double animationValue;
  final VoiceOrbState state;

  _VoiceOrb3DPainter({required this.animationValue, required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const double baseRadius = 60.0;

    double expansion = 1.0;
    if (state == VoiceOrbState.speaking) {
      expansion = 1.0 + math.sin(animationValue * 4 * math.pi) * 0.14;
    } else if (state == VoiceOrbState.listening) {
      expansion = 1.0 + math.sin(animationValue * 2 * math.pi) * 0.06;
    }

    final double radius = baseRadius * expansion;

    // Glowing volumetric corona
    final haloPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF8B5CF6).withOpacity(0.55),
          const Color(0xFFF472B6).withOpacity(0.25),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.8));
    canvas.drawCircle(center, radius * 1.8, haloPaint);

    // Inner Iridescent Sphere
    final corePaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.25, -0.3),
        colors: [
          Color(0xFFFFF0D4),
          Color(0xFFE6C687),
          Color(0xFF8B5CF6),
          Color(0xFF130924),
        ],
        stops: [0.0, 0.35, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, corePaint);

    // Orbiting harmonic waveform rings
    final wavePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = Colors.white.withOpacity(0.4);

    for (int i = 0; i < 3; ++i) {
      final double ringRad = radius * (1.2 + i * 0.25);
      final double angle = animationValue * 2 * math.pi + (i * 0.8);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      canvas.scale(1.0, 0.35);
      canvas.drawCircle(Offset.zero, ringRad, wavePaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _VoiceOrb3DPainter oldDelegate) => true;
}
