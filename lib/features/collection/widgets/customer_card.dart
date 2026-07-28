import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Figma Pigmy list row: document icon + account id + name.
class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
    required this.pigmyNumber,
    required this.customerName,
    this.balance,
    this.todayDue,
    this.onTap,
    this.showDivider = true,
  });

  final String pigmyNumber;
  final String customerName;
  final String? balance;
  final String? todayDue;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.document,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pigmyNumber,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.14,
                          height: 1,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        customerName,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          letterSpacing: 0.12,
                          height: 16 / 12,
                          color: const Color(0xFF404040),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFE8E8EE)),
          ),
      ],
    );
  }
}
