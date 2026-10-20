// lib/core/auth/auth_service.dart
// ASTROAI OS v5.0 - Master Authentication Orchestrator & Account Linking Engine

import 'package:flutter/material.dart';
import 'auth_provider_interface.dart';
import 'social_and_email_providers.dart';
import '../models/user_profile.dart';
import '../services/privacy_service.dart';

class AuthService extends ChangeNotifier {
  static final AuthService instance = AuthService._internal();
  AuthService._internal() {
    _providers = {
      'email': EmailAuthProvider(),
      'google': GoogleAuthProvider(),
      'apple': AppleAuthProvider(),
      'facebook': FacebookAuthProvider(),
    };
  }

  late final Map<String, IAuthProvider> _providers;
  UserProfile? _currentUser;
  bool _isLoading = false;

  UserProfile? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    // In dev / initial launch, instantiate active user session
    _currentUser = UserProfile(
      id: 'usr_astro_master_88',
      email: 'ramsundar.astro@gmail.com',
      displayName: 'Ramsundar',
      authProvider: 'google',
      preferredLanguage: 'en',
      preferredLocale: 'en-US',
      preferredSpeechLocale: 'en-US',
      preferredVoice: 'alloy',
      voiceProvider: 'openai',
      dateOfBirth: DateTime(1998, 10, 20),
      timeOfBirth: '14:28:00',
      birthPlace: 'Bengaluru, India',
      birthLatitude: 12.9716,
      birthLongitude: 77.5946,
      birthTimezone: 'Asia/Kolkata',
      subscriptionPlan: 'trial_1_day_7_inr',
      subscriptionStatus: 'active',
      trialStartedAt: DateTime.now().subtract(const Duration(hours: 3)),
      trialExpiresAt: DateTime.now().add(const Duration(hours: 21)),
      voiceSecondsAllowed: 1800,
      voiceSecondsUsed: 140, // 2:20 used
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );
    notifyListeners();
  }

  Future<UserProfile> signInWithProvider(String providerId, {Map<String, dynamic>? credentials}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final provider = _providers[providerId];
      if (provider == null) throw UnsupportedError('Unsupported provider: $providerId');
      final user = await provider.signIn(credentials: credentials);
      _currentUser = user;
      return user;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _currentUser = null;
    notifyListeners();
  }

  // Complete, permanent profile deletion
  Future<void> deleteEntireProfile() async {
    if (_currentUser == null) return;
    _isLoading = true;
    notifyListeners();
    try {
      await PrivacyService.instance.executeCompleteProfilePurge(_currentUser!.id);
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateUserProfile(UserProfile updated) {
    _currentUser = updated;
    notifyListeners();
  }
}
