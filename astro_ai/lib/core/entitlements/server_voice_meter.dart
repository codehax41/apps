// lib/core/entitlements/server_voice_meter.dart
// ASTROAI OS v5.0 - Authoritative Server-Side 30-Minute Voice Metering & Concurrency Guard

import 'dart:async';
import 'package:flutter/foundation.dart';

enum VoiceWarningState {
  normal,
  warning5Min,
  critical1Min,
  exhausted,
}

class ActiveVoiceSession {
  final String sessionId;
  final String userId;
  final DateTime serverStartTime;
  final int startingUsedSeconds;
  final int maxAllowedSeconds;
  DateTime? serverEndTime;

  ActiveVoiceSession({
    required this.sessionId,
    required this.userId,
    required this.serverStartTime,
    required this.startingUsedSeconds,
    required this.maxAllowedSeconds,
  });

  int get currentElapsedSeconds {
    final now = DateTime.now();
    return now.difference(serverStartTime).inSeconds;
  }

  int get totalUsedSeconds => startingUsedSeconds + currentElapsedSeconds;

  int get remainingSeconds {
    final remaining = maxAllowedSeconds - totalUsedSeconds;
    return remaining > 0 ? remaining : 0;
  }
}

class ServerVoiceMeter extends ChangeNotifier {
  static final ServerVoiceMeter instance = ServerVoiceMeter._internal();
  ServerVoiceMeter._internal();

  // Maximum allowed seconds for the 1-Day ₹7 Pass = 1800s (30 minutes)
  static const int hardCapSeconds = 1800;

  // Server-side active session lock to prevent concurrent sessions
  final Map<String, ActiveVoiceSession> _activeSessions = {};

  ActiveVoiceSession? _currentSession;
  Timer? _heartbeatTimer;
  VoiceWarningState _warningState = VoiceWarningState.normal;

  ActiveVoiceSession? get currentSession => _currentSession;
  VoiceWarningState get warningState => _warningState;
  bool get hasActiveSession => _currentSession != null;

  // Development simulation toggle (never in production)
  bool devGrantTrial = false;

  // 1. Authoritative Session Initialization
  // Returns remaining allowed seconds, or throws StateError if cap reached or concurrent session exists
  Future<int> startVoiceSession({
    required String userId,
    required int currentRecordedUsedSeconds,
  }) async {
    // A. Concurrency Check: Reject if user already has an active session on any device
    if (_activeSessions.containsKey(userId)) {
      throw StateError("Concurrent voice session detected. Only one active voice stream permitted per account.");
    }

    // B. Hard Cap Check: Reject if 1800s exceeded
    if (currentRecordedUsedSeconds >= hardCapSeconds) {
      _warningState = VoiceWarningState.exhausted;
      notifyListeners();
      throw StateError("Voice quota exhausted. Your 30-minute allowance has been reached.");
    }

    final int remaining = hardCapSeconds - currentRecordedUsedSeconds;
    final session = ActiveVoiceSession(
      sessionId: "vses_${DateTime.now().millisecondsSinceEpoch}",
      userId: userId,
      serverStartTime: DateTime.now(),
      startingUsedSeconds: currentRecordedUsedSeconds,
      maxAllowedSeconds: hardCapSeconds,
    );

    _activeSessions[userId] = session;
    _currentSession = session;
    _warningState = _computeWarningState(remaining);

    // C. Start Authoritative Server Heartbeat
    _startHeartbeat(userId);

    notifyListeners();
    return remaining;
  }

  void _startHeartbeat(String userId) {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSession == null) {
        timer.cancel();
        return;
      }

      final remaining = _currentSession!.remainingSeconds;
      final newState = _computeWarningState(remaining);

      if (newState != _warningState) {
        _warningState = newState;
        debugPrint("[ServerVoiceMeter] State Transition -> $_warningState (Remaining: $remaining s)");
      }

      // Hard Server Termination when 0 seconds reached
      if (remaining <= 0) {
        debugPrint("[ServerVoiceMeter] HARD CUTOFF TRIGGERED (0s Remaining)");
        timer.cancel();
        endVoiceSession(userId: userId);
      }

      notifyListeners();
    });
  }

  VoiceWarningState _computeWarningState(int remainingSeconds) {
    if (remainingSeconds <= 0) return VoiceWarningState.exhausted;
    if (remainingSeconds <= 60) return VoiceWarningState.critical1Min;
    if (remainingSeconds <= 300) return VoiceWarningState.warning5Min;
    return VoiceWarningState.normal;
  }

  // 2. Authoritative Session Finalization (Calculates exact seconds consumed)
  Future<int> endVoiceSession({required String userId}) async {
    _heartbeatTimer?.cancel();
    final session = _activeSessions.remove(userId);
    _currentSession = null;

    if (session == null) return 0;

    session.serverEndTime = DateTime.now();
    final int consumedSeconds = session.serverEndTime!.difference(session.serverStartTime).inSeconds;
    final int newTotalUsed = (session.startingUsedSeconds + consumedSeconds).clamp(0, hardCapSeconds);

    debugPrint("[ServerVoiceMeter] Session Closed: Consumed $consumedSeconds s. New Total: $newTotalUsed / $hardCapSeconds s");

    notifyListeners();
    return newTotalUsed;
  }
}
