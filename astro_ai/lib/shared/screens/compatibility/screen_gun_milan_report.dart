// lib/shared/screens/compatibility/screen_gun_milan_report.dart
// Screen 4: Gun Milan from Both Your Charts
// Direct 1:1 Implementation matching Reference Screenshot (media_1792523863353_5d2884f9.jpg)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/batch5_celestial_painters.dart';
import '../screen_voice_session.dart';

class ScreenGunMilanReport extends StatefulWidget {
  final String partnerName;

  const ScreenGunMilanReport({
    super.key,
    this.partnerName = "Priya",
  });

  @override
  State<ScreenGunMilanReport> createState() => _ScreenGunMilanReportState();
}

class _ScreenGunMilanReportState extends State<ScreenGunMilanReport> {
  int _selectedTab = 0; // 0: Report, 1: Chart, 2: Ask
  bool _isGunMilanSelected = true;

  final List<AshtakootRowItem> _kutas = const [
    AshtakootRowItem(
      kutaName: "Gana",
      pointsFraction: "6/6",
      femaleAttribute: "Manushya",
      maleAttribute: "Manushya",
      description: "Temperament group — grounded, balanced or intense by nature.",
    ),
    AshtakootRowItem(
      kutaName: "Bhakoot",
      pointsFraction: "7/7",
      femaleAttribute: "Aquarius",
      maleAttribute: "Sagittarius",
      description: "Moon-sign spacing — emotional rhythm and shared prosperity.",
    ),
    AshtakootRowItem(
      kutaName: "Nadi",
      pointsFraction: "8/8",
      femaleAttribute: "Adi",
      maleAttribute: "Madhya",
      description: "Constitution and lineage — the heaviest-weighted kuta.",
    ),
    AshtakootRowItem(
      kutaName: "Maitri",
      pointsFraction: "4/5",
      femaleAttribute: "Saturn",
      maleAttribute: "Jupiter",
      description: "Friendship of planetary lords — mutual respect and worldview.",
    ),
    AshtakootRowItem(
      kutaName: "Varna",
      pointsFraction: "1/1",
      femaleAttribute: "Shudra",
      maleAttribute: "Kshatriya",
      description: "Spiritual ego alignment and social harmony.",
    ),
    AshtakootRowItem(
      kutaName: "Yoni",
      pointsFraction: "3.5/4",
      femaleAttribute: "Ashwa",
      maleAttribute: "Simha",
      description: "Biological and physical compatibility affinity.",
    ),
  ];

  void _showLearnModal() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF16151E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Understanding Ashta Kuta Milan",
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Gun Milan scores 8 vital dimensions of partnership out of 36 points:\n\n"
              "• 18+ Points: Acceptable match for traditional alliance\n"
              "• 24+ Points: Harmonious & prosperous bond\n"
              "• 28+ Points: Exceptional spiritual, mental, and physical synchronicity (29.5/36 is in the top 5th percentile).\n\n"
              "Nadi (8 pts) and Bhakoot (7 pts) carry the greatest weight for lineage health and emotional longevity.",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE07A5F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Understood", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareReport() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Shared Gun Milan score (29.5/36 - Excellent) for ${widget.partnerName} to clipboard."),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Back Arrow
              GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1D26),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: const Icon(Icons.arrow_back, size: 20, color: Colors.white70),
                ),
              ),

              const SizedBox(height: 24),

              // Subtitle in terracotta uppercase
              const Text(
                "GUN MILAN",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFFE07A5F),
                ),
              ),

              const SizedBox(height: 8),

              // Headline: "Gun Milan from both your charts"
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
                    TextSpan(text: "Gun Milan from\n"),
                    TextSpan(
                      text: "both your charts",
                      style: TextStyle(color: Color(0xFFE07A5F)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Main Card Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1D24),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  children: [
                    // Card Header: < Priya | Learn | Share
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.chevron_left, color: Colors.white70, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              widget.partnerName,
                              style: const TextStyle(
                                fontFamily: 'Cormorant Garamond',
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _showLearnModal,
                              child: const Text(
                                "Learn",
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            GestureDetector(
                              onTap: _shareReport,
                              child: const Icon(Icons.share_outlined, size: 18, color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Top Tab Bar: [ Report ] | [ Chart ] | [ Ask ]
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTabButton("Report", 0),
                        _buildTabButton("Chart", 1),
                        _buildTabButton("Ask", 2),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Secondary Pill Toggle: [ Overview ] vs [ Gun Milan ]
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131217),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(() => _isGunMilanSelected = false);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: !_isGunMilanSelected ? const Color(0xFFE07A5F) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Overview",
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    color: !_isGunMilanSelected ? Colors.white : Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(() => _isGunMilanSelected = true);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: _isGunMilanSelected ? const Color(0xFFE07A5F) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Gun Milan",
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    color: _isGunMilanSelected ? Colors.white : Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Tab Views
                    if (_selectedTab == 0) ...[
                      // Ashta Koot Breakdown
                      GunMilanAshtaKootBreakdownWidget(
                        partnerName: widget.partnerName,
                        totalScore: 29.5,
                        maxScore: 36.0,
                        verdict: "Excellent",
                        kutas: _kutas,
                      ),
                    ] else if (_selectedTab == 1) ...[
                      // Synastry Chart Preview
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const Center(
                          child: Text(
                            "Dual Synastry Natal Charts are synchronized with Lahiri Ayanamsa.",
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ] else ...[
                      // Ask Tab
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE07A5F),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ScreenVoiceSession()),
                            );
                          },
                          icon: const Icon(Icons.mic, color: Colors.white),
                          label: const Text("Ask Devi about this match", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
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

  Widget _buildTabButton(String title, int index) {
    final isSel = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedTab = index);
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13.5,
              fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
              color: isSel ? Colors.white : Colors.white60,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 32,
            height: 2,
            color: isSel ? const Color(0xFFE07A5F) : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
