import './user_entity.dart';

enum AuthStatus {
  initial,
  loading,
  otpSent,
  otpVerified,
  passwordResetOTPSent,
  authenticated,
  unauthenticated,
  error,
}

class AuthState {
  final AuthStatus status;
  final UserEntity? user;
  final String? error;
  final String? phoneNumber;
  final bool isLoading;
  final bool otpSent;
  final bool otpVerified;
  final bool needsPasswordSetup;

  const AuthState({
    required this.status,
    this.user,
    this.error,
    this.phoneNumber,
    this.isLoading = false,
    this.otpSent = false,
    this.otpVerified = false,
    this.needsPasswordSetup = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? error,
    String? phoneNumber,
    bool? isLoading,
    bool? otpSent,
    bool? otpVerified,
    bool? needsPasswordSetup,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      otpSent: otpSent ?? this.otpSent,
      otpVerified: otpVerified ?? this.otpVerified,
      needsPasswordSetup: needsPasswordSetup ?? this.needsPasswordSetup,
    );
  }

  AuthState clearError() {
    return copyWith(error: null);
  }

  AuthState setLoading(bool loading) {
    return copyWith(isLoading: loading);
  }

  AuthState setError(String error) {
    return copyWith(error: error, isLoading: false);
  }

  bool get isAuthenticated => status == AuthStatus.authenticated && user != null;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get hasError => error != null;

  @override
  String toString() {
    return 'AuthState(status: $status, user: ${user?.fullName}, error: $error, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is AuthState &&
        other.status == status &&
        other.user == user &&
        other.error == error &&
        other.phoneNumber == phoneNumber &&
        other.isLoading == isLoading &&
        other.otpSent == otpSent &&
        other.otpVerified == otpVerified &&
        other.needsPasswordSetup == needsPasswordSetup;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        user.hashCode ^
        error.hashCode ^
        phoneNumber.hashCode ^
        isLoading.hashCode ^
        otpSent.hashCode ^
        otpVerified.hashCode ^
        needsPasswordSetup.hashCode;
  }
}

// Auth events for cleaner state management
abstract class AuthEvent {}

class AuthInitialize extends AuthEvent {}

class AuthSendOTP extends AuthEvent {
  final String phoneNumber;
  AuthSendOTP(this.phoneNumber);
}

class AuthVerifyOTP extends AuthEvent {
  final String otpCode;
  AuthVerifyOTP(this.otpCode);
}

class AuthResendOTP extends AuthEvent {}

class AuthSetupPassword extends AuthEvent {
  final String password;
  AuthSetupPassword(this.password);
}

class AuthSignInWithPassword extends AuthEvent {
  final String phoneNumber;
  final String password;
  AuthSignInWithPassword(this.phoneNumber, this.password);
}

class AuthSignOut extends AuthEvent {}

class AuthResetPassword extends AuthEvent {
  final String phoneNumber;
  AuthResetPassword(this.phoneNumber);
}

class AuthUpdateProfile extends AuthEvent {
  final UserEntity user;
  AuthUpdateProfile(this.user);
}

class AuthDeleteAccount extends AuthEvent {}

class AuthCheckSession extends AuthEvent {}
