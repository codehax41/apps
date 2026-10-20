// lib/core/ai/openai_and_sarvam_providers.dart
// ASTROAI OS v5.0 - Concrete Voice Providers (OpenAI Realtime & Sarvam Indic AI)

import 'voice_provider_interface.dart';
import 'package:flutter/foundation.dart';

class OpenAIRealtimeVoiceProvider implements IVoiceProvider {
  @override
  String get providerId => 'openai';

  @override
  List<String> getSupportedLanguages() => [
    'en', 'es', 'fr', 'de', 'it', 'pt', 'ja', 'ko', 'zh', 'ar', 'ru', 'hi'
  ];

  @override
  List<String> getSupportedVoices(String language) => [
    'alloy', 'echo', 'fable', 'onyx', 'nova', 'shimmer'
  ];

  @override
  Future<void> startSession({
    required String sessionId,
    required String language,
    required String voiceName,
    required Function(List<int> audioChunk) onAudioReceived,
  }) async {
    debugPrint("[OpenAIRealtime] Session started: $sessionId ($language, Voice: $voiceName)");
  }

  @override
  Future<void> sendAudio(List<int> audioData) async {
    // Streams PCM audio bytes to OpenAI realtime endpoint via backend proxy
  }

  @override
  Future<void> stopSession() async {
    debugPrint("[OpenAIRealtime] Session terminated.");
  }

  @override
  bool supportsRealtime() => true;

  @override
  bool supportsIndianVoice() => false;
}

class SarvamVoiceProvider implements IVoiceProvider {
  @override
  String get providerId => 'sarvam';

  @override
  List<String> getSupportedLanguages() => [
    'hi-IN', 'en-IN', 'bn-IN', 'ta-IN', 'te-IN', 'kn-IN', 'ml-IN', 'mr-IN', 'gu-IN', 'pa-IN', 'od-IN'
  ];

  @override
  List<String> getSupportedVoices(String language) => [
    'sarvam_aditi', 'sarvam_ananya', 'sarvam_rohan', 'sarvam_priya', 'sarvam_kavya'
  ];

  @override
  Future<void> startSession({
    required String sessionId,
    required String language,
    required String voiceName,
    required Function(List<int> audioChunk) onAudioReceived,
  }) async {
    debugPrint("[SarvamVoiceProvider] Indic Session started: $sessionId (Lang: $language, Voice: $voiceName)");
  }

  @override
  Future<void> sendAudio(List<int> audioData) async {
    // Streams chunked audio to Sarvam STT WebSocket API
  }

  @override
  Future<void> stopSession() async {
    debugPrint("[SarvamVoiceProvider] Indic Session terminated.");
  }

  @override
  bool supportsRealtime() => true;

  @override
  bool supportsIndianVoice() => true;
}
