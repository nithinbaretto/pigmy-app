import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return AppScaffold(
      title: 'Login',
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance, size: 80),
            const SizedBox(height: 32),
            TextField(
              decoration: const InputDecoration(labelText: 'Username'),
              onChanged: controller.updateUsername,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: controller.updatePassword,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Login',
              isLoading: state.isLoading,
              onPressed: controller.login,
            ),
            if (state.error != null) ...[
              const SizedBox(height: 16),
              Text(state.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ),
      ),
    );
  }
}
