import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/collection_entity.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/bank_details/presentation/bank_details_screen.dart';
import '../../features/collection/presentation/collection_form_screen.dart';
import '../../features/collection/presentation/collection_list_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/printer/presentation/printer_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/summary/presentation/summary_screen.dart';
import '../../features/sync/presentation/sync_screen.dart';
import '../../features/transactions/presentation/transactions_screen.dart';
import '../../shared/providers/providers.dart';
import 'route_names.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (context, state) async {
      final isLoggedIn = await authRepository.isAuthenticated();
      final isLoginRoute = state.matchedLocation == RouteNames.login;

      if (!isLoggedIn && !isLoginRoute) return RouteNames.login;
      if (isLoggedIn && (isLoginRoute || state.matchedLocation == RouteNames.splash)) {
        return RouteNames.dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.collection,
        builder: (context, state) {
          final type = state.uri.queryParameters['type'];
          return CollectionListScreen(
            type: type != null ? CollectionType.fromCode(type) : CollectionType.pigmy,
          );
        },
        routes: [
          GoRoute(
            path: 'form',
            builder: (context, state) {
              final type = state.uri.queryParameters['type'];
              return CollectionFormScreen(
                type: type != null
                    ? CollectionType.fromCode(type)
                    : CollectionType.pigmy,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.transactions,
        builder: (context, state) => const TransactionsScreen(),
      ),
      GoRoute(
        path: RouteNames.summary,
        builder: (context, state) => const SummaryScreen(),
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: RouteNames.bankDetails,
        builder: (context, state) => const BankDetailsScreen(),
      ),
      GoRoute(
        path: RouteNames.printer,
        builder: (context, state) => const PrinterScreen(),
      ),
      GoRoute(
        path: RouteNames.sync,
        builder: (context, state) => const SyncScreen(),
      ),
    ],
  );
});

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
