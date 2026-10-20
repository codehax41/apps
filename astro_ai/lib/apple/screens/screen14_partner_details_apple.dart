// apple/lib/screens/screen14_partner_details_apple.dart
// Screen 14: Kundali Milan / Add Partner Details (Apple iOS Target - Cupertino Ergonomics)
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_theme.dart';
import '../theme/apple_platform_scaffold.dart';
import 'package:astro_ai/shared/widgets/daily_guidance_3d_painters.dart';
import 'screen15_compatibility_report_apple.dart';

class Screen14PartnerDetailsApple extends StatefulWidget {
  const Screen14PartnerDetailsApple({super.key});

  @override
  State<Screen14PartnerDetailsApple> createState() => _Screen14PartnerDetailsAppleState();
}

class _Screen14PartnerDetailsAppleState extends State<Screen14PartnerDetailsApple> {
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
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text("Partner's Name"),
        content: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CupertinoTextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            placeholder: "Enter full name",
            placeholderStyle: const TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() => _partnerName = controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _selectRelationship() async {
    HapticFeedback.selectionClick();
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: const Text("Select Relationship"),
        actions: _relationships
            .map((rel) => CupertinoActionSheetAction(
                  onPressed: () {
                    setState(() => _relationship = rel);
                    Navigator.pop(ctx);
                  },
                  child: Text(rel),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(ctx),
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  void _selectDob() async {
    HapticFeedback.selectionClick();
    DateTime tempDate = DateTime(1998, 11, 24);
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => Container(
        height: 280,
        color: const Color(0xFF1E1B29),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(ctx),
                ),
                CupertinoButton(
                  child: const Text("Done"),
                  onPressed: () {
                    setState(() {
                      _dob = "${tempDate.day.toString().padLeft(2, '0')}/${tempDate.month.toString().padLeft(2, '0')}/${tempDate.year}";
                    });
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                maximumDate: DateTime.now(),
                minimumYear: 1950,
                onDateTimeChanged: (d) => tempDate = d,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectTob() async {
    HapticFeedback.selectionClick();
    DateTime tempTime = DateTime(2026, 1, 1, 16, 30);
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => Container(
        height: 280,
        color: const Color(0xFF1E1B29),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(ctx),
                ),
                CupertinoButton(
                  child: const Text("Done"),
                  onPressed: () {
                    final hour = tempTime.hour == 0 ? 12 : (tempTime.hour > 12 ? tempTime.hour - 12 : tempTime.hour);
                    final period = tempTime.hour >= 12 ? "pm" : "am";
                    setState(() {
                      _tob = "${hour.toString().padLeft(2, '0')}:${tempTime.minute.toString().padLeft(2, '0')} $period";
                    });
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: tempTime,
                onDateTimeChanged: (t) => tempTime = t,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editCity() async {
    final controller = TextEditingController(text: _city == "Select City" ? "" : _city);
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text("City of Birth"),
        content: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CupertinoTextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            placeholder: "City, Country",
            placeholderStyle: const TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() => _city = controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _onCreateMatch() {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const Screen15CompatibilityReportApple()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplePlatformScaffold(
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
                          child: const Icon(CupertinoIcons.chevron_back, size: 16, color: Colors.white70),
                        ),
                      ),
                      const GoldenTwinHearts3DWidget(width: 90, height: 75),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Kundali Milan",
                    style: TextStyle(
                      fontFamily: '.SF Pro Display',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Synastry, 36 Guna Milan & Cosmic Compatibility",
                    style: TextStyle(
                      fontFamily: '.SF Pro Text',
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
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.60),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: AppleCosmicTheme.nebulaViolet.withOpacity(0.15),
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
                          fontFamily: '.SF Pro Text',
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
                          child: const Icon(CupertinoIcons.xmark, size: 14, color: Colors.white70),
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
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      color: const Color(0xFF1E1A29),
                      borderRadius: BorderRadius.circular(999),
                      onPressed: _onCreateMatch,
                      child: const Center(
                        child: Text(
                          "Create Match",
                          style: TextStyle(
                            fontFamily: '.SF Pro Text',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                  fontFamily: '.SF Pro Text',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Icon(CupertinoIcons.pencil, size: 16, color: Colors.white.withOpacity(0.40)),
            ],
          ),
          if (helperText != null) ...[
            const SizedBox(height: 3),
            Text(
              helperText,
              style: TextStyle(
                fontFamily: '.SF Pro Text',
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
