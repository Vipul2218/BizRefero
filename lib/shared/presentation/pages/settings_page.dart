import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/routing/route_names.dart';
import '../../../shared/presentation/widgets/custom_app_bar.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
        showBackButton: true,
      ),
      body: ListView(
        children: [
          _buildSettingsSection(
            context,
            'Account',
            [
              _buildSettingsItem(
                'Personal Information',
                Icons.person,
                () => context.pushNamed(RouteNames.editProfile),
              ),
              _buildSettingsItem(
                'Privacy & Security',
                Icons.security,
                () {},
              ),
              _buildSettingsItem(
                'Notification Settings',
                Icons.notifications,
                () {},
              ),
            ],
          ),
          _buildSettingsSection(
            context,
            'App',
            [
              _buildSettingsItem(
                'Theme',
                Icons.palette,
                () {},
              ),
              _buildSettingsItem(
                'Language',
                Icons.language,
                () {},
              ),
            ],
          ),
          _buildSettingsSection(
            context,
            'Support',
            [
              _buildSettingsItem(
                'Help Center',
                Icons.help,
                () {},
              ),
              _buildSettingsItem(
                'Contact Support',
                Icons.support_agent,
                () {},
              ),
              _buildSettingsItem(
                'Terms of Service',
                Icons.description,
                () {},
              ),
              _buildSettingsItem(
                'Privacy Policy',
                Icons.privacy_tip,
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items,
        const Divider(),
      ],
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}