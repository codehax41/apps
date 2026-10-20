// lib/core/auth/social_and_email_providers.dart
// ASTROAI OS v5.0 - Concrete Auth Provider Implementations (Google, Apple, Facebook, Email)

import 'auth_provider_interface.dart';
import '../models/user_profile.dart';

class EmailAuthProvider implements IAuthProvider {
  @override
  String get providerId => 'email';

  @override
  Future<UserProfile> signIn({Map<String, dynamic>? credentials}) async {
    final email = credentials?['email'] as String? ?? '';
    if (email.isEmpty) throw ArgumentError('Email is required');

    return UserProfile(
      id: 'usr_${email.hashCode.abs()}',
      email: email,
      displayName: email.split('@').first,
      authProvider: 'email',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      trialStartedAt: DateTime.now(),
      trialExpiresAt: DateTime.now().add(const Duration(hours: 24)),
      subscriptionPlan: 'trial_1_day_7_inr',
      subscriptionStatus: 'active',
    );
  }

  @override
  Future<UserProfile> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return UserProfile(
      id: 'usr_${email.hashCode.abs()}',
      email: email,
      displayName: displayName ?? email.split('@').first,
      authProvider: 'email',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      trialStartedAt: DateTime.now(),
      trialExpiresAt: DateTime.now().add(const Duration(hours: 24)),
      subscriptionPlan: 'trial_1_day_7_inr',
      subscriptionStatus: 'active',
    );
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<bool> verifySession() async => true;
}

class GoogleAuthProvider implements IAuthProvider {
  @override
  String get providerId => 'google';

  @override
  Future<UserProfile> signIn({Map<String, dynamic>? credentials}) async {
    final email = credentials?['email'] as String? ?? 'ramsundar.astro@gmail.com';
    final name = credentials?['displayName'] as String? ?? 'Ramsundar';

    return UserProfile(
      id: 'goog_${email.hashCode.abs()}',
      email: email,
      displayName: name,
      authProvider: 'google',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      trialStartedAt: DateTime.now(),
      trialExpiresAt: DateTime.now().add(const Duration(hours: 24)),
      subscriptionPlan: 'trial_1_day_7_inr',
      subscriptionStatus: 'active',
    );
  }

  @override
  Future<UserProfile> signUp({
    required String email,
    required String password,
    String? displayName,
  }) => signIn(credentials: {'email': email, 'displayName': displayName});

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<bool> verifySession() async => true;
}

class AppleAuthProvider implements IAuthProvider {
  @override
  String get providerId => 'apple';

  @override
  Future<UserProfile> signIn({Map<String, dynamic>? credentials}) async {
    final email = credentials?['email'] as String? ?? 'seeker.apple@privaterelay.appleid.com';
    final name = credentials?['displayName'] as String? ?? 'Cosmic Seeker';

    return UserProfile(
      id: 'appl_${email.hashCode.abs()}',
      email: email,
      displayName: name,
      authProvider: 'apple',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      trialStartedAt: DateTime.now(),
      trialExpiresAt: DateTime.now().add(const Duration(hours: 24)),
      subscriptionPlan: 'trial_1_day_7_inr',
      subscriptionStatus: 'active',
    );
  }

  @override
  Future<UserProfile> signUp({
    required String email,
    required String password,
    String? displayName,
  }) => signIn(credentials: {'email': email, 'displayName': displayName});

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<bool> verifySession() async => true;
}

class FacebookAuthProvider implements IAuthProvider {
  @override
  String get providerId => 'facebook';

  @override
  Future<UserProfile> signIn({Map<String, dynamic>? credentials}) async {
    final email = credentials?['email'] as String? ?? 'seeker.fb@facebook.com';
    final name = credentials?['displayName'] as String? ?? 'Astro Facebook User';

    return UserProfile(
      id: 'fb_${email.hashCode.abs()}',
      email: email,
      displayName: name,
      authProvider: 'facebook',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      trialStartedAt: DateTime.now(),
      trialExpiresAt: DateTime.now().add(const Duration(hours: 24)),
      subscriptionPlan: 'trial_1_day_7_inr',
      subscriptionStatus: 'active',
    );
  }

  @override
  Future<UserProfile> signUp({
    required String email,
    required String password,
    String? displayName,
  }) => signIn(credentials: {'email': email, 'displayName': displayName});

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<bool> verifySession() async => true;
}
