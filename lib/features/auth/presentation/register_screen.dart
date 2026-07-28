import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_logo.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_text_field.dart';
import '../../../core/widgets/divider_with_text.dart';
import '../../../core/widgets/hex_background.dart';
import '../../../core/widgets/success_banner.dart';
import '../controller/register_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    await ref.read(registerControllerProvider.notifier).register();
    final showSuccess = ref.read(registerControllerProvider).showSuccess;
    if (showSuccess && mounted) {
      await Future<void>.delayed(const Duration(seconds: 2));
      if (mounted) context.go(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: HexBackground(
        showTop: true,
        showBottom: false,
        child: Stack(
          children: [
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding:
                        EdgeInsets.fromLTRB(24, 8, 24, 16 + bottomInset),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 16 - bottomInset,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: _BackButton(onTap: () => context.pop()),
                            ),
                            const SizedBox(height: 10),
                            const AuthLogo()
                                .animate()
                                .fadeIn(duration: 400.ms),
                            const SizedBox(height: 96),
                            Text(
                              AppStrings.registerTitle,
                              style: AppTextStyles.registerTitle,
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(duration: 400.ms),
                            const SizedBox(height: 30),
                            CommonTextField(
                              label: AppStrings.username,
                              hint: AppStrings.enterUsername,
                              controller: _usernameController,
                              onChanged: controller.updateUsername,
                            ).animate().fadeIn(
                                  delay: 100.ms,
                                  duration: 400.ms,
                                ),
                            const SizedBox(height: 16),
                            CommonTextField(
                              label: AppStrings.password,
                              hint: AppStrings.enterPassword,
                              controller: _passwordController,
                              obscureText: true,
                              showVisibilityToggle: true,
                              onChanged: controller.updatePassword,
                            ).animate().fadeIn(
                                  delay: 200.ms,
                                  duration: 400.ms,
                                ),
                            const SizedBox(height: 16),
                            CommonTextField(
                              label: state.confirmLabel,
                              hint: AppStrings.confirmPassword,
                              controller: _confirmController,
                              obscureText: true,
                              showVisibilityToggle: true,
                              onChanged: controller.updateConfirmPassword,
                            ).animate().fadeIn(
                                  delay: 300.ms,
                                  duration: 400.ms,
                                ),
                            const SizedBox(height: 28),
                            CommonButton(
                              label: AppStrings.createAccount,
                              isLoading: state.isLoading,
                              isEnabled: state.isFormValid,
                              onPressed: _handleRegister,
                            ).animate().fadeIn(
                                  delay: 400.ms,
                                  duration: 400.ms,
                                ),
                            const Spacer(),
                            const SizedBox(height: 24),
                            DividerWithText(
                              text: AppStrings.loginPrompt,
                              linkText: 'Login',
                              trailingText: 'here',
                              onLinkTap: () => context.go(RouteNames.login),
                            ).animate().fadeIn(
                                  delay: 500.ms,
                                  duration: 400.ms,
                                ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (state.showSuccess)
              Positioned(
                top: MediaQuery.paddingOf(context).top + 8,
                left: 20,
                right: 20,
                child: SuccessBanner(message: AppStrings.registrationSuccess)
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: -0.3, end: 0, duration: 300.ms),
              ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: SvgPicture.asset(
              AppAssets.arrowBack,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}
