// lib/shared/screens/reports/screen_free_reports_hub.dart
// Screen: "100+ Free Reports" Hub
// Direct 1:1 Implementation matching Reference Screenshot (media_1792524153110_57704149.jpg)
// Features: 6 Primary System tiles (Basic, Dasha, KP System, Shodashvarga, Lal Kitab, Varshphal),
// 14 Specialized Vedic Dossiers, Horizontal Filter Tabs, Action Bar (Print, Chat, Share, Help, Star).

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../engine/vedic/vedic_report_models.dart';
import 'screen_report_dossier_detail.dart';
import '../screen_voice_session.dart';

class ScreenFreeReportsHub extends StatefulWidget {
  const ScreenFreeReportsHub({super.key});

  @override
  State<ScreenFreeReportsHub> createState() => _ScreenFreeReportsHubState();
}

class _ScreenFreeReportsHubState extends State<ScreenFreeReportsHub> {
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<String> _tabs = [
    "PREDICTIONS",
    "LIFE PREDICTIONS",
    "MONTHLY PREDICTIONS",
    "DOSHAS & YOGAS",
    "LAL KITAB",
    "KP & VARSHPHAL",
  ];

  // 6 Primary Systems from the Screenshot Grid
  final List<Map<String, dynamic>> _primarySystems = [
    {
      "id": VedicSystemId.basic,
      "title": "Basic",
      "icon": Icons.history_edu_outlined,
      "color": const Color(0xFF6B7280),
    },
    {
      "id": VedicSystemId.dasha,
      "title": "Dasha",
      "icon": Icons.donut_large_outlined,
      "color": const Color(0xFF4B5563),
    },
    {
      "id": VedicSystemId.kpSystem,
      "title": "KP System",
      "icon": Icons.grid_view_rounded,
      "isKp": true,
      "color": const Color(0xFF374151),
    },
    {
      "id": VedicSystemId.shodashvarga,
      "title": "Shodashvarga",
      "icon": Icons.calendar_view_month_outlined,
      "color": const Color(0xFF4B5563),
    },
    {
      "id": VedicSystemId.lalKitab,
      "title": "Lal Kitab",
      "icon": Icons.menu_book_rounded,
      "color": const Color(0xFF374151),
    },
    {
      "id": VedicSystemId.varshphal,
      "title": "Varshphal",
      "icon": Icons.calendar_today_outlined,
      "color": const Color(0xFF4B5563),
    },
  ];

