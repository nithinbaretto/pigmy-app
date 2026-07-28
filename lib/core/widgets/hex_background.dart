import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';

/// Figma hex-pattern background.
/// Bottom uses the same top asset flipped 180° — matches Figma `rotate-180`.
class HexBackground extends StatelessWidget {
  const HexBackground({
    super.key,
    this.showTop = true,
    this.showBottom = false,
    this.backgroundColor = AppColors.scaffoldBg,
    this.child,
  });

  final bool showTop;
  final bool showBottom;
  final Color backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showTop)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _HexBanner(flipped: false),
            ),
          if (showBottom)
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _HexBanner(flipped: true),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class _HexBanner extends StatelessWidget {
  const _HexBanner({required this.flipped});

  final bool flipped;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      AppAssets.bgTop,
      width: double.infinity,
      fit: BoxFit.fitWidth,
      alignment: flipped ? Alignment.bottomCenter : Alignment.topCenter,
      filterQuality: FilterQuality.high,
    );

    return flipped ? Transform.flip(flipY: true, child: image) : image;
  }
}
