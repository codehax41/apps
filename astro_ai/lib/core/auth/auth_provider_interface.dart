// lib/core/auth/auth_provider_interface.dart
// ASTROAI OS v5.0 - Abstract Authentication Provider Interface

import '../models/user_profile.dart';

abstract class IAuthProvider {
  String get providerId; // 'google', 'apple', 'facebook', 'email'

  Future<UserProfile> signIn({Map<String, dynamic>? credentials});

  Future<UserProfile> signUp({
    required String email,
    required String password,
    String? displayName,
  });

  Future<void> signOut();

  Future<void> sendPasswordResetEmail(String email);

  Future<bool> verifySession();
}
