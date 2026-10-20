// lib/shared/screens/reports/screen_report_dossier_detail.dart
// AstroAI OS v4.2 - Interactive Deep-Dive Report Dossier Viewer

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../engine/vedic/vedic_report_models.dart';
import '../../engine/vedic/vedic_calculation_service.dart';
import '../../widgets/reports_celestial_painters.dart';
import '../../widgets/tajik_solar_return_3d_wheel.dart';
import '../screen_voice_session.dart';

class ScreenReportDossierDetail extends StatefulWidget {
  final dynamic reportOrSystemId;
  final String title;

  const ScreenReportDossierDetail({
    super.key,
    required this.reportOrSystemId,
    required this.title,
  });

  @override
  State<ScreenReportDossierDetail> createState() => _ScreenReportDossierDetailState();
}

class _ScreenReportDossierDetailState extends State<ScreenReportDossierDetail> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final VedicReportDossierData _dossier;
  final VedicCalculationService _calcService = VedicCalculationService();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    _dossier = _calcService.getReportDossier(widget.reportOrSystemId);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _openPrintPdfPreview() {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF14131A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2)),
        title: Row(
          children: [
            const Icon(Icons.print, color: Color(0xFFD4AF37)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Export ${_dossier.reportTitle}",
                style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your authentic 12-page PDF Dossier is ready to print or save with high-resolution Ephemeris matrices, classical shlokas, and remedial upayas.",
              style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8), height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 28),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Daivant_Vedic_Report.pdf", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      Text("2.4 MB • Cryptographically Signed", style: TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Dossier exported to Downloads: Daivant_${_dossier.reportTitle.replaceAll(' ', '_')}.pdf"),
                  backgroundColor: const Color(0xFF1E1B4B),
                ),
              );
            },
            child: const Text("Download PDF", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _askDeviOracle(String prompt) {
    HapticFeedback.heavyImpact();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScreenVoiceSession()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF09080E);
    const Color goldColor = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _dossier.categoryTag,
                          style: const TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, letterSpacing: 1.2, color: Color(0xFFD4AF37)),
                        ),
                        Text(
                          _dossier.reportTitle,
                          style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.print_outlined, color: Colors.white70),
                    tooltip: "Print / PDF",
                    onPressed: _openPrintPdfPreview,
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: Colors.white70),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Report link copied to clipboard")),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Content Scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic Header Canvas based on system
                    _buildDynamicVisualCanvas(goldColor),

                    const SizedBox(height: 20),

                    // Classical Sanskrit Shloka Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFD4AF37).withOpacity(0.12),
                            const Color(0xFF3B0764).withOpacity(0.20),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: goldColor.withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _dossier.sanskritTitle,
                            style: const TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 19, fontWeight: FontWeight.bold, color: goldColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _dossier.classicalShloka,
                            style: const TextStyle(fontFamily: 'Cinzel', fontSize: 13, height: 1.6, color: Colors.white, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "“${_dossier.shlokaMeaning}”",
                            style: TextStyle(fontSize: 11.5, fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.7), height: 1.4),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Key Metrics Grid
                    const Text(
                      "ASTROLOGICAL PARAMETERS",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, letterSpacing: 1.2, color: Colors.white54),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _dossier.coreMetrics.length,
                      itemBuilder: (context, index) {
                        final entry = _dossier.coreMetrics.entries.elementAt(index);
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.08)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(entry.key, style: const TextStyle(fontSize: 10.5, color: Colors.white54)),
                              const SizedBox(height: 2),
                              Text(entry.value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Executive Summary
                    const Text(
                      "EXECUTIVE ANALYSIS",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, letterSpacing: 1.2, color: Colors.white54),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white.withOpacity(0.07)),
                      ),
                      child: Text(
                        _dossier.executiveSummary,
                        style: TextStyle(fontSize: 13.5, height: 1.55, color: Colors.white.withOpacity(0.9)),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Detailed Breakdowns
                    const Text(
                      "COMPUTATIONAL BREAKDOWN",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, letterSpacing: 1.2, color: Colors.white54),
                    ),
                    const SizedBox(height: 8),
                    ..._dossier.detailedSections.map((sec) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.02),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("✦", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 13)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              sec,
                              style: TextStyle(fontSize: 12.5, height: 1.5, color: Colors.white.withOpacity(0.85)),
                            ),
                          ),
                        ],
                      ),
                    )),

                    const SizedBox(height: 24),

                    // Remedial Upayas
                    const Text(
                      "VEDIC REMEDIES & UPAYAS",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, letterSpacing: 1.2, color: Colors.white54),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF0F172A).withOpacity(0.8),
                            const Color(0xFF1E1B4B).withOpacity(0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.auto_awesome, color: Color(0xFF818CF8), size: 18),
                              SizedBox(width: 8),
                              Text("Prescribed Upayas", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ..._dossier.recommendations.map((rem) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("• ", style: TextStyle(color: Color(0xFF818CF8), fontSize: 16)),
                                Expanded(
                                  child: Text(
                                    rem,
                                    style: TextStyle(fontSize: 12, height: 1.45, color: Colors.white.withOpacity(0.85)),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Ask Om.AI Suggestion Prompts
                    const Text(
                      "ASK OM.AI ABOUT THIS REPORT",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9.5, letterSpacing: 1.2, color: Colors.white54),
                    ),
                    const SizedBox(height: 8),
                    ..._dossier.omAiPrompts.map((p) => GestureDetector(
                      onTap: () => _askDeviOracle(p),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                        ),
                        child: Row(
                          children: [
                            const Text("ॐ", style: TextStyle(fontSize: 15, color: Color(0xFFD4AF37))),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(p, style: const TextStyle(fontSize: 12.5, color: Colors.white70)),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white38),
                          ],
                        ),
                      ),
                    )),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicVisualCanvas(Color goldColor) {
    if (widget.reportOrSystemId == VedicSystemId.varshphal || _dossier.reportTitle.toLowerCase().contains("varshphal")) {
      return TajikSolarReturn3DWheelWidget(
        title: _dossier.reportTitle.toUpperCase(),
      );
    }
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF14131A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: goldColor.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AnimatedBuilder(
          animation: _animController,
          builder: (context, child) {
            if (widget.reportOrSystemId == VedicSystemId.dasha || widget.reportOrSystemId == VedicReportId.mahadashaPhala) {
              return CustomPaint(
                painter: DashaChakraWheelPainter(
                  animationProgress: _animController.value,
                  primaryColor: goldColor,
                ),
                child: const Center(
                  child: Text(
                    "BUDHA\nMAHADASHA",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              );
            } else if (widget.reportOrSystemId == VedicSystemId.shodashvarga) {
              return CustomPaint(
                painter: ShodashvargaMosaicPainter(
                  animationProgress: _animController.value,
                  primaryColor: goldColor,
                ),
                child: const Center(
                  child: Text(
                    "16 VARGAS\nACTIVE",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              );
            } else if (widget.reportOrSystemId == VedicReportId.sadeSatiLifeReport) {
              return CustomPaint(
                painter: SadeSatiOrbitPainter(orbitProgress: _animController.value),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "PEAK PHASE • SATURN IN AQUARIUS",
                      style: TextStyle(fontFamily: 'Space Mono', fontSize: 9, color: Color(0xFFD4AF37)),
                    ),
                  ),
                ),
              );
            } else if (widget.reportOrSystemId == VedicReportId.gemstonesReport) {
              return CustomPaint(
                painter: GemstoneFacetPainter(stoneColor: const Color(0xFF10B981)),
                child: const Center(
                  child: Text(
                    "EMERALD\n5.75 CARATS",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              );
            } else if (widget.reportOrSystemId == VedicReportId.kaalSarpDosha) {
              return CustomPaint(
                painter: KaalSarpSerpentPainter(),
                child: const Center(
                  child: Text(
                    "RAHU 1ST • KETU 7TH\nANANT YOGA",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Space Mono', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              );
            } else {
              // Default Dasha Wheel representation
              return CustomPaint(
                painter: DashaChakraWheelPainter(
                  animationProgress: _animController.value * 0.4,
                  primaryColor: goldColor,
                ),
                child: Center(
                  child: Text(
                    _dossier.reportTitle.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'Space Mono', fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
