import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_text_field.dart';
import '../../../core/widgets/hex_background.dart';

/// Placeholder printer settings — Bluetooth integration in future phase.
class PrinterSettingsScreen extends StatelessWidget {
  const PrinterSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HexBackground(
        child: Column(
          children: [
            const CommonAppBar(title: AppStrings.printerSettings),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Configure your Bluetooth thermal printer.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const CommonTextField(
                      label: 'Bluetooth Address',
                      hint: '00:00:00:00:00:00',
                    ),
                    const SizedBox(height: 16),
                    const CommonTextField(
                      label: 'Printer Name',
                      hint: 'Enter printer name',
                    ),
                    const Spacer(),
                    CommonButton(
                      label: AppStrings.saveBtAddress,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Printer settings saved (mock)'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    CommonButton(
                      label: 'Test Print',
                      isOutlined: true,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Test print — coming in future phase'),
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
