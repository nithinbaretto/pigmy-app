import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Figma secondary-screen app bar: purple status strip + white title row.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.showDownload = false,
    this.actions,
    this.onBack,
    this.onDownload,
  });

  final String title;
  final bool showBack;
  final bool showDownload;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final VoidCallback? onDownload;

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: ColoredBox(
        color: AppColors.dashboardBg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: top, color: AppColors.primary),
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    if (showBack)
                      GestureDetector(
                        onTap: onBack ?? () => context.pop(),
                        child: SvgPicture.asset(
                          AppAssets.arrowBack,
                          width: 24,
                          height: 24,
                        ),
                      )
                    else
                      const SizedBox(width: 24),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.appBarTitle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.18,
                          height: 28 / 18,
                        ),
                      ),
                    ),
                    if (actions != null)
                      ...actions!
                    else if (showDownload)
                      GestureDetector(
                        onTap: onDownload,
                        child: SvgPicture.asset(
                          AppAssets.download,
                          width: 24,
                          height: 24,
                        ),
                      )
                    else
                      const SizedBox(width: 24),
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
