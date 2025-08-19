import 'package:equatable/equatable.dart';

enum ReferralStatus {
  pending,
  accepted,
  completed,
  rejected,
  expired,
}

enum ReferralType {
  business,
  user,
  service,
}

class ReferralEntity extends Equatable {
  final String id;
  final String referrerId; // User who made the referral
  final String refereeId; // User who was referred
  final String businessId; // Business being referred
  final ReferralType type;
  final ReferralStatus status;
  final String? message;
  final String? notes;
  final int pointsAwarded;
  final int pointsPending;
  final bool isRewardClaimed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final DateTime? expiresAt;

  const ReferralEntity({
    required this.id,
    required this.referrerId,
    required this.refereeId,
    required this.businessId,
    this.type = ReferralType.business,
    this.status = ReferralStatus.pending,
    this.message,
    this.notes,
    this.pointsAwarded = 0,
    this.pointsPending = 0,
    this.isRewardClaimed = false,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [
        id,
        referrerId,
        refereeId,
        businessId,
        type,
        status,
        message,
        notes,
        pointsAwarded,
        pointsPending,
        isRewardClaimed,
        createdAt,
        updatedAt,
        completedAt,
        expiresAt,
      ];

  /// Get status display text
  String get statusText {
    switch (status) {
      case ReferralStatus.pending:
        return 'Pending';
      case ReferralStatus.accepted:
        return 'Accepted';
      case ReferralStatus.completed:
        return 'Completed';
      case ReferralStatus.rejected:
        return 'Rejected';
      case ReferralStatus.expired:
        return 'Expired';
    }
  }

  /// Get type display text
  String get typeText {
    switch (type) {
      case ReferralType.business:
        return 'Business Referral';
      case ReferralType.user:
        return 'User Referral';
      case ReferralType.service:
        return 'Service Referral';
    }
  }

  /// Get status color based on status
  String get statusColor {
    switch (status) {
      case ReferralStatus.pending:
        return 'warning'; // Orange/Yellow
      case ReferralStatus.accepted:
        return 'info'; // Blue
      case ReferralStatus.completed:
        return 'success'; // Green
      case ReferralStatus.rejected:
        return 'error'; // Red
      case ReferralStatus.expired:
        return 'disabled'; // Grey
    }
  }

  /// Check if referral is active (can still be acted upon)
  bool get isActive {
    return status == ReferralStatus.pending || status == ReferralStatus.accepted;
  }

  /// Check if referral is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!) || status == ReferralStatus.expired;
  }

  /// Check if referral is completed
  bool get isCompleted {
    return status == ReferralStatus.completed;
  }

  /// Check if referral can be completed
  bool get canComplete {
    return status == ReferralStatus.accepted && !isExpired;
  }

  /// Check if referral can be accepted
  bool get canAccept {
    return status == ReferralStatus.pending && !isExpired;
  }

  /// Check if referral can be rejected
  bool get canReject {
    return status == ReferralStatus.pending && !isExpired;
  }

  /// Get total points (awarded + pending)
  int get totalPoints {
    return pointsAwarded + pointsPending;
  }

  /// Get points status text
  String get pointsStatus {
    if (pointsAwarded > 0 && pointsPending > 0) {
      return '$pointsAwarded awarded, $pointsPending pending';
    } else if (pointsAwarded > 0) {
      return '$pointsAwarded points awarded';
    } else if (pointsPending > 0) {
      return '$pointsPending points pending';
    }
    return 'No points awarded';
  }

  /// Get days until expiration
  int? get daysUntilExpiry {
    if (expiresAt == null) return null;
    final diff = expiresAt!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  /// Get formatted expiry text
  String get expiryText {
    if (expiresAt == null) return 'No expiry';
    if (isExpired) return 'Expired';
    
    final days = daysUntilExpiry;
    if (days == null) return 'No expiry';
    if (days == 0) return 'Expires today';
    if (days == 1) return 'Expires tomorrow';
    return 'Expires in $days days';
  }

  /// Get time since creation
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Copy with method
  ReferralEntity copyWith({
    String? id,
    String? referrerId,
    String? refereeId,
    String? businessId,
    ReferralType? type,
    ReferralStatus? status,
    String? message,
    String? notes,
    int? pointsAwarded,
    int? pointsPending,
    bool? isRewardClaimed,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? expiresAt,
  }) {
    return ReferralEntity(
      id: id ?? this.id,
      referrerId: referrerId ?? this.referrerId,
      refereeId: refereeId ?? this.refereeId,
      businessId: businessId ?? this.businessId,
      type: type ?? this.type,
      status: status ?? this.status,
      message: message ?? this.message,
      notes: notes ?? this.notes,
      pointsAwarded: pointsAwarded ?? this.pointsAwarded,
      pointsPending: pointsPending ?? this.pointsPending,
      isRewardClaimed: isRewardClaimed ?? this.isRewardClaimed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  /// Convert to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'referrer_id': referrerId,
      'referee_id': refereeId,
      'business_id': businessId,
      'type': type.name,
      'status': status.name,
      'message': message,
      'notes': notes,
      'points_awarded': pointsAwarded,
      'points_pending': pointsPending,
      'is_reward_claimed': isRewardClaimed,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
    };
  }

  /// Create from map
  factory ReferralEntity.fromMap(Map<String, dynamic> map) {
    return ReferralEntity(
      id: map['id'] ?? '',
      referrerId: map['referrer_id'] ?? '',
      refereeId: map['referee_id'] ?? '',
      businessId: map['business_id'] ?? '',
      type: _parseReferralType(map['type']),
      status: _parseReferralStatus(map['status']),
      message: map['message'],
      notes: map['notes'],
      pointsAwarded: map['points_awarded'] ?? 0,
      pointsPending: map['points_pending'] ?? 0,
      isRewardClaimed: map['is_reward_claimed'] ?? false,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
      completedAt: map['completed_at'] != null 
          ? DateTime.tryParse(map['completed_at']) 
          : null,
      expiresAt: map['expires_at'] != null 
          ? DateTime.tryParse(map['expires_at']) 
          : null,
    );
  }

  // Helper methods for parsing enums
  static ReferralType _parseReferralType(dynamic type) {
    if (type == null) return ReferralType.business;
    
    switch (type.toString().toLowerCase()) {
      case 'business':
        return ReferralType.business;
      case 'user':
        return ReferralType.user;
      case 'service':
        return ReferralType.service;
      default:
        return ReferralType.business;
    }
  }

  static ReferralStatus _parseReferralStatus(dynamic status) {
    if (status == null) return ReferralStatus.pending;
    
    switch (status.toString().toLowerCase()) {
      case 'pending':
        return ReferralStatus.pending;
      case 'accepted':
        return ReferralStatus.accepted;
      case 'completed':
        return ReferralStatus.completed;
      case 'rejected':
        return ReferralStatus.rejected;
      case 'expired':
        return ReferralStatus.expired;
      default:
        return ReferralStatus.pending;
    }
  }

  @override
  String toString() {
    return 'ReferralEntity(id: $id, type: $typeText, status: $statusText, points: $totalPoints)';
  }
}