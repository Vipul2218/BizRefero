class ApiConstants {
  // Supabase Configuration
  // TODO: Replace with your actual Supabase URL and keys
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key-here';
  
  // Database Tables
  static const String profilesTable = 'profiles';
  static const String businessesTable = 'businesses';
  static const String categoriesTable = 'categories';
  static const String referralsTable = 'referrals';
  static const String notificationsTable = 'notifications';
  static const String userFavoritesTable = 'user_favorites';
  static const String reviewsTable = 'reviews';
  
  // Storage Buckets
  static const String profileImagesBucket = 'profile-images';
  static const String businessLogosBucket = 'business-logos';
  static const String businessImagesBucket = 'business-images';
  
  // API Endpoints
  static const String googlePlacesApi = 'https://maps.googleapis.com/maps/api/place';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int searchPageSize = 10;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int otpLength = 6;
  
  // Caching
  static const Duration cacheTimeout = Duration(minutes: 30);
  static const Duration imagesCacheTimeout = Duration(hours: 24);
}