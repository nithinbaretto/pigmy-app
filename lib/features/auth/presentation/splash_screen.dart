import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_logo.dart';
import '../../../core/widgets/hex_background.dart';

/// Splash screen — Figma Splash 3 (logo + company name + tagline).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) context.go(RouteNames.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: HexBackground(
        showTop: true,
        showBottom: true,
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 5),
              const AuthLogo()
                  .animate()
                  .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                  .scale(
                    begin: const Offset(0.7, 0.7),
                    end: const Offset(1, 1),
                    duration: 800.ms,
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 24),
              Text(
                AppStrings.companyName,
                style: AppTextStyles.companyName,
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, duration: 600.ms),
              const SizedBox(height: 12),
              Text(
                AppStrings.companyTagline,
                style: AppTextStyles.tagline,
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 700.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, duration: 600.ms),
              const Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }
}
