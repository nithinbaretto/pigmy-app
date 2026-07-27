import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Dashboard',
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => context.push(RouteNames.settings),
        ),
      ],
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          DashboardCard(
            title: CollectionType.pigmy.label,
            icon: Icons.savings,
            color: AppColors.pigmy,
            onTap: () => context.push('${RouteNames.collection}?type=${CollectionType.pigmy.code}'),
          ),
          DashboardCard(
            title: CollectionType.loan.label,
            icon: Icons.account_balance,
            color: AppColors.loan,
            onTap: () => context.push('${RouteNames.collection}?type=${CollectionType.loan.code}'),
          ),
          DashboardCard(
            title: CollectionType.rd.label,
            icon: Icons.repeat,
            color: AppColors.rd,
            onTap: () => context.push('${RouteNames.collection}?type=${CollectionType.rd.code}'),
          ),
          DashboardCard(
            title: CollectionType.sb.label,
            icon: Icons.wallet,
            color: AppColors.sb,
            onTap: () => context.push('${RouteNames.collection}?type=${CollectionType.sb.code}'),
          ),
          DashboardCard(
            title: 'Transactions',
            icon: Icons.receipt_long,
            color: AppColors.primary,
            onTap: () => context.push(RouteNames.transactions),
          ),
          DashboardCard(
            title: 'Summary',
            icon: Icons.bar_chart,
            color: AppColors.secondary,
            onTap: () => context.push(RouteNames.summary),
          ),
          DashboardCard(
            title: 'Sync',
            icon: Icons.sync,
            color: AppColors.warning,
            onTap: () => context.push(RouteNames.sync),
          ),
          DashboardCard(
            title: 'Printer',
            icon: Icons.print,
            color: AppColors.accent,
            onTap: () => context.push(RouteNames.printer),
          ),
        ],
      ),
    );
  }
}
