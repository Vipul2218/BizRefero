import 'dart:math';

/// Generates a unique referral code
String generateReferralCode() {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  
  return String.fromCharCodes(Iterable.generate(
    8, // 8 character referral code
    (_) => chars.codeUnitAt(random.nextInt(chars.length))
  ));
}

/// Generates a referral code with a specific prefix
String generateReferralCodeWithPrefix(String prefix) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  
  String suffix = String.fromCharCodes(Iterable.generate(
    6, // 6 characters after prefix
    (_) => chars.codeUnitAt(random.nextInt(chars.length))
  ));
  
  return '${prefix.toUpperCase()}$suffix';
}

/// Validates if a referral code format is correct
bool isValidReferralCode(String code) {
  // Check if code is 8 characters long and contains only alphanumeric characters
  if (code.length != 8) return false;
  
  final RegExp alphaNumeric = RegExp(r'^[A-Z0-9]+$');
  return alphaNumeric.hasMatch(code.toUpperCase());
}

/// Generates a user-friendly referral code (excludes confusing characters)
String generateFriendlyReferralCode() {
  // Exclude confusing characters like 0, O, I, 1, etc.
  const String chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  Random random = Random();
  
  return String.fromCharCodes(Iterable.generate(
    8,
    (_) => chars.codeUnitAt(random.nextInt(chars.length))
  ));
}