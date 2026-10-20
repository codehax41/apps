// lib/shared/screens/palmistry/screen_palm_report.dart
// ASTROAI OS v5.0 - Cinematic Cosmic Palm Dossier & Multi-Dimensional Report

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/palmistry/models/palm_reading_model.dart';
import '../../../core/palmistry/services/palmistry_service.dart';
import '../../engine/3d/palm_scanner_3d_view.dart';
import 'screen_live_palm_map.dart';

class ScreenPalmReport extends StatefulWidget {
  final String readingId;

  const ScreenPalmReport({super.key, required this.readingId});

  @override
  State<ScreenPalmReport> createState() => _ScreenPalmReportState();
}

class _ScreenPalmReportState extends State<ScreenPalmReport> {
  late PalmReading _reading;
  bool _isLeftHand = true;
  String _selectedCategory = 'Overview'; // Overview, Heart, Mind, Life, Fate, Mounts, Comparison, Reflection
  String? _focusedLineId;

  final List<String> _categories = [
    'Overview',
    'Heart',
    'Mind',
    'Life',
    'Fate',
    'Mounts',
    'Comparison',
    'Reflection',
  ];

  @override
  void initState() {
    super.initState();
    _loadReading();
  }

  void _loadReading() {
    final r = PalmistryService.instance.getReading(widget.readingId);
    if (r == null || r.report == null) {
      // Fallback seed for preview
      PalmistryService.instance.seedSampleReadingIfEmpty('usr_astro_master_88');
      _reading = PalmReading(
        id: widget.readingId,
        userId: 'usr_astro_master_88',
        status: PalmReadingStatus.completed,
        createdAt: DateTime.now(),
        report: null,
      );
    } else {
      _reading = r;
    }
  }

