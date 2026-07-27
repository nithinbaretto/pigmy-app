import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/validators.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../controller/collection_controller.dart';
import '../model/collection_config.dart';

class CollectionFormScreen extends ConsumerWidget {
  const CollectionFormScreen({super.key, required this.type});

  final CollectionType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = CollectionConfig.forType(type);
    final state = ref.watch(collectionFormControllerProvider(type));
    final controller = ref.read(collectionFormControllerProvider(type).notifier);

    return AppScaffold(
      title: 'New ${config.title}',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: config.accountLabel),
              onChanged: controller.updateAccountNumber,
              validator: Validators.accountNumber,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Customer Name'),
              onChanged: controller.updateCustomerName,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
              onChanged: controller.updateCustomerMobile,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: config.amountLabel),
              keyboardType: TextInputType.number,
              onChanged: controller.updateAmount,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Remarks (optional)'),
              onChanged: controller.updateRemarks,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Save Collection',
              isLoading: state.isSubmitting,
              onPressed: () async {
                final entity = await controller.submit();
                if (entity != null && context.mounted) {
                  context.showSnackBar('Collection saved successfully');
                  context.pop();
                } else if (state.error != null && context.mounted) {
                  context.showSnackBar(state.error!, isError: true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
