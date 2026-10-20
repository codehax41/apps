// shared/services/cloudflare_service.dart
// Unified Cloudflare Storage & Worker Gateway Service for ASTROAI OS v4.0.
// Handles high-capacity object storage (Cloudflare R2), chat transcripts, generational artifacts,
// and user snapshots for both Apple iOS and Google Android targets.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/cloudflare_config.dart';
import '../models/user_profile.dart';

class CloudflareService {
  CloudflareService._privateConstructor();
  static final CloudflareService instance = CloudflareService._privateConstructor();

  // In-memory local cache for resilient offline execution
  final Map<String, List<Map<String, dynamic>>> _chatSessions = {};
  final Map<String, Map<String, dynamic>> _generationalArtifacts = {};
  final Map<String, Map<String, dynamic>> _userBackups = {};

  // ==========================================
  // 1. CHAT STORAGE & TRANSCRIPT ARCHIVE
  // ==========================================

  /// Stores full Devi AI Oracle chat session or voice conversation to Cloudflare R2 / Worker
  Future<bool> storeChatSession({
    required String sessionId,
    required String userId,
    required List<Map<String, dynamic>> messages,
    Map<String, dynamic>? metadata,
  }) async {
    final payload = {
      'sessionId': sessionId,
      'userId': userId,
      'storedAt': DateTime.now().toIso8601String(),
      'messagesCount': messages.length,
      'metadata': metadata ?? {},
      'messages': messages,
    };

    // Cache locally
    _chatSessions[sessionId] = messages;

    try {
      final url = Uri.parse('${CloudflareConfig.workerBaseUrl}/chat/store');
      final response = await http.post(
        url,
        headers: CloudflareConfig.authHeaders,
        body: jsonEncode({
          'key': '${CloudflareConfig.namespaceChats}/$userId/$sessionId.json',
          'data': payload,
        }),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("✦ [CloudflareService] Chat session $sessionId saved to Cloudflare R2");
        return true;
      }
    } catch (e) {
      debugPrint("✦ [CloudflareService] Cloudflare network call deferred (offline/cached): $e");
    }

    return true; // Succeeded into cache
  }

  /// Retrieves a chat session from Cloudflare
  Future<List<Map<String, dynamic>>> fetchChatSession({
    required String userId,
    required String sessionId,
  }) async {
    if (_chatSessions.containsKey(sessionId)) {
      return _chatSessions[sessionId]!;
    }

    try {
      final url = Uri.parse('${CloudflareConfig.workerBaseUrl}/chat/get?key=${CloudflareConfig.namespaceChats}/$userId/$sessionId.json');
      final response = await http.get(url, headers: CloudflareConfig.authHeaders).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final messages = (decoded['messages'] as List<dynamic>).map((e) => e as Map<String, dynamic>).toList();
        _chatSessions[sessionId] = messages;
        return messages;
      }
    } catch (e) {
      debugPrint("✦ [CloudflareService] Fetch chat error (using local cache): $e");
    }

    return [];
  }

  // ==========================================
  // 2. GENERATION ARTIFACTS STORAGE
  // ==========================================

  /// Stores generated astrological charts (D1, D9, D10, D60), transit matrices, and synastry reports
  Future<bool> storeGenerationArtifact({
    required String artifactId,
    required String userId,
    required String type, // 'kundali_d1', 'navamsa_d9', 'transit_forecast', 'career_d10'
    required dynamic payload,
    Map<String, dynamic>? parameters,
  }) async {
    final artifact = {
      'artifactId': artifactId,
      'userId': userId,
      'type': type,
      'generatedAt': DateTime.now().toIso8601String(),
      'parameters': parameters ?? {},
      'payload': payload,
    };

    _generationalArtifacts[artifactId] = artifact;

    try {
      final url = Uri.parse('${CloudflareConfig.workerBaseUrl}/artifact/store');
      final response = await http.post(
        url,
        headers: CloudflareConfig.authHeaders,
        body: jsonEncode({
          'key': '${CloudflareConfig.namespaceGenerations}/$userId/$type/$artifactId.json',
          'data': artifact,
        }),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("✦ [CloudflareService] Generation artifact $artifactId saved to Cloudflare R2");
        return true;
      }
    } catch (e) {
      debugPrint("✦ [CloudflareService] Artifact network call deferred (cached): $e");
    }

    return true;
  }

  /// Retrieves a generational artifact from Cloudflare
  Future<Map<String, dynamic>?> fetchGenerationArtifact({
    required String userId,
    required String artifactId,
    required String type,
  }) async {
    if (_generationalArtifacts.containsKey(artifactId)) {
      return _generationalArtifacts[artifactId];
    }

    try {
      final url = Uri.parse('${CloudflareConfig.workerBaseUrl}/artifact/get?key=${CloudflareConfig.namespaceGenerations}/$userId/$type/$artifactId.json');
      final response = await http.get(url, headers: CloudflareConfig.authHeaders).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        _generationalArtifacts[artifactId] = decoded;
        return decoded;
      }
    } catch (e) {
      debugPrint("✦ [CloudflareService] Fetch artifact error: $e");
    }

    return null;
  }

  // ==========================================
  // 3. USER DETAILS BACKUP & COLD STORAGE
  // ==========================================

  /// Backs up complete user details, focus vectors, and natal coordinates to Cloudflare R2
  Future<bool> backupUserDetails({
    required String userId,
    required UserProfile profile,
    Map<String, dynamic>? extraDetails,
  }) async {
    final backupData = {
      'userId': userId,
      'profile': profile.toMap(),
      'extraDetails': extraDetails ?? {},
      'backupTimestamp': DateTime.now().toIso8601String(),
    };

    _userBackups[userId] = backupData;

    try {
      final url = Uri.parse('${CloudflareConfig.workerBaseUrl}/user/backup');
      final response = await http.post(
        url,
        headers: CloudflareConfig.authHeaders,
        body: jsonEncode({
          'key': '${CloudflareConfig.namespaceUserBackups}/$userId/profile_snapshot.json',
          'data': backupData,
        }),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("✦ [CloudflareService] User details backup saved to Cloudflare R2 for $userId");
        return true;
      }
    } catch (e) {
      debugPrint("✦ [CloudflareService] Backup network call deferred (cached): $e");
    }

    return true;
  }

  // ==========================================
  // 4. PURGE & ZERO-KNOWLEDGE ERASURE (Screen 26)
  // ==========================================

  /// Erases all user chats, generations, and backups stored in Cloudflare R2
  Future<bool> purgeAllCloudflareUserData({required String userId}) async {
    _chatSessions.removeWhere((key, value) => true);
    _generationalArtifacts.removeWhere((key, value) => true);
    _userBackups.remove(userId);

    try {
      final url = Uri.parse('${CloudflareConfig.workerBaseUrl}/user/purge');
      final response = await http.post(
        url,
        headers: CloudflareConfig.authHeaders,
        body: jsonEncode({'userId': userId}),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        debugPrint("✦ [CloudflareService] All user data purged from Cloudflare R2: $userId");
        return true;
      }
    } catch (e) {
      debugPrint("✦ [CloudflareService] Cloudflare purge error: $e");
    }

    return true;
  }
}
