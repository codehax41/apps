// lib/core/localization/language_manager.dart
// ASTROAI OS v5.0 - Dynamic Multi-Language State & Persistence Manager

import 'package:flutter/material.dart';
import 'language_option.dart';
import 'language_registry.dart';

class LanguageManager extends ChangeNotifier {
  static final LanguageManager instance = LanguageManager._internal();
  LanguageManager._internal();

  LanguageOption _currentLanguage = LanguageRegistry.defaultLanguage;
  String _preferredVoice = "alloy";
  String _voiceProvider = "openai";

  LanguageOption get currentLanguage => _currentLanguage;
  String get preferredVoice => _preferredVoice;
  String get voiceProvider => _voiceProvider;

  // Initialize from local cache or fallback
  Future<void> init() async {
    // In production, reads from encrypted secure storage or local cache
    // Defaulting to English with full Hindi/Indic capability
    _currentLanguage = LanguageRegistry.defaultLanguage;
    _preferredVoice = _currentLanguage.defaultVoiceName;
    _voiceProvider = _currentLanguage.supportsIndianVoice ? "sarvam" : "openai";
    notifyListeners();
  }

  // Updates language across the entire application runtime seamlessly
  Future<void> setLanguage(LanguageOption lang) async {
    if (_currentLanguage.id == lang.id) return;
    _currentLanguage = lang;
    _preferredVoice = lang.defaultVoiceName;
    _voiceProvider = lang.supportsIndianVoice ? "sarvam" : "openai";
    notifyListeners();
  }

  void setCustomVoice(String voiceName, String provider) {
    _preferredVoice = voiceName;
    _voiceProvider = provider;
    notifyListeners();
  }
}
