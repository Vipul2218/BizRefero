import 'package:equatable/equatable.dart';
import 'notification_preferences_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String phone;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? profileImageUrl;
  final NotificationPreferencesEntity notificationPreferences;
  final String referralCode;
  final int totalReferrals;
  final int referralPoints;
  final bool isVerified;
  final bool isPremium;
  final int profileCompletionPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastActivityAt;

  const UserEntity({
    required this.id,
    required this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.displayName,
    this.profileImageUrl,
    this.notificationPreferences = const NotificationPreferencesEntity(),
    required this.referralCode,
    this.totalReferrals = 0,
    this.referralPoints = 0,
    this.isVerified = false,
    this.isPremium = false,
    this.profileCompletionPercentage = 0,
    required this.createdAt,
    required this.updatedAt,
    required this.lastActivityAt,
  });

  @override
  List<Object?> get props => [
        id,
        phone,
        email,
        firstName,
        lastName,
        displayName,
        profileImageUrl,
        notificationPreferences,
        referralCode,
        totalReferrals,
        referralPoints,
        isVerified,
        isPremium,
        profileCompletionPercentage,
        createdAt,
        updatedAt,
        lastActivityAt,
      ];

  /// Get full name
  String get fullName {
    final first = firstName?.trim() ?? '';
    final last = lastName?.trim() ?? '';
    if (first.isEmpty && last.isEmpty) return '';
    return '$first $last'.trim();
  }

  /// Get display name or full name
  String get name {
    if (displayName?.isNotEmpty == true) return displayName!;
    if (fullName.isNotEmpty) return fullName;
    return phone;
  }

  /// Get initials for avatar
  String get initials {
    if (firstName?.isNotEmpty == true && lastName?.isNotEmpty == true) {
      return '${firstName![0].toUpperCase()}${lastName![0].toUpperCase()}';
    }
    if (displayName?.isNotEmpty == true) {
      final parts = displayName!.trim().split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0].toUpperCase()}${parts[1][0].toUpperCase()}';
      }
      return displayName![0].toUpperCase();
    }
    return phone.isNotEmpty ? phone[0] : 'U';
  }

  /// Check if profile is complete
  bool get isProfileComplete => profileCompletionPercentage >= 100;

  /// Get user status text
  String get statusText {
    if (!isVerified) return 'Unverified';
    if (isPremium) return 'Premium';
    return 'Active';
  }

  /// Get referral tier based on points
  String get referralTier {
    if (referralPoints >= 5000) return 'Diamond';
    if (referralPoints >= 2000) return 'Platinum';
    if (referralPoints >= 1000) return 'Gold';
    if (referralPoints >= 500) return 'Silver';
    return 'Bronze';
  }

  /// Copy with method
  UserEntity copyWith({
    String? id,
    String? phone,
    String? email,
    String? firstName,
    String? lastName,
    String? displayName,
    String? profileImageUrl,
    NotificationPreferencesEntity? notificationPreferences,
    String? referralCode,
    int? totalReferrals,
    int? referralPoints,
    bool? isVerified,
    bool? isPremium,
    int? profileCompletionPercentage,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActivityAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      notificationPreferences: notificationPreferences ?? this.notificationPreferences,
      referralCode: referralCode ?? this.referralCode,
      totalReferrals: totalReferrals ?? this.totalReferrals,
      referralPoints: referralPoints ?? this.referralPoints,
      isVerified: isVerified ?? this.isVerified,
      isPremium: isPremium ?? this.isPremium,
      profileCompletionPercentage: profileCompletionPercentage ?? this.profileCompletionPercentage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
    );
  }

  /// Convert to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'display_name': displayName,
      'profile_image_url': profileImageUrl,
      'notification_preferences': notificationPreferences.toMap(),
      'referral_code': referralCode,
      'total_referrals': totalReferrals,
      'referral_points': referralPoints,
      'is_verified': isVerified,
      'is_premium': isPremium,
      'profile_completion_percentage': profileCompletionPercentage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'last_activity_at': lastActivityAt.toIso8601String(),
    };
  }

  /// Create from map
  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      displayName: map['display_name'],
      profileImageUrl: map['profile_image_url'],
      notificationPreferences: map['notification_preferences'] != null
          ? NotificationPreferencesEntity.fromMap(map['notification_preferences'])
          : const NotificationPreferencesEntity(),
      referralCode: map['referral_code'] ?? '',
      totalReferrals: map['total_referrals'] ?? 0,
      referralPoints: map['referral_points'] ?? 0,
      isVerified: map['is_verified'] ?? false,
      isPremium: map['is_premium'] ?? false,
      profileCompletionPercentage: map['profile_completion_percentage'] ?? 0,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
      lastActivityAt: DateTime.tryParse(map['last_activity_at'] ?? '') ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, phone: $phone, email: $email, referralCode: $referralCode, points: $referralPoints)';
  }
}