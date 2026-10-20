// shared/services/firebase_service.dart
// Unified Firebase Architecture Service for ASTROAI OS v4.0.
// Handles Firebase Authentication (Apple Sign-In / Google One-Tap),
// Cloud Firestore user profiles, real-time natal charts, saved readings, and data synchronization.

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/firebase_options.dart';
import '../models/user_profile.dart';
import '../models/natal_matrix.dart';

class FirebaseService {
  FirebaseService._privateConstructor();
  static final FirebaseService instance = FirebaseService._privateConstructor();

  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  bool _isInitialized = false;

  // In-memory fallback cache when running in demo/offline mode
  UserProfile? _cachedProfile;
  final List<Map<String, dynamic>> _cachedReadings = [];

  bool get isInitialized => _isInitialized;
  User? get currentUser => _auth?.currentUser;
  String get activeUid => _auth?.currentUser?.uid ?? "quantum_seeker_001";

  /// Initialize Firebase with platform-specific options (Metal iOS / Vulkan Android)
  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      _isInitialized = true;
      debugPrint("✦ [FirebaseService] Successfully initialized on ${defaultTargetPlatform.name}");
    } catch (e) {
      debugPrint("✦ [FirebaseService] Notice: Initializing in offline/resilient mode: $e");
      _isInitialized = true;
    }
  }

  // ==========================================
  // AUTHENTICATION ENGINE
  // ==========================================

  /// Signs in anonymously or restores existing cryptographic vault session
  Future<UserCredential?> signInAnonymously() async {
    if (_auth == null) return null;
    try {
      return await _auth!.signInAnonymously();
    } catch (e) {
      debugPrint("✦ [FirebaseService] Auth anonymous error: $e");
      return null;
    }
  }

  /// Apple Sign-In handler (iOS 17+ Target)
  Future<UserCredential?> signInWithApple({required OAuthCredential credential}) async {
    if (_auth == null) return null;
    try {
      return await _auth!.signInWithCredential(credential);
    } catch (e) {
      debugPrint("✦ [FirebaseService] Apple Sign-In error: $e");
      return null;
    }
  }

  /// Google Credential Manager handler (Android Target)
  Future<UserCredential?> signInWithGoogle({required AuthCredential credential}) async {
    if (_auth == null) return null;
    try {
      return await _auth!.signInWithCredential(credential);
    } catch (e) {
      debugPrint("✦ [FirebaseService] Google Sign-In error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth?.signOut();
    _cachedProfile = null;
    _cachedReadings.clear();
  }

  // ==========================================
  // FIRESTORE: USER PROFILES & SETTINGS
  // ==========================================

  /// Saves or updates the Cosmic Seeker's core profile in Firestore
  Future<void> saveUserProfile(UserProfile profile) async {
    _cachedProfile = profile;
    if (_firestore == null) return;
    try {
      await _firestore!
          .collection('users')
          .doc(profile.uid.isNotEmpty ? profile.uid : activeUid)
          .set(profile.toMap(), SetOptions(merge: true));
      debugPrint("✦ [FirebaseService] User profile synchronized to Firestore: ${profile.uid}");
    } catch (e) {
      debugPrint("✦ [FirebaseService] Firestore save error: $e");
    }
  }

  /// Retrieves user profile by UID
  Future<UserProfile> getUserProfile(String uid) async {
    if (_firestore != null) {
      try {
        final doc = await _firestore!.collection('users').doc(uid).get();
        if (doc.exists && doc.data() != null) {
          final profile = UserProfile.fromMap(doc.data()!);
          _cachedProfile = profile;
          return profile;
        }
      } catch (e) {
        debugPrint("✦ [FirebaseService] Error reading user profile: $e");
      }
    }

    // Default Fallback Profile (Ramsundar Mahato sample matrix)
    return _cachedProfile ??
        UserProfile(
          uid: uid,
          name: "Ramsundar Mahato",
          email: "seeker@astroai.quantum",
          birthDate: DateTime(1996, 9, 14),
          birthTime: "06:42 AM",
          birthPlace: "Bengaluru, India",
          latitude: 12.9716,
          longitude: 77.5946,
          timezoneOffsetHours: 5.5,
          focusVectors: ["Career & Timing", "Wealth Cycles", "Mental Peace"],
          ayanamsa: "Chitra Paksha (Lahiri)",
          chartLayout: "North Indian Diamond",
          isPlusSubscriber: true,
        );
  }

  /// Updates focus vectors chosen in Screen 02
  Future<void> updateFocusVectors(String uid, List<String> vectors) async {
    if (_cachedProfile != null) {
      _cachedProfile = _cachedProfile!.copyWith(focusVectors: vectors);
    }
    if (_firestore == null) return;
    try {
      await _firestore!.collection('users').doc(uid).update({
        'focusVectors': vectors,
        'lastUpdated': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint("✦ [FirebaseService] Error updating focus vectors: $e");
    }
  }

  // ==========================================
  // FIRESTORE: NATAL MATRIX PERSISTENCE
  // ==========================================

  /// Stores calculated Vedic Natal Matrix (D1, D9, D10) in Firestore subcollection
  Future<void> saveNatalMatrix(String uid, NatalMatrix matrix) async {
    if (_firestore == null) return;
    try {
      final docRef = _firestore!.collection('users').doc(uid).collection('natal_matrix').doc('primary_rashi');
      await docRef.set({
        'seekerName': matrix.seekerName,
        'birthTimeUtc': matrix.birthTimeUtc.toIso8601String(),
        'lahiriAyanamsa': matrix.lahiriAyanamsa,
        'activeMahadasha': matrix.activeMahadasha,
        'activeAntardasha': matrix.activeAntardasha,
        'activePratyantardasha': matrix.activePratyantardasha,
        'planets': matrix.grahas.values.map((g) => {
          'id': g.id,
          'name': g.name,
          'sign': g.sign.name,
          'degree': g.degree,
          'degreeDms': g.degreeDms,
          'nakshatra': g.nakshatra,
          'pada': g.pada,
          'house': g.house,
          'isRetrograde': g.isRetrograde,
          'dignity': g.dignity.name,
        }).toList(),
      }, SetOptions(merge: true));
      debugPrint("✦ [FirebaseService] Natal Matrix saved to Firestore");
    } catch (e) {
      debugPrint("✦ [FirebaseService] Error saving Natal Matrix: $e");
    }
  }

  // ==========================================
  // FIRESTORE: SAVED READINGS & TELEMETRY
  // ==========================================

  /// Saves an insight or forecast to the user's readings archive (Screen 22)
  Future<void> saveReading(String uid, Map<String, dynamic> reading) async {
    _cachedReadings.add(reading);
    if (_firestore == null) return;
    try {
      await _firestore!
          .collection('users')
          .doc(uid)
          .collection('saved_readings')
          .add({
        ...reading,
        'savedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint("✦ [FirebaseService] Error saving reading: $e");
    }
  }

  /// Fetches saved readings from Firestore
  Future<List<Map<String, dynamic>>> getSavedReadings(String uid) async {
    if (_firestore != null) {
      try {
        final query = await _firestore!
            .collection('users')
            .doc(uid)
            .collection('saved_readings')
            .orderBy('savedAt', descending: true)
            .get();
        if (query.docs.isNotEmpty) {
          return query.docs.map((doc) => doc.data()).toList();
        }
      } catch (e) {
        debugPrint("✦ [FirebaseService] Error fetching readings: $e");
      }
    }
    return _cachedReadings;
  }

  /// Synchronizes notification preferences (Screen 23)
  Future<void> syncNotificationPreferences(String uid, Map<String, dynamic> prefs) async {
    if (_firestore == null) return;
    try {
      await _firestore!.collection('users').doc(uid).update({
        'notificationPreferences': prefs,
        'lastSynced': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint("✦ [FirebaseService] Error syncing notification preferences: $e");
    }
  }

  // ==========================================
  // PURGE / GDPR ACCOUNT ERASURE (Screen 26)
  // ==========================================

  /// Complete erasure of Firestore documents conforming to App Store Guideline 5.1.1(v) & Google Play policies
  Future<void> purgeUserVault(String uid) async {
    _cachedProfile = null;
    _cachedReadings.clear();
    if (_firestore != null) {
      try {
        // Purge subcollections
        final readings = await _firestore!.collection('users').doc(uid).collection('saved_readings').get();
        for (var doc in readings.docs) {
          await doc.reference.delete();
        }
        final matrices = await _firestore!.collection('users').doc(uid).collection('natal_matrix').get();
        for (var doc in matrices.docs) {
          await doc.reference.delete();
        }
        // Purge root document
        await _firestore!.collection('users').doc(uid).delete();
        debugPrint("✦ [FirebaseService] User $uid fully purged from Firestore");
      } catch (e) {
        debugPrint("✦ [FirebaseService] Error purging user: $e");
      }
    }
    // Delete Firebase Auth record
    try {
      await _auth?.currentUser?.delete();
    } catch (e) {
      debugPrint("✦ [FirebaseService] Error deleting auth user: $e");
    }
  }
}
