// shared/models/user_profile.dart
// Unified data contract for Cosmic Seeker identity, birth coordinates,
// Focus Vectors, and Ayanamsa calibration across Firebase & Cloudflare.

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final DateTime birthDate;
  final String birthTime;
  final String birthPlace;
  final double latitude;
  final double longitude;
  final double timezoneOffsetHours;
  final List<String> focusVectors;
  final String ayanamsa;
  final String chartLayout;
  final bool isPlusSubscriber;
  final DateTime createdAt;
  final DateTime lastUpdated;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.birthTime,
    required this.birthPlace,
    required this.latitude,
    required this.longitude,
    required this.timezoneOffsetHours,
    required this.focusVectors,
    this.ayanamsa = "Chitra Paksha (Lahiri)",
    this.chartLayout = "North Indian Diamond",
    this.isPlusSubscriber = false,
    DateTime? createdAt,
    DateTime? lastUpdated,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastUpdated = lastUpdated ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'birthTime': birthTime,
      'birthPlace': birthPlace,
      'latitude': latitude,
      'longitude': longitude,
      'timezoneOffsetHours': timezoneOffsetHours,
      'focusVectors': focusVectors,
      'ayanamsa': ayanamsa,
      'chartLayout': chartLayout,
      'isPlusSubscriber': isPlusSubscriber,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] as String? ?? '',
      name: map['name'] as String? ?? 'Cosmic Seeker',
      email: map['email'] as String? ?? '',
      birthDate: map['birthDate'] != null
          ? DateTime.parse(map['birthDate'] as String)
          : DateTime(1996, 9, 14),
      birthTime: map['birthTime'] as String? ?? '06:42 AM',
      birthPlace: map['birthPlace'] as String? ?? 'Bengaluru, India',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 12.9716,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 77.5946,
      timezoneOffsetHours: (map['timezoneOffsetHours'] as num?)?.toDouble() ?? 5.5,
      focusVectors: (map['focusVectors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          ['career', 'wealth', 'mental_peace'],
      ayanamsa: map['ayanamsa'] as String? ?? 'Chitra Paksha (Lahiri)',
      chartLayout: map['chartLayout'] as String? ?? 'North Indian Diamond',
      isPlusSubscriber: map['isPlusSubscriber'] as bool? ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'] as String)
          : null,
    );
  }

  UserProfile copyWith({
    String? name,
    String? email,
    DateTime? birthDate,
    String? birthTime,
    String? birthPlace,
    double? latitude,
    double? longitude,
    double? timezoneOffsetHours,
    List<String>? focusVectors,
    String? ayanamsa,
    String? chartLayout,
    bool? isPlusSubscriber,
  }) {
    return UserProfile(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      birthPlace: birthPlace ?? this.birthPlace,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timezoneOffsetHours: timezoneOffsetHours ?? this.timezoneOffsetHours,
      focusVectors: focusVectors ?? this.focusVectors,
      ayanamsa: ayanamsa ?? this.ayanamsa,
      chartLayout: chartLayout ?? this.chartLayout,
      isPlusSubscriber: isPlusSubscriber ?? this.isPlusSubscriber,
      createdAt: createdAt,
      lastUpdated: DateTime.now(),
    );
  }
}
