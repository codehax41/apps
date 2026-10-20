// lib/core/ai/ai_provider_interface.dart
// ASTROAI OS v5.0 - Abstract AI & Realtime Provider Interfaces

abstract class IAIProvider {
  String get providerId;

  Future<String> generateText({
    required String prompt,
    required String systemInstruction,
    String? language,
  });

  Stream<String> streamText({
    required String prompt,
    required String systemInstruction,
    String? language,
  });

  Future<Map<String, dynamic>> createRealtimeSession({
    required String userId,
    required String language,
    required String voiceName,
  });

  Future<void> endRealtimeSession(String sessionId);
}
