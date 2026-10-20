// lib/shared/screens/palmistry/screen_palm_capture.dart
// ASTROAI OS v5.0 - Holographic Left & Right Palm Image Capture Portal

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/palmistry/services/palmistry_service.dart';
import '../../engine/3d/palm_scanner_3d_view.dart';
import 'screen_palm_validation.dart';

class ScreenPalmCapture extends StatefulWidget {
  final String? readingId;

  const ScreenPalmCapture({super.key, this.readingId});

  @override
  State<ScreenPalmCapture> createState() => _ScreenPalmCaptureState();
}

class _ScreenPalmCaptureState extends State<ScreenPalmCapture> {
  bool _capturingLeft = true;
  String _activeReadingId = '';

  @override
  void initState() {
    super.initState();
    _initReadingSession();
  }

  Future<void> _initReadingSession() async {
    if (widget.readingId != null) {
      _activeReadingId = widget.readingId!;
    } else {
      final reading = await PalmistryService.instance.createReading(
        userId: 'usr_astro_master_88',
      );
      _activeReadingId = reading.id;
    }
  }

  Future<void> _onCaptureOrPick({required bool fromCamera}) async {
    HapticFeedback.mediumImpact();
    // Simulate high-fidelity photo capture
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = fromCamera ? 'camera_palm_$timestamp.jpg' : 'gallery_palm_$timestamp.jpg';

    if (_capturingLeft) {
      await PalmistryService.instance.uploadLeftImage(
        readingId: _activeReadingId,
        imagePath: path,
      );
      setState(() {
        _capturingLeft = false; // Move to right hand
      });
    } else {
      await PalmistryService.instance.uploadRightImage(
        readingId: _activeReadingId,
        imagePath: path,
      );

      if (!mounted) return;
      HapticFeedback.heavyImpact();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenPalmValidation(readingId: _activeReadingId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05050A),
      body: Stack(
        children: [
          // Deep Indigo Background Atmosphere
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.3),
                  radius: 1.2,
                  colors: [
                    Color(0xFF1E103E),
                    Color(0xFF090615),
                    Color(0xFF05050A),
                  ],
                ),
              ),
            ),
          ),

          // Top App Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!_capturingLeft) {
                        setState(() => _capturingLeft = true);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
                    ),
                    child: Text(
                      _capturingLeft ? "STEP 1 OF 2 • LEFT PALM" : "STEP 2 OF 2 • RIGHT PALM",
                      style: const TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 10,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00E5FF),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Balance
                ],
              ),
            ),
          ),

          // Central Holographic Guide Overlay
          Positioned(
            top: MediaQuery.of(context).size.height * 0.14,
            left: 20,
            right: 20,
            height: MediaQuery.of(context).size.height * 0.48,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 3D Silhouette Overlay
                PalmScanner3DView(
                  isLeft: _capturingLeft,
                  isScanning: true,
                  scanningStage: 1,
                  showMounts: false,
                  showGrid: true,
                  enableGestures: false,
                ),

                // Corner Reticle Brackets
                Positioned(
                  top: 10,
                  left: 10,
                  child: _buildCornerReticle(isTop: true, isLeft: true),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: _buildCornerReticle(isTop: true, isLeft: false),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _buildCornerReticle(isTop: false, isLeft: true),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: _buildCornerReticle(isTop: false, isLeft: false),
                ),
              ],
            ),
          ),

          // Bottom Control Center
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: Column(
              children: [
                Text(
                  _capturingLeft ? "Align Your Left Palm" : "Align Your Right Palm",
                  style: const TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _capturingLeft
                      ? "Innate Blueprint (Subconscious & Natural Potential)\nKeep fingers relaxed, palm flat against light."
                      : "Manifested Reality (Active Career & Conscious Action)\nHold steady inside the holographic contour.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.white.withOpacity(0.65),
                  ),
                ),
                const SizedBox(height: 24),

                // Dual Action Buttons: Camera & Gallery
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onCaptureOrPick(fromCamera: true),
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF9D4EDD), Color(0xFF00E5FF)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00E5FF).withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "CAPTURE PALM",
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => _onCaptureOrPick(fromCamera: false),
                      child: Container(
                        height: 54,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.white.withOpacity(0.08),
                          border: Border.all(color: Colors.white.withOpacity(0.18)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.photo_library, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "GALLERY",
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
        ],
      ),
    );
  }

  Widget _buildCornerReticle({required bool isTop, required bool isLeft}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: Color(0xFF00E5FF), width: 2) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: Color(0xFF00E5FF), width: 2) : BorderSide.none,
          left: isLeft ? const BorderSide(color: Color(0xFF00E5FF), width: 2) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: Color(0xFF00E5FF), width: 2) : BorderSide.none,
        ),
      ),
    );
  }
}
