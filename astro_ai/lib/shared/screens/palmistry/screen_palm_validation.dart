// lib/shared/screens/palmistry/screen_palm_validation.dart
// ASTROAI OS v5.0 - Bilateral Image Quality Validation & Calibration Screen

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/palmistry/services/palmistry_service.dart';
import 'screen_palm_scanning.dart';
import 'screen_palm_capture.dart';

class ScreenPalmValidation extends StatefulWidget {
  final String readingId;

  const ScreenPalmValidation({super.key, required this.readingId});

  @override
  State<ScreenPalmValidation> createState() => _ScreenPalmValidationState();
}

class _ScreenPalmValidationState extends State<ScreenPalmValidation> {

  @override
  void initState() {
    super.initState();
    _validateImages();
  }

  Future<void> _validateImages() async {
    await PalmistryService.instance.validateReadingImages(widget.readingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05050A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00FF66).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 12, color: Color(0xFF00FF66)),
                        SizedBox(width: 6),
                        Text(
                          "CALIBRATION READY",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 10,
                            letterSpacing: 1.1,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00FF66),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                "Image Quality Calibration",
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Optical verification of epidermal clarity and line visibility.",
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),

              const SizedBox(height: 24),

              // Dual Palm Thumbnail Cards
              Row(
                children: [
                  Expanded(
                    child: _buildPalmQualityCard(
                      title: "LEFT PALM",
                      subtitle: "Innate Potential",
                      score: 94,
                      isLeft: true,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildPalmQualityCard(
                      title: "RIGHT PALM",
                      subtitle: "Manifested Reality",
                      score: 96,
                      isLeft: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Checklist Metrics
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  children: [
                    _buildMetricRow("Dermal Ridge Contrast", "OPTIMAL (94%)", const Color(0xFF00FF66)),
                    const Divider(color: Colors.white10, height: 20),
                    _buildMetricRow("Lighting & Exposure", "BALANCED", const Color(0xFF00FF66)),
                    const Divider(color: Colors.white10, height: 20),
                    _buildMetricRow("5-Finger Geometrical Bounds", "DETECTED", const Color(0xFF00E5FF)),
                    const Divider(color: Colors.white10, height: 20),
                    _buildMetricRow("Wrist & Mount Separation", "VERIFIED", const Color(0xFFFFD700)),
                  ],
                ),
              ),

              const Spacer(),

              // Proceed CTA Button
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ScreenPalmScanning(readingId: widget.readingId),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9D4EDD), Color(0xFF00E5FF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E5FF).withOpacity(0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("✦ ", style: TextStyle(color: Colors.white, fontSize: 16)),
                        Text(
                          "START 3D PALM SCANNING",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 12,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ScreenPalmCapture(readingId: widget.readingId),
                      ),
                    );
                  },
                  child: Text(
                    "Retake Photos",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.5),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPalmQualityCard({
    required String title,
    required String subtitle,
    required int score,
    required bool isLeft,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF110E24),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  color: Color(0xFF00E5FF),
                ),
              ),
              Text(
                "$score%",
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FF66),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 11,
              color: Colors.white.withOpacity(0.55),
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score / 100.0,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00FF66)),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color badgeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: badgeColor,
          ),
        ),
      ],
    );
  }
}
