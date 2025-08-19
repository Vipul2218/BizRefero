import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';

class AddBusinessPage extends ConsumerWidget {
  const AddBusinessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Add Business',
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_business, size: 64),
            SizedBox(height: 16),
            Text('Add Business Page'),
            Text('Feature coming soon!'),
          ],
        ),
      ),
    );
  }
}