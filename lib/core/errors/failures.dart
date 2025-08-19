import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  
  const Failure(this.message, [this.code]);
  
  @override
  List<Object?> get props => [message, code];
  
  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure(super.message, [super.code]);
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure() : super('Invalid credentials provided');
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure() : super('User not found');
}

class OTPExpiredFailure extends AuthFailure {
  const OTPExpiredFailure() : super('OTP has expired');
}

class InvalidOTPFailure extends AuthFailure {
  const InvalidOTPFailure() : super('Invalid OTP code');
}

class PhoneAlreadyExistsFailure extends AuthFailure {
  const PhoneAlreadyExistsFailure() : super('Phone number already registered');
}

// Network Failures  
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, [super.code]);
}

class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure() : super('No internet connection');
}

class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure() : super('Request timeout');
}

// Server Failures
class ServerFailure extends Failure {
  const ServerFailure(super.message, [super.code]);
}

class InternalServerFailure extends ServerFailure {
  const InternalServerFailure() : super('Internal server error');
}

class BadRequestFailure extends ServerFailure {
  const BadRequestFailure(String field) : super('Resource not found: $field');
}

class NotFoundFailure extends ServerFailure {
  const NotFoundFailure(String field) : super('Resource not found: $field');
}

// Validation Failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.code]);
}

class InvalidPhoneFailure extends ValidationFailure {
  const InvalidPhoneFailure() : super('Invalid phone number format');
}

class InvalidEmailFailure extends ValidationFailure {
  const InvalidEmailFailure() : super('Invalid email format');
}

class WeakPasswordFailure extends ValidationFailure {
  const WeakPasswordFailure() : super('Password is too weak');
}

class RequiredFieldFailure extends ValidationFailure {
  const RequiredFieldFailure(String field) : super('$field is required');
}

// Storage Failures
class StorageFailure extends Failure {
  const StorageFailure(super.message, [super.code]);
}

class FileNotFoundFailure extends StorageFailure {
  const FileNotFoundFailure() : super('File not found');
}

class FileSizeExceededFailure extends StorageFailure {
  const FileSizeExceededFailure() : super('File size exceeds limit');
}

class InvalidFileTypeFailure extends StorageFailure {
  const InvalidFileTypeFailure() : super('Invalid file type');
}

// Location Failures
class LocationFailure extends Failure {
  const LocationFailure(super.message, [super.code]);
}

class LocationPermissionDeniedFailure extends LocationFailure {
  const LocationPermissionDeniedFailure() : super('Location permission denied');
}

class LocationServiceDisabledFailure extends LocationFailure {
  const LocationServiceDisabledFailure() : super('Location service disabled');
}

// Business Logic Failures
class BusinessFailure extends Failure {
  const BusinessFailure(super.message, [super.code]);
}

class InsufficientPointsFailure extends BusinessFailure {
  const InsufficientPointsFailure() : super('Insufficient referral points');
}

class AlreadyReferredFailure extends BusinessFailure {
  const AlreadyReferredFailure() : super('Already referred this user/business');
}

class BusinessNotActiveFailure extends BusinessFailure {
  const BusinessNotActiveFailure() : super('Business is not active');
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.code]);
}

class CacheExpiredFailure extends CacheFailure {
  const CacheExpiredFailure() : super('Cache has expired');
}

class CacheNotFoundFailure extends CacheFailure {
  const CacheNotFoundFailure() : super('Data not found in cache');
}