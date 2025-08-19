import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';
import '../../../../shared/presentation/widgets/search_bar_widget.dart';

class BusinessListPage extends ConsumerWidget {
  const BusinessListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Businesses'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: const SearchBarWidget(),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: 10,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.business),
                  ),
                  title: Text('Business ${index + 1}'),
                  subtitle: Text('Category • ${index + 1}.0 km'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.pushNamed(
                    RouteNames.businessDetail,
                    pathParameters: {'id': 'business_$index'},
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RouteNames.addBusiness),
        child: const Icon(Icons.add),
      ),
    );
  }
}
