// lib/shared/screens/screen_language_selection.dart
// ASTROAI OS v5.0 - True 3D Spatial Language Selection Screen

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/localization/language_option.dart';
import '../../core/localization/language_registry.dart';
import '../../core/localization/language_manager.dart';
import '../../core/localization/app_strings.dart';
import '../../android/theme/android_theme.dart';

class ScreenLanguageSelection extends StatefulWidget {
  final VoidCallback onContinue;

  const ScreenLanguageSelection({super.key, required this.onContinue});

  @override
  State<ScreenLanguageSelection> createState() => _ScreenLanguageSelectionState();
}

class _ScreenLanguageSelectionState extends State<ScreenLanguageSelection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sphereController;
  late LanguageOption _selectedLanguage;

  double _dragAngle = 0.0;
  double _lastDragX = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = LanguageManager.instance.currentLanguage;

    _sphereController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _sphereController.dispose();
    super.dispose();
  }

  void _onSelectLanguage(LanguageOption lang) {
    HapticFeedback.lightImpact();
    setState(() {
      _selectedLanguage = lang;
    });
    LanguageManager.instance.setLanguage(lang);
  }

  @override
  Widget build(BuildContext context) {
    final langId = _selectedLanguage.id;

    return Scaffold(
      backgroundColor: AndroidCosmicTheme.oledVoid,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Top Telemetry Header
            Text(
              "ASTROAI OS • MULTI-LINGUAL VOICE AI",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 9,
                letterSpacing: 1.5,
                color: AndroidCosmicTheme.champagneGold.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Header Title & Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset('assets/images/daivant_logo.webp', width: 44, height: 44),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.get('lang_title', langCode: langId),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppStrings.get('lang_subtitle', langCode: langId),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.65),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // -------------------------------------------------------------
            // 3D INTERACTIVE COSMIC LANGUAGE SPHERE
            // -------------------------------------------------------------
            GestureDetector(
              onHorizontalDragStart: (details) => _lastDragX = details.localPosition.dx,
              onHorizontalDragUpdate: (details) {
                final dx = details.localPosition.dx - _lastDragX;
                _lastDragX = details.localPosition.dx;
                setState(() {
                  _dragAngle += dx * 0.015;
                });
              },
              child: SizedBox(
                height: 170,
                width: 280,
                child: AnimatedBuilder(
                  animation: _sphereController,
                  builder: (context, child) {
                    final double totalAngle = _sphereController.value * 2 * math.pi + _dragAngle;
                    return CustomPaint(
                      painter: _LanguageSpherePainter(
                        rotationAngle: totalAngle,
                        selectedNativeName: _selectedLanguage.nativeName,
                        sampleGreeting: _selectedLanguage.sampleGreeting,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "DRAG TO ROTATE 3D COSMIC LINGUAL CORE",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 8,
                letterSpacing: 1.2,
                color: Colors.white.withOpacity(0.4),
              ),
            ),

            const SizedBox(height: 12),

            // Language Options List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                physics: const BouncingScrollPhysics(),
                itemCount: LanguageRegistry.supportedLanguages.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final lang = LanguageRegistry.supportedLanguages[index];
                  final bool isSelected = (lang.id == _selectedLanguage.id);

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _onSelectLanguage(lang),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AndroidCosmicTheme.nebulaViolet.withOpacity(0.25)
                            : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AndroidCosmicTheme.champagneGold
                              : Colors.white.withOpacity(0.08),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? AndroidCosmicTheme.champagneGold
                                  : Colors.white10,
                            ),
                            child: Center(
                              child: Text(
                                lang.id.toUpperCase().split('-').first,
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      lang.displayName,
                                      style: const TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      lang.nativeName,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12,
                                        color: isSelected
                                            ? AndroidCosmicTheme.champagneGold
                                            : Colors.white60,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    if (lang.supportsIndianVoice)
                                      _buildBadge("Soft Indic Voice", const Color(0xFFFBBF24)),
                                    if (lang.supportsRealtime)
                                      _buildBadge("Realtime AI", const Color(0xFF34D399)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: AndroidCosmicTheme.champagneGold,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AndroidCosmicTheme.champagneGold,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    elevation: 6,
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    widget.onContinue();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${AppStrings.get('btn_continue', langCode: langId)} (${_selectedLanguage.displayName})",
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 6, top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _LanguageSpherePainter extends CustomPainter {
  final double rotationAngle;
  final String selectedNativeName;
  final String sampleGreeting;

  _LanguageSpherePainter({
    required this.rotationAngle,
    required this.selectedNativeName,
    required this.sampleGreeting,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const double radius = 55.0;

    // Glowing atmospheric halo
    final haloPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF8B5CF6).withOpacity(0.4),
          const Color(0xFFE6C687).withOpacity(0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.6));
    canvas.drawCircle(center, radius * 1.6, haloPaint);

    // Central Sphere Body
    final spherePaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.3, -0.3),
        colors: [
          Color(0xFFE6C687),
          Color(0xFF8B5CF6),
          Color(0xFF1E1035),
        ],
        stops: [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, spherePaint);

    // Orbiting 3D rings with dynamic depth
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.white.withOpacity(0.3);

    for (int r = 0; r < 3; ++r) {
      final double ringRadius = radius * (1.25 + r * 0.22);
      final double tilt = (r * 0.5) + rotationAngle * 0.4;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(tilt);
      canvas.scale(1.0, 0.38);
      canvas.drawCircle(Offset.zero, ringRadius, ringPaint);
      canvas.restore();
    }

    // Display selected native name at sphere center
    final textPainter = TextPainter(
      text: TextSpan(
        text: selectedNativeName.length > 8 ? selectedNativeName.substring(0, 8) : selectedNativeName,
        style: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant _LanguageSpherePainter oldDelegate) => true;
}
