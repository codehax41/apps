// lib/shared/screens/palmistry/screen_live_palm_map.dart
// ASTROAI OS v5.0 - Signature Feature: Full-Screen Interactive 3D Live Palm Map

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/palmistry/models/palm_reading_model.dart';
import '../../../core/palmistry/services/palmistry_service.dart';
import '../../engine/3d/palm_scanner_3d_view.dart';

class ScreenLivePalmMap extends StatefulWidget {
  final String readingId;
  final bool initialIsLeft;

  const ScreenLivePalmMap({
    super.key,
    required this.readingId,
    this.initialIsLeft = true,
  });

  @override
  State<ScreenLivePalmMap> createState() => _ScreenLivePalmMapState();
}

class _ScreenLivePalmMapState extends State<ScreenLivePalmMap> {
  late bool _isLeft;
  late PalmReading _reading;
  PalmLineFeature? _selectedLine;

  @override
  void initState() {
    super.initState();
    _isLeft = widget.initialIsLeft;
    _reading = PalmistryService.instance.getReading(widget.readingId) ??
        PalmReading(
          id: widget.readingId,
          userId: 'usr_default',
          status: PalmReadingStatus.completed,
          createdAt: DateTime.now(),
        );
  }

  void _selectLine(PalmLineFeature line) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedLine = line;
    });
  }

  @override
  Widget build(BuildContext context) {
    final report = _reading.report;
    final activeSide = _isLeft ? report?.leftPalm : report?.rightPalm;

    return Scaffold(
      backgroundColor: const Color(0xFF05050A),
      body: Stack(
        children: [
          // Infinite Space Void Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Color(0xFF1E133E),
                    Color(0xFF090615),
                    Color(0xFF020205),
                  ],
                ),
              ),
            ),
          ),

          // Central Interactive 3D Palm Engine
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 140),
              child: PalmScanner3DView(
                isLeft: _isLeft,
                isScanning: false,
                scanningStage: 10,
                sideAnalysis: activeSide,
                focusedLineId: _selectedLine?.id,
                showMounts: true,
                showGrid: true,
                enableGestures: true,
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
                        color: Colors.black54,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),

                  // Bilateral Switch
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSwitchButton("LEFT", _isLeft, () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _isLeft = true;
                            _selectedLine = null;
                          });
                        }),
                        _buildSwitchButton("RIGHT", !_isLeft, () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _isLeft = false;
                            _selectedLine = null;
                          });
                        }),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
                    ),
                    child: const Text(
                      "LIVE 3D",
                      style: TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        color: Color(0xFF00E5FF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Gesture Guidance Label
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Center(
              child: Text(
                "DRAG TO ROTATE 3D PALM • PINCH TO ZOOM • DOUBLE TAP TO RESET",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 8.5,
                  letterSpacing: 1.2,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
          ),

          // Floating Glass Inspection Card (When a line is selected)
          if (_selectedLine != null)
            Positioned(
              left: 20,
              right: 20,
              bottom: 100,
              child: _buildInspectionGlassCard(_selectedLine!),
            ),

          // Bottom Horizontal Line Selector Deck
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: activeSide != null
                ? SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildLineDeckPill(activeSide.heartLine, const Color(0xFFFF3366)),
                        const SizedBox(width: 8),
                        _buildLineDeckPill(activeSide.headLine, const Color(0xFF00E5FF)),
                        const SizedBox(width: 8),
                        _buildLineDeckPill(activeSide.lifeLine, const Color(0xFF00FF66)),
                        const SizedBox(width: 8),
                        _buildLineDeckPill(activeSide.fateLine, const Color(0xFFFFB800)),
                        if (activeSide.sunLine != null) ...[
                          const SizedBox(width: 8),
                          _buildLineDeckPill(activeSide.sunLine!, const Color(0xFFE0AAFF)),
                        ],
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00E5FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 9.5,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.white60,
          ),
        ),
      ),
    );
  }

  Widget _buildLineDeckPill(PalmLineFeature line, Color accent) {
    final isSelected = _selectedLine?.id == line.id;
    return GestureDetector(
      onTap: () => _selectLine(line),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? accent : Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? accent : Colors.white24,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accent.withOpacity(0.4),
                    blurRadius: 14,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              line.name,
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectionGlassCard(PalmLineFeature line) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF130E26).withOpacity(0.95),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    line.name.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: Color(0xFF00E5FF),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "(${line.sanskritName})",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedLine = null),
                child: const Icon(Icons.close, color: Colors.white60, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            line.observedPattern,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            line.traditionalMeaning,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
