// lib/core/ai/voice_routing_engine.dart
// ASTROAI OS v5.0 - Dynamic Multi-Provider Voice Routing Engine

import 'voice_provider_interface.dart';
import 'openai_and_sarvam_providers.dart';
import '../config/app_config.dart';

class VoiceRoutingEngine {
  static final VoiceRoutingEngine instance = VoiceRoutingEngine._internal();
  VoiceRoutingEngine._internal() {
    _providers = {
      'openai': OpenAIRealtimeVoiceProvider(),
      'sarvam': SarvamVoiceProvider(),
    };
  }

  late final Map<String, IVoiceProvider> _providers;

  // Resolves the optimal voice provider based on target locale and feature flags
  IVoiceProvider resolveProvider({
    required String locale,
    bool forceIndianVoice = false,
  }) {
    final bool isIndic = locale.endsWith('-IN') ||
                         ['hi', 'bn', 'ta', 'te', 'mr', 'gu', 'kn', 'ml'].contains(locale.split('-').first);

    // If Indian language requested and Sarvam is enabled in config: route to Sarvam
    if ((isIndic || forceIndianVoice) && AppConfig.sarvamEnabled) {
      return _providers['sarvam'] ?? _providers['openai']!;
    }

    // Default primary provider
    const primaryId = AppConfig.primaryVoiceProvider;
    return _providers[primaryId] ?? _providers['openai']!;
  }
}
