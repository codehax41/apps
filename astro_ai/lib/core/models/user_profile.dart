// lib/core/models/user_profile.dart
// ASTROAI OS v5.0 - Enterprise User Profile & Entitlement Model

class UserProfile {
  final String id;
  final String email;
  final String displayName;
  final String? photoURL;
  final String authProvider; // 'google', 'apple', 'facebook', 'email'

  final String preferredLanguage;
  final String preferredLocale;
  final String preferredSpeechLocale;
  final String preferredVoice;
  final String voiceProvider; // 'openai', 'sarvam'

  final DateTime? dateOfBirth;
  final String? timeOfBirth;
  final String? birthPlace;
  final double? birthLatitude;
  final double? birthLongitude;
  final String? birthTimezone;

  final bool onboardingCompleted;

  final String subscriptionPlan; // 'free', 'trial_1_day_7_inr', 'monthly_pro', 'yearly_vip'
  final String subscriptionStatus; // 'active', 'expired', 'canceled', 'none'
  final DateTime? trialStartedAt;
  final DateTime? trialExpiresAt;

  final int voiceSecondsAllowed; // 1800 seconds (30 minutes) for 1-Day ₹7 Pass
  final int voiceSecondsUsed;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final DateTime? deletedAt;

  const UserProfile({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoURL,
    this.authProvider = 'email',
    this.preferredLanguage = 'en',
    this.preferredLocale = 'en-US',
    this.preferredSpeechLocale = 'en-US',
    this.preferredVoice = 'alloy',
    this.voiceProvider = 'openai',
    this.dateOfBirth,
    this.timeOfBirth,
    this.birthPlace,
    this.birthLatitude,
    this.birthLongitude,
    this.birthTimezone,
    this.onboardingCompleted = false,
    this.subscriptionPlan = 'trial_1_day_7_inr',
    this.subscriptionStatus = 'active',
    this.trialStartedAt,
    this.trialExpiresAt,
    this.voiceSecondsAllowed = 1800,
    this.voiceSecondsUsed = 0,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.deletedAt,
  });

  bool get isTrialActive {
    if (subscriptionPlan != 'trial_1_day_7_inr' || subscriptionStatus != 'active') {
      return false;
    }
    if (trialExpiresAt == null) return false;
    return DateTime.now().isBefore(trialExpiresAt!);
  }

  int get remainingVoiceSeconds {
    final remaining = voiceSecondsAllowed - voiceSecondsUsed;
    return remaining > 0 ? remaining : 0;
  }

  String get formattedRemainingVoiceTime {
    final int totalSec = remainingVoiceSeconds;
    final int minutes = totalSec ~/ 60;
    final int seconds = totalSec % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    String? authProvider,
    String? preferredLanguage,
    String? preferredLocale,
    String? preferredSpeechLocale,
    String? preferredVoice,
    String? voiceProvider,
    DateTime? dateOfBirth,
    String? timeOfBirth,
    String? birthPlace,
    double? birthLatitude,
    double? birthLongitude,
    String? birthTimezone,
    bool? onboardingCompleted,
    String? subscriptionPlan,
    String? subscriptionStatus,
    DateTime? trialStartedAt,
    DateTime? trialExpiresAt,
    int? voiceSecondsAllowed,
    int? voiceSecondsUsed,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    DateTime? deletedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      authProvider: authProvider ?? this.authProvider,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      preferredLocale: preferredLocale ?? this.preferredLocale,
      preferredSpeechLocale: preferredSpeechLocale ?? this.preferredSpeechLocale,
      preferredVoice: preferredVoice ?? this.preferredVoice,
      voiceProvider: voiceProvider ?? this.voiceProvider,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      timeOfBirth: timeOfBirth ?? this.timeOfBirth,
      birthPlace: birthPlace ?? this.birthPlace,
      birthLatitude: birthLatitude ?? this.birthLatitude,
      birthLongitude: birthLongitude ?? this.birthLongitude,
      birthTimezone: birthTimezone ?? this.birthTimezone,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      trialStartedAt: trialStartedAt ?? this.trialStartedAt,
      trialExpiresAt: trialExpiresAt ?? this.trialExpiresAt,
      voiceSecondsAllowed: voiceSecondsAllowed ?? this.voiceSecondsAllowed,
      voiceSecondsUsed: voiceSecondsUsed ?? this.voiceSecondsUsed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'displayName': displayName,
    'photoURL': photoURL,
    'authProvider': authProvider,
    'preferredLanguage': preferredLanguage,
    'preferredLocale': preferredLocale,
    'preferredSpeechLocale': preferredSpeechLocale,
    'preferredVoice': preferredVoice,
    'voiceProvider': voiceProvider,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'timeOfBirth': timeOfBirth,
    'birthPlace': birthPlace,
    'birthLatitude': birthLatitude,
    'birthLongitude': birthLongitude,
    'birthTimezone': birthTimezone,
    'onboardingCompleted': onboardingCompleted,
    'subscriptionPlan': subscriptionPlan,
    'subscriptionStatus': subscriptionStatus,
    'trialStartedAt': trialStartedAt?.toIso8601String(),
    'trialExpiresAt': trialExpiresAt?.toIso8601String(),
    'voiceSecondsAllowed': voiceSecondsAllowed,
    'voiceSecondsUsed': voiceSecondsUsed,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'lastLoginAt': lastLoginAt?.toIso8601String(),
    'deletedAt': deletedAt?.toIso8601String(),
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json['id'] as String,
    email: json['email'] as String,
    displayName: json['displayName'] as String? ?? 'Astro Seeker',
    photoURL: json['photoURL'] as String?,
    authProvider: json['authProvider'] as String? ?? 'email',
    preferredLanguage: json['preferredLanguage'] as String? ?? 'en',
    preferredLocale: json['preferredLocale'] as String? ?? 'en-US',
    preferredSpeechLocale: json['preferredSpeechLocale'] as String? ?? 'en-US',
    preferredVoice: json['preferredVoice'] as String? ?? 'alloy',
    voiceProvider: json['voiceProvider'] as String? ?? 'openai',
    dateOfBirth: json['dateOfBirth'] != null ? DateTime.tryParse(json['dateOfBirth']) : null,
    timeOfBirth: json['timeOfBirth'] as String?,
    birthPlace: json['birthPlace'] as String?,
    birthLatitude: (json['birthLatitude'] as num?)?.toDouble(),
    birthLongitude: (json['birthLongitude'] as num?)?.toDouble(),
    birthTimezone: json['birthTimezone'] as String?,
    onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
    subscriptionPlan: json['subscriptionPlan'] as String? ?? 'trial_1_day_7_inr',
    subscriptionStatus: json['subscriptionStatus'] as String? ?? 'active',
    trialStartedAt: json['trialStartedAt'] != null ? DateTime.tryParse(json['trialStartedAt']) : null,
    trialExpiresAt: json['trialExpiresAt'] != null ? DateTime.tryParse(json['trialExpiresAt']) : null,
    voiceSecondsAllowed: json['voiceSecondsAllowed'] as int? ?? 1800,
    voiceSecondsUsed: json['voiceSecondsUsed'] as int? ?? 0,
    createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    lastLoginAt: json['lastLoginAt'] != null ? DateTime.tryParse(json['lastLoginAt']) : null,
    deletedAt: json['deletedAt'] != null ? DateTime.tryParse(json['deletedAt']) : null,
  );
}
