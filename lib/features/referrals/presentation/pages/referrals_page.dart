import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';

class ReferralsPage extends ConsumerWidget {
  const ReferralsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'My Referrals'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, size: 64),
            SizedBox(height: 16),
            Text('Referrals Page'),
            Text('Track your referral progress here!'),
          ],
        ),
      ),
    );
  }
}
