// lib/shared/screens/kundali/screen_dual_chart_kundli.dart
// Screen 1: Your Kundli Dual-Card Overlay ("Your chart, not your sun sign")
// Direct 1:1 Implementation matching Reference Screenshot (media_1792522755434_5d63f45e.jpg)

import 'package:flutter/material.dart';
import '../../widgets/batch4_celestial_painters.dart';

class ScreenDualChartKundli extends StatelessWidget {
  const ScreenDualChartKundli({super.key});

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
                "YOUR KUNDLI",
                style: TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFFE07A5F),
                ),
              ),

              const SizedBox(height: 8),

              // Headline: "Your chart, not your sun sign"
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
                    TextSpan(text: "Your chart, "),
                    TextSpan(
                      text: "not\n",
                      style: TextStyle(color: Color(0xFFE07A5F)),
                    ),
                    TextSpan(text: "your sun sign"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Dual-Layered Kundli Card (D1 + D9 Overlap with 4 Dignity Badges)
              const DualLayeredKundliWidget(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
