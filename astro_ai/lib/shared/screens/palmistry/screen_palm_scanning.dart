// lib/shared/screens/palmistry/screen_palm_scanning.dart
// ASTROAI OS v5.0 - Cinematic 10-Stage Bilateral 3D Palm Scanner Experience

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/palmistry/models/palm_reading_model.dart';
import '../../../core/palmistry/services/palmistry_service.dart';
import '../../engine/3d/palm_scanner_3d_view.dart';
import 'screen_palm_report.dart';

class ScreenPalmScanning extends StatefulWidget {
  final String readingId;

  const ScreenPalmScanning({super.key, required this.readingId});

  @override
  State<ScreenPalmScanning> createState() => _ScreenPalmScanningState();
}

class _ScreenPalmScanningState extends State<ScreenPalmScanning> {
  late StreamSubscription<PalmReading> _sub;
  PalmReading? _currentReading;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _currentReading = PalmistryService.instance.getReading(widget.readingId);
    _sub = PalmistryService.instance.onReadingUpdate.listen((updated) {
      if (updated.id == widget.readingId && mounted) {
        setState(() {
          _currentReading = updated;
          if (updated.status == PalmReadingStatus.completed) {
            _isFinished = true;
          }
        });
      }
    });

    _startPipeline();
  }

  Future<void> _startPipeline() async {
    await PalmistryService.instance.startAnalysisPipeline(
      readingId: widget.readingId,
      languageLocale: 'en',
    );
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stageIndex = _currentReading?.currentStageIndex ?? 1;
    final stageMsg = _currentReading?.currentStageMessage ?? 'Calibrating cosmic sensors...';
    final progress = (stageIndex / 10.0).clamp(0.0, 1.0);
    final report = _currentReading?.report;

    return Scaffold(
      backgroundColor: const Color(0xFF05050A),
      body: Stack(
        children: [
          // Background Deep Galactic Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.2),
                  radius: 1.2,
                  colors: [
                    Color(0xFF220F3E),
                    Color(0xFF090615),
                    Color(0xFF05050A),
                  ],
                ),
              ),
            ),
          ),

          // Central 3D Scanning Palm View
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: 20,
            right: 20,
            height: MediaQuery.of(context).size.height * 0.48,
            child: PalmScanner3DView(
              isLeft: stageIndex % 2 != 0, // alternates left and right during scan
              isScanning: !_isFinished,
              scanningStage: stageIndex,
              sideAnalysis: report?.leftPalm,
              showMounts: stageIndex >= 7,
              showGrid: true,
              enableGestures: false,
            ),
          ),

          // Top Header Telemetry HUD
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.12)),
                    ),
                    child: Text(
                      _isFinished ? "ANALYSIS COMPLETE" : "STAGE ${stageIndex.toString().padLeft(2, '0')} / 10",
                      style: const TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 10,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00E5FF),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.blur_on, size: 12, color: Color(0xFFFFD700)),
                        const SizedBox(width: 6),
                        Text(
                          "${(progress * 100).toInt()}%",
                          style: const TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFD700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Stage Message & Reveal Card
          Positioned(
            left: 20,
            right: 20,
            bottom: 34,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Progress Track
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white10,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00E5FF)),
                    minHeight: 3,
                  ),
                ),
                const SizedBox(height: 20),

                if (!_isFinished) ...[
                  Text(
                    stageMsg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Calibrating dermal vectors and comparing innate vs manifested lines...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.55),
                    ),
                  ),
                ] else ...[
                  // Emotional Payoff Reveal State
                  const Text(
                    "Your Palm Map is Ready",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "An AI-assisted interpretation of the sacred patterns written in your hands.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      height: 1.4,
                      color: Colors.white.withOpacity(0.65),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ScreenPalmReport(readingId: widget.readingId),
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
                            color: const Color(0xFF00E5FF).withOpacity(0.35),
                            blurRadius: 20,
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
                              "EXPLORE MY PALM MAP",
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 13,
                                letterSpacing: 1.4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
