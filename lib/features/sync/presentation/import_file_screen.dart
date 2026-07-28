import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/hex_background.dart';

/// Placeholder import file screen — file import in future offline phase.
class ImportFileScreen extends StatelessWidget {
  const ImportFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HexBackground(
        child: Column(
          children: [
            const CommonAppBar(title: AppStrings.importFile),
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
                        border: Border.all(
                          color: AppColors.border,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 64,
                            color: AppColors.primary.withValues(alpha: 0.6),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Import Customer File',
                            style: AppTextStyles.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Select a customer file to import.\nExisting customers will be preserved.',
                            style: AppTextStyles.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CommonButton(
                      label: 'Browse File',
                      icon: Icons.folder_open,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('File import — coming in future phase'),
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
