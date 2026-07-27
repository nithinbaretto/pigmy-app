import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../controller/collection_controller.dart';
import '../model/collection_config.dart';
import '../widgets/collection_list_tile.dart';

class CollectionListScreen extends ConsumerWidget {
  const CollectionListScreen({super.key, required this.type});

  final CollectionType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = CollectionConfig.forType(type);
    final state = ref.watch(collectionListControllerProvider(type));

    return AppScaffold(
      title: config.title,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          '${RouteNames.collection}/form?type=${type.code}',
        ),
        child: const Icon(Icons.add),
      ),
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, CollectionListState state) {
    if (state.isLoading) return const LoadingWidget();
    if (state.error != null) {
      return AppErrorWidget(
        message: state.error!,
        onRetry: () =>
            ref.read(collectionListControllerProvider(type).notifier).loadCollections(),
      );
    }
    if (state.collections.isEmpty) {
      return EmptyStateWidget(
        message: 'No ${type.label} collections yet',
        actionLabel: 'Add Collection',
        onAction: () => context.push(
          '${RouteNames.collection}/form?type=${type.code}',
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(collectionListControllerProvider(type).notifier).loadCollections(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.collections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final collection = state.collections[index];
          return CollectionListTile(
            title: collection.customerName,
            subtitle: collection.accountNumber,
            amount: Formatters.currency(collection.amount),
            date: Formatters.date(collection.collectedAt),
            isSynced: collection.isSynced,
          );
        },
      ),
    );
  }
}
