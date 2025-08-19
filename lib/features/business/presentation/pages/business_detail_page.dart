import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';

class BusinessDetailPage extends ConsumerWidget {
  final String businessId;
  
  const BusinessDetailPage({super.key, required this.businessId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Business Details',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Business image placeholder
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Center(
                child: Icon(Icons.business, size: 64),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Business name and rating
            Text(
              'Business Name',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            
            Row(
              children: [
                ...List.generate(5, (index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16.w,
                )),
                SizedBox(width: 8.w),
                const Text('4.5 (120 reviews)'),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Description
            Text(
              'About',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'This is a sample business description. More details about the business would go here.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            SizedBox(height: 24.h),
            
            // Contact info
            _buildContactSection(context),
            
            SizedBox(height: 24.h),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone),
                    label: const Text('Call'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.directions),
                    label: const Text('Directions'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        _buildContactItem(Icons.phone, '+1 (555) 123-4567'),
        _buildContactItem(Icons.email, 'business@example.com'),
        _buildContactItem(Icons.location_on, '123 Main St, City, State'),
        _buildContactItem(Icons.access_time, 'Mon-Fri: 9AM-6PM'),
      ],
    );
  }
  
  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 20.w),
          SizedBox(width: 12.w),
          Text(text),
        ],
      ),
    );
  }
}