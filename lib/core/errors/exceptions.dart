// Base Exception
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, [this.code]);
  
  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

// Authentication Exceptions
class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException() : super('Invalid credentials');
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException() : super('User not found');
}

class OTPExpiredException extends AuthException {
  const OTPExpiredException() : super('OTP has expired');
}

class InvalidOTPException extends AuthException {
  const InvalidOTPException() : super('Invalid OTP code');
}

class PhoneAlreadyExistsException extends AuthException {
  const PhoneAlreadyExistsException() : super('Phone number already exists');
}

class UnauthorizedException extends AuthException {
  const UnauthorizedException() : super('Unauthorized access');
}

// Server Exceptions
class ServerException extends AppException {
  const ServerException(super.message, [super.code]);
}

class BadRequestException extends ServerException {
  const BadRequestException(super.message) : super();
}

class NotFoundException extends ServerException {
  const NotFoundException(super.message) : super();
}

class ForbiddenException extends ServerException {
  const ForbiddenException(super.message) : super();
}

class InternalServerException extends ServerException {
  const InternalServerException() : super('Internal server error');
}

class ServiceUnavailableException extends ServerException {
  const ServiceUnavailableException() : super('Service temporarily unavailable');
}

// Network Exceptions
class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}

class NoInternetException extends NetworkException {
  const NoInternetException() : super('No internet connection');
}

class TimeoutException extends NetworkException {
  const TimeoutException() : super('Request timeout');
}

class ConnectionException extends NetworkException {
  const ConnectionException() : super('Connection failed');
}

// Validation Exceptions
class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
}

class InvalidPhoneException extends ValidationException {
  const InvalidPhoneException() : super('Invalid phone number format');
}

class InvalidEmailException extends ValidationException {
  const InvalidEmailException() : super('Invalid email format');
}

class WeakPasswordException extends ValidationException {
  const WeakPasswordException() : super('Password is too weak');
}

class RequiredFieldException extends ValidationException {
  const RequiredFieldException(String field) : super('$field is required');
}

// Storage Exceptions
class StorageException extends AppException {
  const StorageException(super.message, [super.code]);
}

class FileNotFoundException extends StorageException {
  const FileNotFoundException() : super('File not found');
}

class FileSizeExceededException extends StorageException {
  const FileSizeExceededException() : super('File size exceeds limit');
}

class InvalidFileTypeException extends StorageException {
  const InvalidFileTypeException() : super('Invalid file type');
}

class UploadFailedException extends StorageException {
  const UploadFailedException(super.message) : super();
}

// Location Exceptions
class LocationException extends AppException {
  const LocationException(super.message, [super.code]);
}

class LocationPermissionDeniedException extends LocationException {
  const LocationPermissionDeniedException() : super('Location permission denied');
}

class LocationServiceDisabledException extends LocationException {
  const LocationServiceDisabledException() : super('Location service disabled');
}

class LocationUnavailableException extends LocationException {
  const LocationUnavailableException() : super('Location unavailable');
}

// Database Exceptions
class DatabaseException extends AppException {
  const DatabaseException(super.message, [super.code]);
}

class RecordNotFoundException extends DatabaseException {
  const RecordNotFoundException(super.message) : super();
}

class DuplicateRecordException extends DatabaseException {
  const DuplicateRecordException(super.message) : super();
}

class DatabaseConstraintException extends DatabaseException {
  const DatabaseConstraintException(super.message) : super();
}

// Cache Exceptions
class CacheException extends AppException {
  const CacheException(super.message, [super.code]);
}

class CacheExpiredException extends CacheException {
  const CacheExpiredException() : super('Cache has expired');
}

class CacheNotFoundException extends CacheException {
  const CacheNotFoundException() : super('Data not found in cache');
}

class CacheWriteException extends CacheException {
  const CacheWriteException() : super('Failed to write to cache');
}

// Business Logic Exceptions
class BusinessException extends AppException {
  const BusinessException(super.message, [super.code]);
}

class InsufficientPointsException extends BusinessException {
  const InsufficientPointsException() : super('Insufficient referral points');
}

class AlreadyReferredException extends BusinessException {
  const AlreadyReferredException() : super('Already referred');
}

class BusinessNotActiveException extends BusinessException {
  const BusinessNotActiveException() : super('Business is not active');
}

class MaxLimitReachedException extends BusinessException {
  const MaxLimitReachedException(super.message) : super();
}