import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/hex_background.dart';

/// Placeholder export file screen — transaction export in future offline phase.
class ExportFileScreen extends StatelessWidget {
  const ExportFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HexBackground(
        child: Column(
          children: [
            const CommonAppBar(title: AppStrings.exportFile),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.cloud_download_outlined,
                            size: 64,
                            color: AppColors.secondary.withValues(alpha: 0.6),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Export Transaction File',
                            style: AppTextStyles.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Generate a transaction file from locally saved collections.',
                            style: AppTextStyles.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CommonButton(
                      label: 'Generate & Export',
                      icon: Icons.file_download_outlined,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('File export — coming in future phase'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
