// android/lib/screens/screen14_partner_details_android.dart
// Screen 14: Kundali Milan / Add Partner Details (Google Android Target)
// High-Fidelity implementation matching exact reference screenshot (Image 5):
// - Background: Kundali Milan with 3D Golden Twin Hearts emblem
// - "Add partner details" Bottom Sheet / Modal with [X] close button
// - Interactive Form Fields with Edit Pencil (✎):
//   1. Name * ("Add Name")
//   2. Relationship * ("Select Relationship")
//   3. Date of Birth * ("Add date")
//   4. Time of Birth ("Add time" + "Time nahi diya to 12pm set ho jayega")
//   5. City of Birth * ("Select City")
// - "Create Match" CTA button with haptic feedback & navigation to Screen 15 Compatibility Report

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/android_theme.dart';
import '../theme/android_platform_scaffold.dart';
import 'package:astro_ai/shared/widgets/daily_guidance_3d_painters.dart';
import 'screen15_compatibility_report_android.dart';

class Screen14PartnerDetailsAndroid extends StatefulWidget {
  const Screen14PartnerDetailsAndroid({super.key});

  @override
  State<Screen14PartnerDetailsAndroid> createState() => _Screen14PartnerDetailsAndroidState();
}

class _Screen14PartnerDetailsAndroidState extends State<Screen14PartnerDetailsAndroid> {
  String _partnerName = "Ananya Sharma";
  String _relationship = "Spouse";
  String _dob = "24/11/1998";
  String _tob = "04:30 pm";
  String _city = "Mumbai, Maharashtra";

  final List<String> _relationships = [
    "Lover / Partner",
    "Spouse",
    "Fiancé",
    "Crush / Dating",
    "Friend",
    "Business Partner",
  ];

  void _editName() async {
    final controller = TextEditingController(text: _partnerName == "Add Name" ? "" : _partnerName);
    final res = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1824),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text("Partner's Name", style: TextStyle(color: Colors.white, fontFamily: 'Plus Jakarta Sans')),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Enter full name",
            hintStyle: TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text("Save", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    if (res != null && res.isNotEmpty) {
      setState(() => _partnerName = res);
    }
  }

  void _selectRelationship() async {
    HapticFeedback.selectionClick();
    final res = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF161420),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Relationship",
                style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              ..._relationships.map((rel) => ListTile(
                    title: Text(rel, style: const TextStyle(color: Colors.white, fontFamily: 'Plus Jakarta Sans')),
                    trailing: _relationship == rel ? const Icon(Icons.check, color: Color(0xFFFFD700)) : null,
                    onTap: () => Navigator.pop(ctx, rel),
                  )),
            ],
          ),
        ),
      ),
    );
    if (res != null) {
      setState(() => _relationship = res);
    }
  }

  void _selectDob() async {
    HapticFeedback.selectionClick();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1998, 11, 24),
      firstDate: DateTime(1950),
      lastDate: now,
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFFFD700),
            onPrimary: Colors.black,
            surface: Color(0xFF1E1B29),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _dob = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _selectTob() async {
    HapticFeedback.selectionClick();
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 16, minute: 30),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFFFD700),
            onPrimary: Colors.black,
            surface: Color(0xFF1E1B29),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final period = picked.period == DayPeriod.am ? "am" : "pm";
      setState(() {
        _tob = "${hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')} $period";
      });
    }
  }

  void _editCity() async {
    final controller = TextEditingController(text: _city == "Select City" ? "" : _city);
    final res = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1824),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text("City of Birth", style: TextStyle(color: Colors.white, fontFamily: 'Plus Jakarta Sans')),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "City, Country",
            hintStyle: TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text("Save", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    if (res != null && res.isNotEmpty) {
      setState(() => _city = res);
    }
  }

  void _onCreateMatch() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Screen15CompatibilityReportAndroid()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AndroidPlatformScaffold(
      body: Stack(
        children: [
          // Background Screen: Top Bar & Kundali Milan Title with 3D Twin Hearts
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).maybePop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1824),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.08)),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, size: 15, color: Colors.white70),
                        ),
                      ),
                      const GoldenTwinHearts3DWidget(width: 90, height: 75),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Kundali Milan",
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Synastry, 36 Guna Milan & Cosmic Compatibility",
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.55),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Modal Card: "Add partner details" (Exact to Image 5)
          Positioned(
            left: 12,
            right: 12,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                color: const Color(0xFF14121D),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: Colors.white.withOpacity(0.10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.60),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: AndroidCosmicTheme.nebulaViolet.withOpacity(0.15),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Modal Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add partner details",
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).maybePop(),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 16, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Field 1: Name *
                  _buildFormField(
                    label: "Name *",
                    value: _partnerName,
                    onTap: _editName,
                  ),

                  const SizedBox(height: 14),

                  // Field 2: Relationship *
                  _buildFormField(
                    label: "Relationship *",
                    value: _relationship,
                    onTap: _selectRelationship,
                  ),

                  const SizedBox(height: 14),

                  // Field 3: Date of Birth *
                  _buildFormField(
                    label: "Date of Birth *",
                    value: _dob,
                    onTap: _selectDob,
                  ),

                  const SizedBox(height: 14),

                  // Field 4: Time of Birth + Subtitle
                  _buildFormField(
                    label: "Time of Birth",
                    value: _tob,
                    helperText: "Time nahi diya to 12pm set ho jayega",
                    onTap: _selectTob,
                  ),

                  const SizedBox(height: 14),

                  // Field 5: City of Birth *
                  _buildFormField(
                    label: "City of Birth *",
                    value: _city,
                    onTap: _editCity,
                  ),

                  const SizedBox(height: 22),

                  // Create Match Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1A29),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: _onCreateMatch,
                          child: const Center(
                            child: Text(
                              "Create Match",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildFormField({
    required String label,
    required String value,
    String? helperText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label with Asterisk
          RichText(
            text: TextSpan(
              text: label.replaceAll("*", ""),
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 10,
                color: Colors.white.withOpacity(0.50),
              ),
              children: label.contains("*")
                  ? [
                      const TextSpan(
                        text: "*",
                        style: TextStyle(color: Color(0xFFE63946), fontWeight: FontWeight.bold),
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Icon(Icons.edit_outlined, size: 16, color: Colors.white.withOpacity(0.40)),
            ],
          ),
          if (helperText != null) ...[
            const SizedBox(height: 3),
            Text(
              helperText,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 10.5,
                color: Colors.white.withOpacity(0.38),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
