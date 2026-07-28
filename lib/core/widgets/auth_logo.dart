import 'package:flutter/material.dart';

import '../constants/app_assets.dart';

/// iPoll logo from Figma — 72×78 frame with logo mark inside.
class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, this.width = 72, this.height = 78});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Image.asset(
          AppAssets.logo,
          width: width * 0.4,
          height: height * 0.81,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
