// lib/core/ai/voice_provider_interface.dart
// ASTROAI OS v5.0 - Abstract Voice Provider Interface

abstract class IVoiceProvider {
  String get providerId; // 'openai', 'sarvam'

  List<String> getSupportedLanguages();

  List<String> getSupportedVoices(String language);

  Future<void> startSession({
    required String sessionId,
    required String language,
    required String voiceName,
    required Function(List<int> audioChunk) onAudioReceived,
  });

  Future<void> sendAudio(List<int> audioData);

  Future<void> stopSession();

  bool supportsRealtime();

  bool supportsIndianVoice();
}