  // 14 Vedic Reports from the Screenshot List/Table (2 columns x 7 rows)
  final List<Map<String, dynamic>> _reportList = [
    {"id": VedicReportId.lifePredictions, "title": "Life Predictions", "category": "PREDICTIONS"},
    {"id": VedicReportId.monthlyPredictions, "title": "Monthly Predictions", "category": "MONTHLY PREDICTIONS"},
    {"id": VedicReportId.dailyPredictions, "title": "Daily Predictions", "category": "PREDICTIONS"},
    {"id": VedicReportId.mangalDosh, "title": "Mangal Dosh", "category": "DOSHAS & YOGAS"},
    {"id": VedicReportId.sadeSatiLifeReport, "title": "Sade Sati Life Report", "category": "DOSHAS & YOGAS"},
    {"id": VedicReportId.kaalSarpDosha, "title": "Kaal Sarp Dosha", "category": "DOSHAS & YOGAS"},
    {"id": VedicReportId.lalKitabDebt, "title": "Lal Kitab Debt", "category": "LAL KITAB"},
    {"id": VedicReportId.lalKitabTevaType, "title": "Lal Kitab Teva Type", "category": "LAL KITAB"},
    {"id": VedicReportId.lalKitabRemedies, "title": "Lal Kitab Remedies", "category": "LAL KITAB"},
    {"id": VedicReportId.ascendantPrediction, "title": "Ascendant Prediction", "category": "LIFE PREDICTIONS"},
    {"id": VedicReportId.planetConsideration, "title": "Planet Consideration", "category": "PREDICTIONS"},
    {"id": VedicReportId.gemstonesReport, "title": "Gemstones Report", "category": "PREDICTIONS"},
    {"id": VedicReportId.transitToday, "title": "Transit Today", "category": "PREDICTIONS"},
    {"id": VedicReportId.mahadashaPhala, "title": "Mahadasha Phala", "category": "PREDICTIONS"},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openReport(dynamic id, String title) {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenReportDossierDetail(
          reportOrSystemId: id,
          title: title,
        ),
      ),
    );
  }

  void _openPrintAll() {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Preparing complete 100+ Free Reports Dossier (PDF)..."),
        backgroundColor: Color(0xFF1E1B4B),
      ),
    );
  }

  void _openDeviChat() {
    HapticFeedback.heavyImpact();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScreenVoiceSession()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredReports = _reportList.where((r) {
      if (_searchQuery.isNotEmpty) {
        return r["title"].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      }
      if (_selectedTabIndex == 0) return true; // All PREDICTIONS
      final tabCategory = _tabs[_selectedTabIndex];
      return r["category"] == tabCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFBF4E8), // Light Champagne Gold background from screenshot
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Back Arrow Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                    ),
                  ),
                  const Text("✦", style: TextStyle(fontSize: 22, color: Color(0xFFD4AF37))),
                ],
              ),

              const SizedBox(height: 12),

              // Title: "100+ Free Reports"
              const Text(
                "100+ Free Reports",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  color: Color(0xFF1B1917),
                ),
              ),

              const SizedBox(height: 18),

              // Realistic Phone Frame Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: const Color(0xFF222222), width: 6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 28,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Column(
                    children: [
                      // Status Bar inside phone
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                        color: const Color(0xFFFDB813), // Golden header background
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "9:41",
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            Row(
                              children: [
                                Icon(Icons.wifi, size: 12, color: Colors.black87),
                                SizedBox(width: 4),
                                Icon(Icons.battery_charging_full, size: 13, color: Colors.black87),
                                SizedBox(width: 2),
                                Text("83%", style: TextStyle(fontSize: 10, color: Colors.black87)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Golden Header App Bar from Screenshot
                      Container(
                        color: const Color(0xFFFDB813),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.menu, size: 22, color: Colors.black87),
                            const SizedBox(width: 8),
                            const Text(
                              "Predicti...",
                              style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            const Icon(Icons.arrow_drop_down, color: Colors.black87),
                            const Spacer(),
                            // Action Icons Row
                            IconButton(
                              icon: const Icon(Icons.print, size: 20, color: Colors.black87),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: _openPrintAll,
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline, size: 19, color: Colors.black87),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: _openDeviChat,
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              icon: const Icon(Icons.share, size: 19, color: Colors.black87),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Link copied to clipboard")),
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.help_outline, size: 19, color: Colors.black87),
                            const SizedBox(width: 12),
                            const Icon(Icons.star_border, size: 20, color: Colors.black87),
                            const SizedBox(width: 10),
                            const Icon(Icons.more_vert, size: 20, color: Colors.black87),
                          ],
                        ),
                      ),

                      // Horizontal Category Tabs
                      Container(
                        color: const Color(0xFFFDB813),
                        height: 38,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: _tabs.length,
                          itemBuilder: (context, index) {
                            final isSelected = _selectedTabIndex == index;
                            return GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(() {
                                  _selectedTabIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: isSelected ? Colors.black : Colors.transparent,
                                      width: 3.0,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _tabs[index],
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 11.5,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                    color: isSelected ? Colors.black : Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Optional Live Search Bar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(fontSize: 12.5),
                            decoration: const InputDecoration(
                              hintText: "Search 100+ reports (e.g. Mangal, Dasha, Gemstones)",
                              hintStyle: TextStyle(fontSize: 11, color: Colors.black45),
                              prefixIcon: Icon(Icons.search, size: 18, color: Colors.black54),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _searchQuery = val.trim();
                              });
                            },
                          ),
                        ),
                      ),

                      // 6 Primary System Grid Tiles (2 rows x 3 columns)
                      Container(
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.15,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                          itemCount: _primarySystems.length,
                          itemBuilder: (context, index) {
                            final sys = _primarySystems[index];
                            return InkWell(
                              onTap: () => _openReport(sys["id"], sys["title"]),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: (index % 3 != 2) ? const Color(0xFFE5E7EB) : Colors.transparent,
                                      width: 1.0,
                                    ),
                                    bottom: BorderSide(
                                      color: (index < 3) ? const Color(0xFFE5E7EB) : Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (sys["isKp"] == true)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black87, width: 1.5),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          "KP",
                                          style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                                        ),
                                      )
                                    else
                                      Icon(sys["icon"] as IconData, size: 28, color: Colors.black87),
                                    const SizedBox(height: 6),
                                    Text(
                                      sys["title"] as String,
                                      style: const TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // 14 Specialized Reports Grid / Table (2 columns)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.8,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                          itemCount: filteredReports.length,
                          itemBuilder: (context, index) {
                            final report = filteredReports[index];
                            final isLeft = index % 2 == 0;
                            return InkWell(
                              onTap: () => _openReport(report["id"], report["title"] as String),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: isLeft ? const Color(0xFFE5E7EB) : Colors.transparent,
                                      width: 1.0,
                                    ),
                                    bottom: const BorderSide(
                                      color: Color(0xFFE5E7EB),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  report["title"] as String,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
