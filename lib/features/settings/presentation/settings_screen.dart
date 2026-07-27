import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../shared/widgets/app_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Settings',
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Bank Details'),
            onTap: () => context.push(RouteNames.bankDetails),
          ),
          ListTile(
            leading: const Icon(Icons.print),
            title: const Text('Printer Setup'),
            onTap: () => context.push(RouteNames.printer),
          ),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Sync Settings'),
            onTap: () => context.push(RouteNames.sync),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
