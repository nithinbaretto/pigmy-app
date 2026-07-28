import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/empty_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/customers_controller.dart';
import '../widgets/customer_card.dart';

class CustomerListScreen extends ConsumerStatefulWidget {
  const CustomerListScreen({super.key});

  @override
  ConsumerState<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends ConsumerState<CustomerListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customerSearchProvider);

    return Scaffold(
      backgroundColor: AppColors.dashboardBg,
      body: Column(
        children: [
          CommonAppBar(
            title: AppStrings.pigmy,
            showDownload: true,
            onDownload: () => context.push(RouteNames.settings),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 4,
                    offset: Offset(0, 0.5),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 4,
                    offset: Offset(0, 0.5),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.search,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: AppStrings.searchPigmy,
                        hintStyle: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12,
                          letterSpacing: 0.12,
                          color: const Color(0xFF777879),
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (q) =>
                          ref.read(customerSearchProvider.notifier).search(q),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: customersAsync.when(
              loading: () => const LoadingWidget(),
              error: (e, _) => Center(child: Text('$e')),
              data: (customers) {
                if (customers.isEmpty) {
                  return const EmptyWidget(message: 'No customers found');
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return CustomerCard(
                      pigmyNumber: customer.pigmyNumber,
                      customerName: customer.customerName,
                      showDivider: index != customers.length - 1,
                      onTap: () => context.push('/collection/${customer.id}'),
                    )
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: 40 * index),
                          duration: 250.ms,
                        );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
