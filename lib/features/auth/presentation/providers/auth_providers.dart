import 'package:business_referral_app/core/utils/referral_code_generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/entities/auth_state.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/notification_preferences_entity.dart';     


// Supabase client provider
final supabaseClientProvider = Provider<supabase.SupabaseClient>((ref) {
  return supabase.Supabase.instance.client;
});

// Auth state provider
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final supabase = ref.read(supabaseClientProvider);
  
  return supabase.auth.onAuthStateChange.map((data) {
    final user = data.session?.user;
    if (user == null) return null;
    
    // Convert Supabase User to UserEntity
    return UserEntity(
      id: user.id,
      phone: user.phone ?? '',
      email: user.email,
      firstName: user.userMetadata?['first_name'],
      lastName: user.userMetadata?['last_name'],
      displayName: user.userMetadata?['display_name'],
      profileImageUrl: user.userMetadata?['profile_image_url'],
      notificationPreferences: const NotificationPreferencesEntity(),
      referralCode: user.userMetadata?['referral_code'] ?? generateReferralCode(),
      isVerified: user.phoneConfirmedAt != null || user.emailConfirmedAt != null,
      createdAt: DateTime.parse(user.createdAt),
      updatedAt: DateTime.parse(user.updatedAt ?? user.createdAt),
      lastActivityAt: DateTime.now(),
    );
  });
});

// Auth controller provider
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});

// Auth controller class
class AuthController extends StateNotifier<AuthState> {
  final Ref _ref;
  
  AuthController(this._ref) : super(const AuthState(status: AuthStatus.initial)) {
    _checkCurrentUser();
  }

  supabase.SupabaseClient get _supabase => _ref.read(supabaseClientProvider);

