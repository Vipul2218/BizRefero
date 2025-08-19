class AppConstants {
  // App Information
  static const String appName = 'Business Referral';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Connect with trusted businesses';
  
  // Support Information
  static const String supportEmail = 'support@businessreferral.com';
  static const String privacyPolicyUrl = 'https://businessreferral.com/privacy';
  static const String termsOfServiceUrl = 'https://businessreferral.com/terms';
  
  // Social Media
  static const String facebookUrl = 'https://facebook.com/businessreferral';
  static const String twitterUrl = 'https://twitter.com/businessreferral';
  static const String instagramUrl = 'https://instagram.com/businessreferral';
  
  // Default Values
  static const int defaultSearchRadius = 10; // kilometers
  static const double defaultLatitude = 37.7749;
  static const double defaultLongitude = -122.4194; // San Francisco
  
  // Referral System
  static const int referralPointsPerUser = 100;
  static const int referralPointsPerBusiness = 200;
  static const int minimumPointsForReward = 500;
  
  // Business Categories
  static const List<String> defaultCategories = [
    'Restaurants & Food',
    'Healthcare',
    'Shopping',
    'Services',
    'Entertainment',
    'Automotive',
    'Beauty & Spa',
    'Home & Garden',
    'Education',
    'Travel & Hotels',
  ];
  
  // Image Constraints
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxGalleryImages = 5;
  static const int maxStoreImages = 2;
  
  // Text Constraints
  static const int maxBusinessNameLength = 100;
  static const int maxBusinessDescriptionLength = 500;
  static const int maxReviewLength = 1000;
  static const int minReviewLength = 10;
}