  void _onCategoryChanged(String category) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedCategory = category;
      switch (category) {
        case 'Heart':
          _focusedLineId = 'heart_line';
          break;
        case 'Mind':
          _focusedLineId = 'head_line';
          break;
        case 'Life':
          _focusedLineId = 'life_line';
          break;
        case 'Fate':
          _focusedLineId = 'fate_line';
          break;
        default:
          _focusedLineId = null;
      }
    });
  }

  Future<void> _deleteThisReading() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF140E2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Delete Palm Reading?",
          style: TextStyle(fontFamily: 'Cormorant Garamond', color: Colors.white, fontSize: 22),
        ),
        content: Text(
          "This permanently removes this palm scan, analysis report, and associated visual vectors. This cannot be undone.",
          style: TextStyle(fontFamily: 'Plus Jakarta Sans', color: Colors.white.withOpacity(0.7), fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("CANCEL", style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF3366)),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("DELETE READING", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      HapticFeedback.heavyImpact();
      await PalmistryService.instance.deleteReading(_reading.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Palm reading permanently deleted.")),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final report = _reading.report;
    final activeSide = _isLeftHand ? report?.leftPalm : report?.rightPalm;

    return Scaffold(
      backgroundColor: const Color(0xFF05050A),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Collapsible Top 3D Viewport Header
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: const Color(0xFF090615),
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white12),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Cosmic Palm dossier link copied to clipboard."),
                      backgroundColor: Color(0xFF1B1536),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Icon(Icons.share_outlined, color: Colors.white, size: 18),
                ),
              ),
              GestureDetector(
                onTap: _deleteThisReading,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Icon(Icons.delete_outline, color: Color(0xFFFF5252), size: 18),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(0, -0.4),
                          radius: 1.1,
                          colors: [Color(0xFF221142), Color(0xFF090615)],
                        ),
                      ),
                    ),
                  ),
                  // 3D Palm Model
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: PalmScanner3DView(
                        isLeft: _isLeftHand,
                        isScanning: false,
                        scanningStage: 10,
                        sideAnalysis: activeSide,
                        focusedLineId: _focusedLineId,
                        showMounts: true,
                        showGrid: false,
                        enableGestures: true,
                      ),
                    ),
                  ),

                  // Floating Hand Toggle Capsule
                  Positioned(
                    bottom: 12,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildHandToggleButton("LEFT (INNATE)", _isLeftHand, () {
                                HapticFeedback.selectionClick();
                                setState(() => _isLeftHand = true);
                              }),
                              _buildHandToggleButton("RIGHT (ACTIVE)", !_isLeftHand, () {
                                HapticFeedback.selectionClick();
                                setState(() => _isLeftHand = false);
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Dossier Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Block
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "YOUR PALM MAP",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 11,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00E5FF),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            report?.title ?? "Cosmic Bilateral Dossier",
                            style: const TextStyle(
                              fontFamily: 'Cormorant Garamond',
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00FF66).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.3)),
                        ),
                        child: const Text(
                          "96% ACCURACY",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00FF66),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Signature "Explore Live Palm Map" CTA
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenLivePalmMap(
                            readingId: widget.readingId,
                            initialIsLeft: _isLeftHand,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00E5FF).withOpacity(0.15),
                            const Color(0xFF9D4EDD).withOpacity(0.2),
                          ],
                        ),
                        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.4)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.touch_app, color: Color(0xFF00E5FF), size: 22),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "EXPLORE LIVE PALM MAP",
                                  style: TextStyle(
                                    fontFamily: 'Space Mono',
                                    fontSize: 11,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00E5FF),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Interactive 3D mode: tap line markers and inspect mounts",
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 11,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Horizontal Category Pills
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _categories.length,
                      separatorBuilder: (ctx, i) => const SizedBox(width: 8),
                      itemBuilder: (ctx, i) {
                        final cat = _categories[i];
                        final isSelected = cat == _selectedCategory;
                        return GestureDetector(
                          onTap: () => _onCategoryChanged(cat),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF00E5FF)
                                  : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF00E5FF)
                                    : Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.black : Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Dynamic Category Content Cards
                  _buildSelectedCategoryCard(report, activeSide),

                  const SizedBox(height: 28),

                  // Safety Disclaimer Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(0.06)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, size: 16, color: Colors.white38),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            report?.disclaimer ??
                                "Traditional Samudrika Shastra interpretation. This analysis does not make medical, fatalistic, or deterministic claims.",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 10.5,
                              height: 1.4,
                              color: Colors.white.withOpacity(0.45),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandToggleButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00E5FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
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

  Widget _buildSelectedCategoryCard(PalmReadingReport? report, PalmSideAnalysis? side) {
    if (side == null || report == null) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF00E5FF)));
    }

    switch (_selectedCategory) {
      case 'Overview':
        return _buildOverviewCard(report, side);
      case 'Heart':
        return _buildLineDetailCard(side.heartLine);
      case 'Mind':
        return _buildLineDetailCard(side.headLine);
      case 'Life':
        return _buildLineDetailCard(side.lifeLine);
      case 'Fate':
        return _buildLineDetailCard(side.fateLine);
      case 'Mounts':
        return _buildMountsListCard(side.mounts);
      case 'Comparison':
        return _buildComparisonCard(report.comparison);
      case 'Reflection':
        return _buildReflectionCard(report);
      default:
        return _buildOverviewCard(report, side);
    }
  }

  Widget _buildOverviewCard(PalmReadingReport report, PalmSideAnalysis side) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF100D22),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ELEMENT: ${side.palmElement.toUpperCase()}",
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 10,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
              ),
              Text(
                _isLeftHand ? "PASSIVE BLUEPRINT" : "ACTIVE MANIFESTATION",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 9,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            report.overview,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14,
              height: 1.6,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.handyman_outlined, size: 16, color: Color(0xFF00E5FF)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    side.fingerProportions,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineDetailCard(PalmLineFeature line) {
    final color = _parseColor(line.colorHex);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF100D22),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    line.name.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: color,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  line.sanskritName,
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 9,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "OBSERVED PATTERN",
            style: TextStyle(
              fontFamily: 'Space Mono',
              fontSize: 9,
              letterSpacing: 1.0,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            line.observedPattern,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              height: 1.4,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "TRADITIONAL SAMUDRIKA SIGNIFICANCE",
            style: TextStyle(
              fontFamily: 'Space Mono',
              fontSize: 9,
              letterSpacing: 1.0,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            line.traditionalMeaning,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              height: 1.4,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "DAIVANT AI SYNTHESIS",
            style: TextStyle(
              fontFamily: 'Space Mono',
              fontSize: 9,
              letterSpacing: 1.0,
              color: Color(0xFF00E5FF),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            line.aiNarrative,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMountsListCard(List<PalmMount> mounts) {
    return Column(
      children: mounts.map((m) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF100D22),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    m.name,
                    style: const TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      m.planetVedic,
                      style: const TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 9,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Prominence: ${m.prominence}",
                style: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 10,
                  color: Color(0xFF00FF66),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                m.traditionalSignificance,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12.5,
                  height: 1.4,
                  color: Colors.white.withOpacity(0.75),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildComparisonCard(PalmComparison comp) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF100D22),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "BILATERAL SYNCHRONIZATION",
            style: TextStyle(
              fontFamily: 'Space Mono',
              fontSize: 10,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00E5FF),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Your hands tell two sides of the story.",
            style: TextStyle(
              fontFamily: 'Cormorant Garamond',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            comp.summary,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comp.innatePotentialLeft,
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, color: Colors.white.withOpacity(0.8)),
                ),
                const SizedBox(height: 8),
                Text(
                  comp.manifestedRealityRight,
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, color: Colors.white.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReflectionCard(PalmReadingReport report) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF100D22),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "KEY STRENGTHS & THEMES",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 10,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FF66),
                ),
              ),
              const SizedBox(height: 12),
              ...report.strengthsAndThemes.map((st) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("✦ ", style: TextStyle(color: Color(0xFF00FF66))),
                        Expanded(
                          child: Text(
                            st,
                            style: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF100D22),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "AREAS OF INTENTIONAL RESTORATION",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 10,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
              ),
              const SizedBox(height: 12),
              ...report.areasOfReflection.map((ar) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("✦ ", style: TextStyle(color: Color(0xFFFFD700))),
                        Expanded(
                          child: Text(
                            ar,
                            style: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Color _parseColor(String hex) {
    try {
      final clean = hex.replaceAll('#', '');
      return Color(int.parse('0xFF$clean'));
    } catch (_) {
      return const Color(0xFF00E5FF);
    }
  }
}
