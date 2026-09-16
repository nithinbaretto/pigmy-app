import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_logo.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_text_field.dart';
import '../../../core/widgets/divider_with_text.dart';
import '../../../core/widgets/hex_background.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
    super.dispose();
  }

  bool get _isFormFilled =>
      _usernameController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty;

  Future<void> _handleLogin() async {
    if (!_isFormFilled) return;
    final success = await ref.read(authControllerProvider.notifier).login();
    if (!mounted) return;
    if (success) {
      context.go(RouteNames.dashboard);
      return;
    }
    final message = ref.read(authControllerProvider).errorMessage;
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: HexBackground(
        showTop: true,
        showBottom: false,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 16 + bottomInset),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 16 - bottomInset,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        const AuthLogo()
                            .animate()
                            .fadeIn(duration: 400.ms),
                        const SizedBox(height: 96),
                        Text(
                          AppStrings.loginTitle,
                          style: AppTextStyles.headlineMedium,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
                        const SizedBox(height: 36),
                        CommonTextField(
                          label: AppStrings.username,
                          hint: AppStrings.enterUsername,
                          controller: _usernameController,
                          onChanged: (v) {
                            controller.updateUsername(v);
                            setState(() {});
                          },
                        ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
                        const SizedBox(height: 16),
                        CommonTextField(
                          label: AppStrings.password,
                          hint: AppStrings.enterPassword,
                          controller: _passwordController,
                          obscureText: true,
                          showVisibilityToggle: true,
                          onChanged: (v) {
                            controller.updatePassword(v);
                            setState(() {});
                          },
                        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              AppStrings.forgotPassword,
                              style: AppTextStyles.link,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        CommonButton(
                          label: AppStrings.login,
                          isLoading: state.isLoading,
                          isEnabled: _isFormFilled,
                          onPressed: _handleLogin,
                        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
                        const Spacer(),
                        const SizedBox(height: 24),
                        DividerWithText(text: AppStrings.registerPrompt)
                            .animate()
                            .fadeIn(delay: 500.ms, duration: 400.ms),
                        const SizedBox(height: 16),
                        CommonButton(
                          label: AppStrings.registerLink,
                          isOutlined: true,
                          onPressed: () => context.push(RouteNames.register),
                        ).animate().fadeIn(delay: 550.ms, duration: 400.ms),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
