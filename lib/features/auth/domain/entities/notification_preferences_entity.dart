import 'package:equatable/equatable.dart';

class NotificationPreferencesEntity extends Equatable {
  final bool pushNotifications;
  final bool emailNotifications;
  final bool smsNotifications;

  const NotificationPreferencesEntity({
    this.pushNotifications = true,
    this.emailNotifications = true,
    this.smsNotifications = true,
  });

  @override
  List<Object?> get props => [
        pushNotifications,
        emailNotifications,
        smsNotifications,
      ];

  NotificationPreferencesEntity copyWith({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? smsNotifications,
  }) {
    return NotificationPreferencesEntity(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'push_notifications': pushNotifications,
      'email_notifications': emailNotifications,
      'sms_notifications': smsNotifications,
    };
  }

  factory NotificationPreferencesEntity.fromMap(Map<String, dynamic> map) {
    return NotificationPreferencesEntity(
      pushNotifications: map['push_notifications'] ?? true,
      emailNotifications: map['email_notifications'] ?? true,
      smsNotifications: map['sms_notifications'] ?? true,
    );
  }
}