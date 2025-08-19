import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/phone_auth_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/business/presentation/pages/business_list_page.dart';
import '../../features/business/presentation/pages/business_detail_page.dart';
import '../../features/business/presentation/pages/add_business_page.dart';
import '../../features/referrals/presentation/pages/referrals_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../shared/presentation/pages/settings_page.dart';
import '../../features/business/presentation/pages/business_search_results_page.dart';
import 'route_names.dart';
import '../widgets/main_navigation.dart';

// Router Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash Screen
      GoRoute(
        path: Routes.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      
      // Authentication Routes
      GoRoute(
        path: Routes.phoneAuth,
        name: RouteNames.phoneAuth,
        builder: (context, state) => const PhoneAuthPage(),
      ),
      
      // Main Navigation Shell
      ShellRoute(
        builder: (context, state, child) => MainNavigation(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: Routes.dashboard,
            name: RouteNames.dashboard,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const DashboardPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
            routes: [
              // Business Detail
              GoRoute(
                path: 'business/:id',
                name: RouteNames.businessDetail,
                builder: (context, state) {
                  final businessId = state.pathParameters['id']!;
                  return BusinessDetailPage(businessId: businessId);
                },
              ),
            ],
          ),
          
          // Business List
          GoRoute(
            path: Routes.businesses,
            name: RouteNames.businesses,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const BusinessListPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeInOut)),
                  ),
                  child: child,
                );
              },
            ),
            routes: [
              // Add Business
              GoRoute(
                path: 'add',
                name: RouteNames.addBusiness,
                builder: (context, state) => const AddBusinessPage(),
              ),
            ],
          ),
          
          // Referrals
          GoRoute(
            path: Routes.referrals,
            name: RouteNames.referrals,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ReferralsPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(-1.0, 0.0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeInOut)),
                  ),
                  child: child,
                );
              },
            ),
          ),
          
          // Profile
          GoRoute(
            path: Routes.profile,
            name: RouteNames.profile,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ProfilePage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return ScaleTransition(
                  scale: animation.drive(
                    Tween<double>(begin: 0.8, end: 1.0).chain(
                      CurveTween(curve: Curves.easeInOut),
                    ),
                  ),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
            ),
            routes: [
              // Edit Profile
              GoRoute(
                path: 'edit',
                name: RouteNames.editProfile,
                builder: (context, state) => const EditProfilePage(),
              ),
            ],
          ),
        ],
      ),
      
      // Standalone Routes (outside main navigation)
      GoRoute(
        path: Routes.notifications,
        name: RouteNames.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      
      GoRoute(
        path: Routes.settings,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      
      // Business Search Results
      GoRoute(
        path: Routes.search,
        name: RouteNames.search,
        builder: (context, state) {
          final query = state.uri.queryParameters['q'] ?? '';
          final category = state.uri.queryParameters['category'];
          final location = state.uri.queryParameters['location'];
          
          return BusinessSearchResultsPage(
            query: query,
            category: category,
            location: location,
          );
        },
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(Routes.dashboard),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
    
    // Redirect logic (for authentication)
    redirect: (context, state) {
      // TODO: Implement authentication check
      // For now, let authenticated users through
      return null;
    },
  );
});


// Extension for easy navigation
extension AppRouterExtension on GoRouter {
  void pushBusinessDetail(String businessId) {
    pushNamed(
      RouteNames.businessDetail,
      pathParameters: {'id': businessId},
    );
  }
  
  void pushSearch({
    required String query,
    String? category,
    String? location,
  }) {
    final queryParams = <String, String>{'q': query};
    if (category != null) queryParams['category'] = category;
    if (location != null) queryParams['location'] = location;
    
    pushNamed(
      RouteNames.search,
      queryParameters: queryParams,
    );
  }
}