// Route Names for type-safe navigation
import 'package:flutter/material.dart';

class RouteNames {
  // Authentication Routes
  static const String splash = 'splash';
  static const String phoneAuth = 'phoneAuth';
  static const String otpVerification = 'otpVerification';
  static const String passwordSetup = 'passwordSetup';
  static const String forgotPassword = 'forgotPassword';
  
  // Main Navigation Routes
  static const String dashboard = 'dashboard';
  static const String businesses = 'businesses';
  static const String referrals = 'referrals';
  static const String profile = 'profile';
  
  // Business Routes
  static const String businessDetail = 'businessDetail';
  static const String addBusiness = 'addBusiness';
  static const String editBusiness = 'editBusiness';
  static const String businessReviews = 'businessReviews';
  static const String addReview = 'addReview';
  
  // Profile Routes
  static const String editProfile = 'editProfile';
  static const String profileSettings = 'profileSettings';
  static const String changePassword = 'changePassword';
  
  // Search & Discovery Routes
  static const String search = 'search';
  static const String searchResults = 'searchResults';
  static const String categoryBrowse = 'categoryBrowse';
  static const String mapView = 'mapView';
  
  // Referral Routes
  static const String myReferrals = 'myReferrals';
  static const String referralDetails = 'referralDetails';
  static const String inviteUsers = 'inviteUsers';
  static const String referralRewards = 'referralRewards';
  
  // Notification Routes
  static const String notifications = 'notifications';
  static const String notificationDetail = 'notificationDetail';
  
  // Settings Routes
  static const String settings = 'settings';
  static const String privacySettings = 'privacySettings';
  static const String notificationSettings = 'notificationSettings';
  static const String accountSettings = 'accountSettings';
  static const String about = 'about';
  static const String support = 'support';
  static const String feedback = 'feedback';
  
  // Legal Routes
  static const String termsOfService = 'termsOfService';
  static const String privacyPolicy = 'privacyPolicy';
  static const String dataPolicy = 'dataPolicy';
  
  // Error Routes
  static const String notFound = 'notFound';
  static const String error = 'error';
}

// Route Paths for URL structure
class Routes {
  // Authentication Routes
  static const String splash = '/';
  static const String phoneAuth = '/auth';
  static const String otpVerification = '/auth/otp';
  static const String passwordSetup = '/auth/password-setup';
  static const String forgotPassword = '/auth/forgot-password';
  
  // Main Navigation Routes
  static const String dashboard = '/dashboard';
  static const String businesses = '/businesses';
  static const String referrals = '/referrals';
  static const String profile = '/profile';
  
  // Business Routes
  static const String businessDetail = '/business/:id';
  static const String addBusiness = '/businesses/add';
  static const String editBusiness = '/business/:id/edit';
  static const String businessReviews = '/business/:id/reviews';
  static const String addReview = '/business/:id/review/add';
  
  // Profile Routes
  static const String editProfile = '/profile/edit';
  static const String profileSettings = '/profile/settings';
  static const String changePassword = '/profile/change-password';
  
  // Search & Discovery Routes
  static const String search = '/search';
  static const String searchResults = '/search/results';
  static const String categoryBrowse = '/browse/:category';
  static const String mapView = '/map';
  
  // Referral Routes
  static const String myReferrals = '/referrals/my';
  static const String referralDetails = '/referrals/:id';
  static const String inviteUsers = '/referrals/invite';
  static const String referralRewards = '/referrals/rewards';
  
  // Notification Routes
  static const String notifications = '/notifications';
  static const String notificationDetail = '/notifications/:id';
  
  // Settings Routes
  static const String settings = '/settings';
  static const String privacySettings = '/settings/privacy';
  static const String notificationSettings = '/settings/notifications';
  static const String accountSettings = '/settings/account';
  static const String about = '/settings/about';
  static const String support = '/settings/support';
  static const String feedback = '/settings/feedback';
  
