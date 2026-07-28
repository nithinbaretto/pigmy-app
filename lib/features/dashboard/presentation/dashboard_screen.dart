import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_logo.dart';

/// Figma home "Dashboard" — shown right after login / signup.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    final tiles = [
      _DashItem(
        title: AppStrings.collections,
        iconAsset: AppAssets.iconCollections,
        route: RouteNames.collections,
      ),
      _DashItem(
        title: AppStrings.viewTransactions,
        iconAsset: AppAssets.iconTransactions,
        route: RouteNames.transactions,
      ),
      _DashItem(
        title: AppStrings.bankDetails,
        iconAsset: AppAssets.iconBank,
      ),
      _DashItem(
        title: AppStrings.importFile,
        iconAsset: AppAssets.iconImport,
        route: RouteNames.importFile,
      ),
      _DashItem(
        title: AppStrings.exportFile,
        iconAsset: AppAssets.iconExport,
        route: RouteNames.exportFile,
      ),
      _DashItem(
        title: AppStrings.summary,
        iconAsset: AppAssets.iconSummary,
        route: RouteNames.summary,
      ),
      _DashItem(
        title: AppStrings.detailedSummary,
        iconAsset: AppAssets.iconDetailedSummary,
        route: RouteNames.summary,
      ),
      _DashItem(
        title: AppStrings.reprint,
        iconAsset: AppAssets.iconReprint,
        route: RouteNames.printer,
      ),
      _DashItem(
        title: AppStrings.settings,
        iconAsset: AppAssets.iconSettings,
        route: RouteNames.settings,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.dashboardBg,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom:0,
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _HomeHeader(
              onLogout: () => context.go(RouteNames.login),
            ),
          ),
          Positioned(
            top: 150,
            left: 24,
            right: 24,
            child: _DashboardCard(tiles: tiles)
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.08, end: 0, duration: 400.ms),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: top + 86,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: ColoredBox(
                color: AppColors.primary,
                child: Opacity(
                  opacity: 0.35,
                  child: Transform.flip(
                    flipY: true,
                    child: SvgPicture.asset(
                      AppAssets.dashboardHeaderPattern,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: top + 22,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                AppStrings.appName,
                style: AppTextStyles.dashboardAppBar,
              ),
            ),
          ),
          Positioned(
            top: top + 14,
            right: 24,
            child: IconButton(
              onPressed: onLogout,
              padding: const EdgeInsets.all(8),
              icon: SvgPicture.asset(
                AppAssets.logout,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.tiles});

  final List<_DashItem> tiles;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.dashboard,
                style: AppTextStyles.collectionsTitle,
              ),
              const SizedBox(height: 36),
              SizedBox(
                height: 286,
                child: Column(
                  children: [
                    for (var row = 0; row < 3; row++) ...[
                      if (row > 0)
                        Container(height: 1, color: const Color(0xFFE8E8EE)),
                      Expanded(
                        child: Row(
                          children: [
                            for (var col = 0; col < 3; col++) ...[
                              if (col > 0)
                                Container(
                                  width: 1,
                                  color: const Color(0xFFE8E8EE),
                                ),
                              Expanded(
                                child: _tile(context, tiles[row * 3 + col]),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: -34,
            right: -10,
            child: IgnorePointer(
              child: SizedBox(
                width: 72,
                height: 72,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SvgPicture.asset(
                        AppAssets.hexDeco1,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 28,
                      child: SvgPicture.asset(
                        AppAssets.hexDeco2,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    Positioned(
                      left: 28,
                      top: 14,
                      child: SvgPicture.asset(
                        AppAssets.hexDeco3,
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, _DashItem item) {
    return InkWell(
      onTap: item.route != null
          ? () => context.push(item.route!)
          : () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.title} — coming soon')),
              );
            },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(item.iconAsset, width: 24, height: 24),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: AppTextStyles.collectionTileLabel,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashItem {
  const _DashItem({
    required this.title,
    required this.iconAsset,
    this.route,
  });

  final String title;
  final String iconAsset;
  final String? route;
}
