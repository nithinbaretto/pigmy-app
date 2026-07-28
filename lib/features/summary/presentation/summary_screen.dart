import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/common_card.dart';
import '../../../core/widgets/hex_background.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/summary_controller.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(summaryProvider);

    return Scaffold(
      body: HexBackground(
        child: Column(
          children: [
            const CommonAppBar(title: AppStrings.summary),
            Expanded(
              child: summaryAsync.when(
                loading: () => const LoadingWidget(),
                error: (e, _) => Center(child: Text('$e')),
                data: (summary) {
                  final cards = [
                    _SummaryCardData(
                      title: AppStrings.todayCollection,
                      value: AppFormatters.currency(summary.todayCollection),
                      icon: Icons.today_outlined,
                      color: AppColors.primary,
                    ),
                    _SummaryCardData(
                      title: AppStrings.collectedAmount,
                      value: AppFormatters.currency(summary.collectedAmount),
                      icon: Icons.check_circle_outline,
                      color: AppColors.success,
                    ),
                    _SummaryCardData(
                      title: AppStrings.pending,
                      value: AppFormatters.currency(summary.pending),
                      icon: Icons.pending_outlined,
                      color: AppColors.warning,
                    ),
                    _SummaryCardData(
                      title: AppStrings.customersVisited,
                      value: '${summary.customersVisited} / ${summary.totalCustomers}',
                      icon: Icons.people_outline,
                      color: AppColors.secondary,
                    ),
                  ];

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cards.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return CommonCard(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: card.color.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(card.icon, color: card.color),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(card.title, style: AppTextStyles.bodySmall),
                                  const SizedBox(height: 4),
                                  Text(card.value, style: AppTextStyles.titleLarge),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 100 * index),
                            duration: 400.ms,
                          )
                          .slideY(begin: 0.1, duration: 400.ms);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCardData {
  const _SummaryCardData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
}
