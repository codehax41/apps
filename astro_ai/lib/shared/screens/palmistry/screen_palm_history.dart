// lib/shared/screens/palmistry/screen_palm_history.dart
// ASTROAI OS v5.0 - Palmistry Reading History & Session Dossier Vault

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/palmistry/models/palm_reading_model.dart';
import '../../../core/palmistry/services/palmistry_service.dart';
import 'screen_palm_report.dart';
import 'screen_palm_capture.dart';

class ScreenPalmHistory extends StatefulWidget {
  const ScreenPalmHistory({super.key});

  @override
  State<ScreenPalmHistory> createState() => _ScreenPalmHistoryState();
}

class _ScreenPalmHistoryState extends State<ScreenPalmHistory> {
  final String _userId = 'usr_astro_master_88';
  List<PalmReading> _readings = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    PalmistryService.instance.seedSampleReadingIfEmpty(_userId);
    setState(() {
      _readings = PalmistryService.instance.getUserReadings(_userId);
    });
  }

  Future<void> _deleteReading(String id) async {
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
          "This will permanently erase this reading and all extracted biometric line vectors from your device. This cannot be undone.",
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
            child: const Text("DELETE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      HapticFeedback.heavyImpact();
      await PalmistryService.instance.deleteReading(id);
      _loadHistory();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reading purged successfully.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05050A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF090615),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Your Palm Readings",
          style: TextStyle(
            fontFamily: 'Cormorant Garamond',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF00E5FF)),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ScreenPalmCapture()),
              );
            },
          ),
        ],
      ),
      body: _readings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.pan_tool_outlined, size: 54, color: Colors.white24),
                  const SizedBox(height: 16),
                  const Text(
                    "No palm readings yet",
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Place your hands into the cosmic scanner to begin.",
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00E5FF),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ScreenPalmCapture()),
                      );
                    },
                    child: const Text("Scan Your Palm", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: _readings.length,
              itemBuilder: (ctx, i) {
                final r = _readings[i];
                final report = r.report;
                final dateStr = "${r.createdAt.day}/${r.createdAt.month}/${r.createdAt.year}";

                return Dismissible(
                  key: Key(r.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3366).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (dir) async {
                    await _deleteReading(r.id);
                    return false;
                  },
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenPalmReport(readingId: r.id),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF110E24),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E5FF).withOpacity(0.12),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
                            ),
                            child: const Center(
                              child: Icon(Icons.touch_app, color: Color(0xFF00E5FF), size: 22),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      report?.title ?? "Cosmic Palm Reading",
                                      style: const TextStyle(
                                        fontFamily: 'Cormorant Garamond',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      dateStr,
                                      style: TextStyle(
                                        fontFamily: 'Space Mono',
                                        fontSize: 9,
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  report?.overview ?? "Bilateral palm line extraction and Samudrika synthesis.",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 11.5,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right, color: Colors.white38, size: 18),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
