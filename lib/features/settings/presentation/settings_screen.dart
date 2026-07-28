import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_logo.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../auth/controller/auth_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBg,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.4,
              child: Transform.flip(
                flipY: true,
                child: Image.asset(
                  AppAssets.bgTop,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 58,
            child: Opacity(
              opacity: 0.3,
              child: Center(child: AuthLogo(width: 111, height: 120)),
            ),
          ),
          Column(
            children: [
              CommonAppBar(
                title: AppStrings.settings,
                showDownload: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.settings,
                        style: AppTextStyles.collectionsTitle,
                      ),
                      const SizedBox(height: 36),
                      _SettingsRow(
                        iconAsset: AppAssets.btAddress,
                        label: AppStrings.saveBtAddress,
                        onTap: () => context.push(RouteNames.printer),
                      ),
                      const SizedBox(height: 36),
                      _SettingsRow(
                        iconAsset: AppAssets.accountCircle,
                        label: AppStrings.admin,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Admin — coming soon'),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 36),
                      _SettingsRow(
                        iconAsset: AppAssets.logout,
                        label: AppStrings.logout,
                        onTap: () async {
                          await ref
                              .read(authControllerProvider.notifier)
                              .logout();
                          if (context.mounted) {
                            context.go(RouteNames.login);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.iconAsset,
    required this.label,
    required this.onTap,
  });

  final String iconAsset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          SvgPicture.asset(iconAsset, width: 24, height: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                letterSpacing: 0.14,
                height: 20 / 14,
              ),
            ),
          ),
          SvgPicture.asset(
            AppAssets.chevronRight,
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
