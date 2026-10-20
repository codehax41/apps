// lib/shared/screens/kundali/screen_dual_chart_kundli.dart
// Screen: Your Kundli Dual-Card Overlay ("Your chart, not your sun sign")
// Direct 1:1 Implementation matching Reference Screenshots (media_1792533988974_c93c1383.jpg & media_1792533988978_d7276c52.jpg)

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              // Dual-Layered 3D Movable Kundli Card (D1 + D9 Overlap with 3D Gestures)
              const DualLayeredKundliWidget(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