  Future<void> _checkCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: _mapSupabaseUserToEntity(user),
        );
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      state = state.setError('Failed to check authentication: $e');
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    try {
      state = state.copyWith(
        status: AuthStatus.loading,
        isLoading: true,
        phoneNumber: phoneNumber,
        error: null,
      );

      await _supabase.auth.signInWithOtp(phone: phoneNumber);
      
      state = state.copyWith(
        status: AuthStatus.otpSent,
        isLoading: false,
        otpSent: true,
      );
    } on supabase.AuthException catch (e) {
      state = state.setError('Failed to send OTP: ${e.message}');
    } catch (e) {
      state = state.setError('Failed to send OTP: $e');
    }
  }

  Future<void> verifyOTP(String otpCode) async {
    if (state.phoneNumber == null) {
      state = state.setError('Phone number is required');
      return;
    }

    try {
      state = state.setLoading(true);

      final response = await _supabase.auth.verifyOTP(
        type: supabase.OtpType.sms,
        token: otpCode,
        phone: state.phoneNumber!,
      );

      if (response.user == null) {
        state = state.setError('Invalid OTP code');
        return;
      }

      // Check if user needs to set up password
      final userMetadata = response.user!.userMetadata;
      final hasPassword = userMetadata?['has_password'] == true;

      if (hasPassword) {
        // User already has password, they are fully authenticated
        state = state.copyWith(
          status: AuthStatus.authenticated,
          isLoading: false,
          otpVerified: true,
          user: _mapSupabaseUserToEntity(response.user!),
        );
      } else {
        // User needs to set up password
        state = state.copyWith(
          status: AuthStatus.otpVerified,
          isLoading: false,
          otpVerified: true,
          needsPasswordSetup: true,
        );
      }
    } on supabase.AuthException catch (e) {
      state = state.setError('Invalid OTP: ${e.message}');
    } catch (e) {
      state = state.setError('Failed to verify OTP: $e');
    }
  }

  Future<void> resendOTP() async {
    if (state.phoneNumber == null) {
      state = state.setError('Phone number is required');
      return;
    }

    await sendOTP(state.phoneNumber!);
  }

  Future<void> setupPassword(String password) async {
    try {
      state = state.setLoading(true);

      // Update user metadata to indicate they have a password
      await _supabase.auth.updateUser(
        supabase.UserAttributes(
          data: {'has_password': true},
          password: password,
        ),
      );

      final user = _supabase.auth.currentUser;
      if (user != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          isLoading: false,
          user: _mapSupabaseUserToEntity(user),
        );
      } else {
        state = state.setError('Failed to complete setup');
      }
    } on supabase.AuthException catch (e) {
      state = state.setError('Failed to setup password: ${e.message}');
    } catch (e) {
      state = state.setError('Failed to setup password: $e');
    }
  }

  Future<void> signInWithPassword(String phoneNumber, String password) async {
    try {
      state = state.copyWith(
        status: AuthStatus.loading,
        isLoading: true,
        phoneNumber: phoneNumber,
        error: null,
      );

      final response = await _supabase.auth.signInWithPassword(
        phone: phoneNumber,
        password: password,
      );

      if (response.user == null) {
        state = state.setError('Invalid credentials');
        return;
      }

      state = state.copyWith(
        status: AuthStatus.authenticated,
        isLoading: false,
        user: _mapSupabaseUserToEntity(response.user!),
      );
    } on supabase.AuthException catch (e) {
      state = state.setError('Sign in failed: ${e.message}');
    } catch (e) {
      state = state.setError('Sign in failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      
      state = const AuthState(status: AuthStatus.unauthenticated);
    } catch (e) {
      state = state.setError('Failed to sign out: $e');
    }
  }

  Future<void> resetPassword(String phoneNumber) async {
    try {
      state = state.setLoading(true);

      await _supabase.auth.signInWithOtp(phone: phoneNumber);
      
      state = state.copyWith(
        status: AuthStatus.passwordResetOTPSent,
        isLoading: false,
        phoneNumber: phoneNumber,
        error: null,
      );
    } on supabase.AuthException catch (e) {
      state = state.setError('Password reset failed: ${e.message}');
    } catch (e) {
      state = state.setError('Password reset failed: $e');
    }
  }

    Future<void> updateProfile(UserEntity updatedUser) async {
    try {
      state = state.setLoading(true);

      await _supabase.auth.updateUser(
        supabase.UserAttributes(
          data: {
            'first_name': updatedUser.firstName,
            'last_name': updatedUser.lastName,
            'display_name': updatedUser.displayName,
            'profile_image_url': updatedUser.profileImageUrl,
          },
        ),
      );

      state = state.copyWith(
        isLoading: false,
        user: updatedUser,
        error: null,
      );
    } catch (e) {
      state = state.setError('Failed to update profile: $e');
    }
  }

  void clearError() {
    state = state.clearError();
  }

  UserEntity _mapSupabaseUserToEntity(supabase.User user) {
    return UserEntity(
      id: user.id,
      phone: user.phone ?? '',
      email: user.email,
      firstName: user.userMetadata?['first_name'],
      lastName: user.userMetadata?['last_name'],
      displayName: user.userMetadata?['display_name'],
      profileImageUrl: user.userMetadata?['profile_image_url'],
      notificationPreferences: const NotificationPreferencesEntity(),
      referralCode: user.userMetadata?['referral_code'] ?? generateReferralCode(),
      totalReferrals: user.userMetadata?['total_referrals'] ?? 0,
      referralPoints: user.userMetadata?['referral_points'] ?? 0,
      isVerified: user.phoneConfirmedAt != null || user.emailConfirmedAt != null,
      isPremium: user.userMetadata?['is_premium'] ?? false,
      profileCompletionPercentage: _calculateProfileCompletion(user),
      createdAt: DateTime.parse(user.createdAt),
      updatedAt: DateTime.parse(user.updatedAt ?? user.createdAt),
      lastActivityAt: DateTime.now(),
    );
  }

  int _calculateProfileCompletion(supabase.User user) {
    int completedFields = 0;
    int totalFields = 6;

    if (user.phone?.isNotEmpty == true) completedFields++;
    if (user.email?.isNotEmpty == true) completedFields++;
    if (user.userMetadata?['first_name']?.isNotEmpty == true) completedFields++;
    if (user.userMetadata?['last_name']?.isNotEmpty == true) completedFields++;
    if (user.userMetadata?['profile_image_url']?.isNotEmpty == true) completedFields++;
    if (user.phoneConfirmedAt != null || user.emailConfirmedAt != null) completedFields++;

    return ((completedFields / totalFields) * 100).round();
  }
}



// Helper providers for specific auth states
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.isAuthenticated;
});

final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.user;
});

final authStatusProvider = Provider<AuthStatus>((ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.status;
});
