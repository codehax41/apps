// lib/core/localization/language_option.dart
// ASTROAI OS v5.0 - Multi-Language Registry Option Model

class LanguageOption {
  final String id;
  final String displayName;
  final String nativeName;
  final String locale;
  final String speechLocale;
  final bool enabled;
  final bool isRtl;
  final bool supportsText;
  final bool supportsSpeechInput;
  final bool supportsSpeechOutput;
  final bool supportsRealtime;
  final bool supportsIndianVoice;
  final String defaultVoiceName;
  final String sampleGreeting;

  const LanguageOption({
    required this.id,
    required this.displayName,
    required this.nativeName,
    required this.locale,
    required this.speechLocale,
    this.enabled = true,
    this.isRtl = false,
    this.supportsText = true,
    this.supportsSpeechInput = true,
    this.supportsSpeechOutput = true,
    this.supportsRealtime = true,
    this.supportsIndianVoice = false,
    this.defaultVoiceName = "alloy",
    this.sampleGreeting = "Namaste",
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'displayName': displayName,
    'nativeName': nativeName,
    'locale': locale,
    'speechLocale': speechLocale,
    'enabled': enabled,
    'isRtl': isRtl,
    'supportsText': supportsText,
    'supportsSpeechInput': supportsSpeechInput,
    'supportsSpeechOutput': supportsSpeechOutput,
    'supportsRealtime': supportsRealtime,
    'supportsIndianVoice': supportsIndianVoice,
    'defaultVoiceName': defaultVoiceName,
    'sampleGreeting': sampleGreeting,
  };

  factory LanguageOption.fromJson(Map<String, dynamic> json) => LanguageOption(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    nativeName: json['nativeName'] as String,
    locale: json['locale'] as String,
    speechLocale: json['speechLocale'] as String,
    enabled: json['enabled'] as bool? ?? true,
    isRtl: json['isRtl'] as bool? ?? false,
    supportsText: json['supportsText'] as bool? ?? true,
    supportsSpeechInput: json['supportsSpeechInput'] as bool? ?? true,
    supportsSpeechOutput: json['supportsSpeechOutput'] as bool? ?? true,
    supportsRealtime: json['supportsRealtime'] as bool? ?? true,
    supportsIndianVoice: json['supportsIndianVoice'] as bool? ?? false,
    defaultVoiceName: json['defaultVoiceName'] as String? ?? "alloy",
    sampleGreeting: json['sampleGreeting'] as String? ?? "Namaste",
  );
}
