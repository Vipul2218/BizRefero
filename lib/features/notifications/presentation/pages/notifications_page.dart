import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notifications',
        showBackButton: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.notifications),
          ),
          title: Text('Notification ${index + 1}'),
          subtitle: const Text('This is a sample notification message.'),
          trailing: Text('${index + 1}h ago'),
          onTap: () {},
        ),
      ),
    );
  }
}