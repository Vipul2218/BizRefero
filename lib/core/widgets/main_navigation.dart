import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routing/route_names.dart' as routes;

class MainNavigation extends StatelessWidget {
  final Widget child;
  
  const MainNavigation({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _getSelectedIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNavigationBar(context, currentIndex),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _onItemTapped(context, index),
      height: 80.h,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.business_outlined),
          selectedIcon: Icon(Icons.business_rounded),
          label: 'Businesses',
        ),
        NavigationDestination(
          icon: Icon(Icons.people_outline_rounded),
          selectedIcon: Icon(Icons.people_rounded),
          label: 'Referrals',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }

  int _getSelectedIndex(String location) {
    // Remove query parameters and fragments for comparison
    final path = location.split('?').first.split('#').first;
    
    if (path.startsWith(routes.Routes.dashboard)) {
      return 0;
    } else if (path.startsWith(routes.Routes.businesses)) {
      return 1;
    } else if (path.startsWith(routes.Routes.referrals)) {
      return 2;
    } else if (path.startsWith(routes.Routes.profile)) {
      return 3;
    }
    
    return 0; // Default to home
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(routes.Routes.dashboard);
        break;
      case 1:
        context.go(routes.Routes.businesses);
        break;
      case 2:
        context.go(routes.Routes.referrals);
        break;
      case 3:
        context.go(routes.Routes.profile);
        break;
    }
  }
}