  // Legal Routes
  static const String termsOfService = '/legal/terms';
  static const String privacyPolicy = '/legal/privacy';
  static const String dataPolicy = '/legal/data';
  
  // Error Routes
  static const String notFound = '/404';
  static const String error = '/error';
}

// Route Groups for easier management
class RouteGroups {
  static const List<String> authRoutes = [
    Routes.splash,
    Routes.phoneAuth,
    Routes.otpVerification,
    Routes.passwordSetup,
    Routes.forgotPassword,
  ];
  
  static const List<String> mainNavRoutes = [
    Routes.dashboard,
    Routes.businesses,
    Routes.referrals,
    Routes.profile,
  ];
  
  static const List<String> businessRoutes = [
    Routes.businessDetail,
    Routes.addBusiness,
    Routes.editBusiness,
    Routes.businessReviews,
    Routes.addReview,
  ];
  
  static const List<String> profileRoutes = [
    Routes.editProfile,
    Routes.profileSettings,
    Routes.changePassword,
  ];
  
  static const List<String> settingsRoutes = [
    Routes.settings,
    Routes.privacySettings,
    Routes.notificationSettings,
    Routes.accountSettings,
    Routes.about,
    Routes.support,
    Routes.feedback,
  ];
  
  static const List<String> publicRoutes = [
    Routes.splash,
    Routes.phoneAuth,
    Routes.termsOfService,
    Routes.privacyPolicy,
    Routes.dataPolicy,
  ];
  
  static const List<String> protectedRoutes = [
    Routes.dashboard,
    Routes.businesses,
    Routes.referrals,
    Routes.profile,
    Routes.addBusiness,
    Routes.editProfile,
    Routes.settings,
  ];
}

// Route Metadata for additional information
class RouteMetadata {
  final String name;
  final String path;
  final String title;
  final String? description;
  final IconData? icon;
  final bool requiresAuth;
  final bool showInBottomNav;
  
  const RouteMetadata({
    required this.name,
    required this.path,
    required this.title,
    this.description,
    this.icon,
    this.requiresAuth = true,
    this.showInBottomNav = false,
  });
}

// Main navigation routes metadata
final Map<String, RouteMetadata> mainNavMetadata = {
  RouteNames.dashboard: const RouteMetadata(
    name: RouteNames.dashboard,
    path: Routes.dashboard,
    title: 'Home',
    description: 'Discover businesses and trending referrals',
    icon: Icons.home_rounded,
    showInBottomNav: true,
  ),
  RouteNames.businesses: const RouteMetadata(
    name: RouteNames.businesses,
    path: Routes.businesses,
    title: 'Businesses',
    description: 'Browse and manage businesses',
    icon: Icons.business_rounded,
    showInBottomNav: true,
  ),
  RouteNames.referrals: const RouteMetadata(
    name: RouteNames.referrals,
    path: Routes.referrals,
    title: 'Referrals',
    description: 'Track your referrals and rewards',
    icon: Icons.people_rounded,
    showInBottomNav: true,
  ),
  RouteNames.profile: const RouteMetadata(
    name: RouteNames.profile,
    path: Routes.profile,
    title: 'Profile',
    description: 'Manage your account and settings',
    icon: Icons.person_rounded,
    showInBottomNav: true,
  ),
};

// Helper function to check if route requires authentication
bool isProtectedRoute(String route) {
  return RouteGroups.protectedRoutes.any((protectedRoute) {
    // Handle parameterized routes
    final routePattern = protectedRoute.replaceAll(RegExp(r':\w+'), r'[^/]+');
    final regex = RegExp('^$routePattern\$');
    return regex.hasMatch(route);
  });
}

// Helper function to check if route should show bottom navigation
bool shouldShowBottomNav(String route) {
  return RouteGroups.mainNavRoutes.any((navRoute) {
    final routePattern = navRoute.replaceAll(RegExp(r':\w+'), r'[^/]+');
    final regex = RegExp('^$routePattern\$');
    return regex.hasMatch(route);
  });
}