// lib/shared/screens/splash/screen_animated_splash.dart
// ASTROAI OS v4.2 - Cinematic Animated Opening Splash Screen
// Features: Sacred Vedic Astrolabe custom canvas, starfield particle engine,
// Daivant golden gradient emblem animation, dynamic ephemeris calibration stream,
// and platform-adaptive smooth transition into Screen 01 Welcome.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astro_ai/android/screens/screen01_welcome_android.dart';
import 'package:astro_ai/apple/screens/screen01_welcome_apple.dart';

class ScreenAnimatedSplash extends StatefulWidget {
  final bool isApple;
  final Widget? nextScreen;

  const ScreenAnimatedSplash({
    super.key,
    this.isApple = false,
    this.nextScreen,
  });

  @override
  State<ScreenAnimatedSplash> createState() => _ScreenAnimatedSplashState();
}

class _ScreenAnimatedSplashState extends State<ScreenAnimatedSplash>
    with TickerProviderStateMixin {
  late AnimationController _astrolabeController;
  late AnimationController _fadeScaleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _letterSpacingAnimation;

  int _calibrationStep = 0;
  final List<String> _calibrationMessages = [
    "Aligning Swiss Ephemeris 2026...",
    "Computing 16 Shodashvarga Vargas...",
    "Calibrating KP Cuspal Matrices...",
    "Illuminating Devi AI Oracle...",
    "Cosmic Alignment Complete • Welcome",
  ];

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // 1. Continuous Astrolabe & Starfield Rotation (30s infinite loop)
    _astrolabeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    // 2. Entrance & Calibration Orchestration (2.8 seconds total duration)
    _fadeScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeScaleController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeScaleController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeIn),
      ),
    );

    _letterSpacingAnimation = Tween<double>(begin: 3.0, end: 7.0).animate(
      CurvedAnimation(
        parent: _fadeScaleController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _fadeScaleController.addListener(() {
      final double progress = _fadeScaleController.value;
      final int step = (progress * (_calibrationMessages.length - 1)).clamp(0, _calibrationMessages.length - 1).toInt();
      if (step != _calibrationStep && mounted) {
        setState(() {
          _calibrationStep = step;
        });
      }
    });

    _fadeScaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNext();
      }
    });

    _fadeScaleController.forward();

    // Subtle welcoming haptic tick
    HapticFeedback.lightImpact();
  }

  @override
  void dispose() {
    _astrolabeController.dispose();
    _fadeScaleController.dispose();
    super.dispose();
  }

  void _navigateToNext() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    HapticFeedback.mediumImpact();

    final Widget destination = widget.nextScreen ??
        (widget.isApple
            ? const Screen01WelcomeApple()
            : const Screen01WelcomeAndroid());

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650),
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return FadeTransition(
            opacity: curved,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color oledBg = Color(0xFF05050A);
    const Color champagneGold = Color(0xFFE6C687);
    const Color nebulaViolet = Color(0xFF8B5CF6);

    return Scaffold(
      backgroundColor: oledBg,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _navigateToNext, // Tap anywhere to fast-forward into app
        child: Stack(
          children: [
            // 1. Dynamic Sacred Astrolabe & Starfield Background Canvas
            AnimatedBuilder(
              animation: _astrolabeController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: CosmicSplashPainter(
                    rotation: _astrolabeController.value * 2 * math.pi,
                  ),
                );
              },
            ),

            // 2. Central Vignette & Radial Nebula Glow
            Center(
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      champagneGold.withOpacity(0.12),
                      nebulaViolet.withOpacity(0.08),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),

            // 3. Central Brand Composition (Medallion + Typography + Status)
            Center(
              child: AnimatedBuilder(
                animation: _fadeScaleController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Sacred Glowing Medallion Emblem
                          Container(
                            width: 104,
                            height: 104,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: champagneGold.withOpacity(0.35),
                                  blurRadius: 32,
                                  spreadRadius: 6,
                                ),
                                BoxShadow(
                                  color: nebulaViolet.withOpacity(0.25),
                                  blurRadius: 48,
                                  spreadRadius: 10,
                                ),
                              ],
                              border: Border.all(
                                color: champagneGold,
                                width: 2.0,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/icons/daivant_app_icon.webp',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  'assets/icons/daivant_app_icon.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    color: const Color(0xFF131A29),
                                    child: const Icon(
                                      Icons.auto_awesome,
                                      color: champagneGold,
                                      size: 48,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // DAIVANT Golden Shimmer Brand Title
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFFFFF7DB),
                                  Color(0xFFE6C687),
                                  Color(0xFFD4AF37),
                                  Color(0xFFFFF7DB),
                                ],
                                stops: [0.0, 0.4, 0.7, 1.0],
                              ).createShader(bounds);
                            },
                            child: Text(
                              "DAIVANT",
                              style: TextStyle(
                                fontFamily: 'Cormorant Garamond',
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                letterSpacing: _letterSpacingAnimation.value,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Secondary Monospace Category
                          const Text(
                            "AI ASTROLOGY • VEDIC QUANTUM",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 4.0,
                              color: Color(0xFFCBD5E1),
                            ),
                          ),

                          const SizedBox(height: 6),

                          // Sacred Vedic Sanskrit Tagline
                          Text(
                            "॥ तमसो मा ज्योतिर्गमय ॥",
                            style: TextStyle(
                              fontSize: 12,
                              color: champagneGold.withOpacity(0.75),
                              letterSpacing: 2.0,
                            ),
                          ),

                          const SizedBox(height: 38),

                          // Dynamic Ephemeris Calibration Status
                          SizedBox(
                            height: 22,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                _calibrationMessages[_calibrationStep],
                                key: ValueKey<int>(_calibrationStep),
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 11,
                                  color: champagneGold.withOpacity(0.9),
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Slim Glowing Calibration Beam
                          SizedBox(
                            width: 140,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: _fadeScaleController.value,
                                minHeight: 2.0,
                                backgroundColor: const Color(0x22E6C687),
                                valueColor: const AlwaysStoppedAnimation<Color>(champagneGold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 4. Subtle "Tap to Skip" Hint at Bottom
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "TAP TO START",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 9,
                    letterSpacing: 2.0,
                    color: Colors.white.withOpacity(0.25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom Canvas Painter rendering multi-layered Vedic Astrolabe & Constellation Stars
class CosmicSplashPainter extends CustomPainter {
  final double rotation;

  CosmicSplashPainter({required this.rotation});

  static final List<math.Point<double>> _stars = List.generate(48, (index) {
    final random = math.Random(index * 7919);
    return math.Point(random.nextDouble(), random.nextDouble());
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) * 0.44;

    // 1. Starfield Particles
    final starPaint = Paint()..color = Colors.white;
    for (int i = 0; i < _stars.length; i++) {
      final point = _stars[i];
      final double starX = point.x * size.width;
      final double starY = point.y * size.height;
      final double starOpacity = 0.2 + 0.6 * math.sin(rotation * 2 + i);
      starPaint.color = Colors.white.withOpacity(starOpacity.clamp(0.1, 0.85));
      final double starSize = (i % 3 == 0) ? 1.8 : 1.0;
      canvas.drawCircle(Offset(starX, starY), starSize, starPaint);
    }

    // 2. Outer Rotating Zodiac Ring
    final outerRingPaint = Paint()
      ..color = const Color(0xFFE6C687).withOpacity(0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawCircle(center, radius, outerRingPaint);

    // Cardinal Zodiac Tick Marks
    for (int i = 0; i < 36; i++) {
      final double angle = rotation + (i * 2 * math.pi / 36);
      final double innerR = (i % 3 == 0) ? radius - 10 : radius - 5;
      final p1 = Offset(center.dx + radius * math.cos(angle), center.dy + radius * math.sin(angle));
      final p2 = Offset(center.dx + innerR * math.cos(angle), center.dy + innerR * math.sin(angle));
      canvas.drawLine(p1, p2, outerRingPaint);
    }

    // 3. Middle Counter-Rotating Navagraha Ring
    final middleRingPaint = Paint()
      ..color = const Color(0xFF8B5CF6).withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final double middleR = radius * 0.76;
    canvas.drawCircle(center, middleR, middleRingPaint);

    for (int i = 0; i < 12; i++) {
      final double angle = -rotation * 0.7 + (i * 2 * math.pi / 12);
      final p1 = Offset(center.dx + middleR * math.cos(angle), center.dy + middleR * math.sin(angle));
      final p2 = Offset(center.dx + (middleR - 6) * math.cos(angle), center.dy + (middleR - 6) * math.sin(angle));
      canvas.drawLine(p1, p2, middleRingPaint);
    }

    // 4. Sacred Geometry Diamond Lattice (Kundali / Sri Yantra Matrix)
    final diamondPaint = Paint()
      ..color = const Color(0xFFE6C687).withOpacity(0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final double diamondSize = radius * 0.55;
    final path = Path()
      ..moveTo(center.dx, center.dy - diamondSize)
      ..lineTo(center.dx + diamondSize, center.dy)
      ..lineTo(center.dx, center.dy + diamondSize)
      ..lineTo(center.dx - diamondSize, center.dy)
      ..close();

    // Rotate diamond slightly with time
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * 0.25);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawPath(path, diamondPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CosmicSplashPainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}
