import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';
import '../../../../shared/presentation/widgets/search_bar_widget.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Good Morning!',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(Routes.notifications),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Search Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: const SearchBarWidget(),
              ),
            ),
            
            // Quick Actions Section
            SliverToBoxAdapter(
              child: _buildQuickActions(),
            ),
            
            // Trending Businesses Section
            SliverToBoxAdapter(
              child: _buildSectionHeader('Trending Businesses'),
            ),
            
            SliverToBoxAdapter(
              child: _buildTrendingBusinesses(),
            ),
            
            // Recent Referrals Section
            SliverToBoxAdapter(
              child: _buildSectionHeader('Recent Referrals'),
            ),
            
            SliverToBoxAdapter(
              child: _buildRecentReferrals(),
            ),
            
            // Categories Section
            SliverToBoxAdapter(
              child: _buildSectionHeader('Browse Categories'),
            ),
            
            SliverToBoxAdapter(
              child: _buildCategories(),
            ),
            
            // Bottom padding for navigation bar
            SliverToBoxAdapter(
              child: SizedBox(height: 100.h),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  icon: Icons.business_center,
                  title: 'Add Business',
                  subtitle: 'List your business',
                  color: AppColors.primary,
                  onTap: () => context.pushNamed(RouteNames.addBusiness),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionCard(
                  icon: Icons.people,
                  title: 'Invite Friends',
                  subtitle: 'Earn rewards',
                  color: AppColors.secondary,
                  onTap: () => context.pushNamed(RouteNames.inviteUsers),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20.w,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to see all based on section
              if (title.contains('Business')) {
                context.pushNamed(RouteNames.businesses);
              } else if (title.contains('Referrals')) {
                context.pushNamed(RouteNames.referrals);
              }
            },
            child: const Text('See All'),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingBusinesses() {
    // Mock data for trending businesses
    final businesses = List.generate(5, (index) => {
      'id': 'business_$index',
      'name': 'Business ${index + 1}',
      'category': AppConstants.defaultCategories[index % AppConstants.defaultCategories.length],
      'rating': 4.0 + (index * 0.2),
      'reviews': 50 + (index * 10),
      'distance': '0.${index + 1}',
    });

    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: businesses.length,
        itemBuilder: (context, index) {
          final business = businesses[index];
          return _buildBusinessCard(business);
        },
      ),
    );
  }

  Widget _buildBusinessCard(Map<String, dynamic> business) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.pushNamed(
          RouteNames.businessDetail,
          pathParameters: {'id': business['id']},
        ),
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.getCategoryColor(business['category']).withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.business,
                  size: 40.w,
                  color: AppColors.getCategoryColor(business['category']),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    business['name'],
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: 4.h),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 14.w,
                        color: AppColors.warning,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        business['rating'].toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '(${business['reviews']})',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 4.h),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.w,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${business['distance']} km',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentReferrals() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  color: AppColors.success,
                  size: 20.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You\'ve earned 150 points this month!',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '3 successful referrals',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: 6, // Show first 6 categories
        itemBuilder: (context, index) {
          final category = AppConstants.defaultCategories[index];
          return _buildCategoryCard(category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(String category) {
    final color = AppColors.getCategoryColor(category);
    
    return InkWell(
      onTap: () {
        // Navigate to category browse
        context.pushNamed(
          RouteNames.search,
          queryParameters: {'category': category},
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                _getCategoryIcon(category),
                color: Colors.white,
                size: 18.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                category,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'restaurants & food':
        return Icons.restaurant;
      case 'healthcare':
        return Icons.local_hospital;
      case 'shopping':
        return Icons.shopping_bag;
      case 'services':
        return Icons.build;
      case 'entertainment':
        return Icons.movie;
      case 'automotive':
        return Icons.directions_car;
      default:
        return Icons.business;
    }
  }

  Future<void> _onRefresh() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    if (mounted) {
      // Refresh data here
      setState(() {
        // Update state if needed
      });
    }
  }
}