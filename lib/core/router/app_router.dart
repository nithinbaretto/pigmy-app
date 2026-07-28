import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/collection/presentation/collection_screen.dart';
import '../../features/collection/presentation/customer_details_screen.dart';
import '../../features/collection/presentation/customer_list_screen.dart';
import '../../features/dashboard/presentation/collections_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/printer/presentation/printer_settings_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/summary/presentation/summary_screen.dart';
import '../../features/sync/presentation/export_file_screen.dart';
import '../../features/sync/presentation/import_file_screen.dart';
import '../../features/transactions/presentation/transactions_screen.dart';
import 'route_names.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.collections,
        builder: (context, state) => const CollectionsScreen(),
      ),
      GoRoute(
        path: RouteNames.customers,
        builder: (context, state) => const CustomerListScreen(),
      ),
      GoRoute(
        path: RouteNames.customerDetails,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CustomerDetailsScreen(customerId: id);
        },
      ),
      GoRoute(
        path: RouteNames.collection,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CollectionScreen(customerId: id);
        },
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
        routes: [
          GoRoute(
            path: 'printer',
            builder: (context, state) => const PrinterSettingsScreen(),
          ),
          GoRoute(
            path: 'import',
            builder: (context, state) => const ImportFileScreen(),
          ),
          GoRoute(
            path: 'export',
            builder: (context, state) => const ExportFileScreen(),
          ),
        ],
      ),
    ],
  );
});
