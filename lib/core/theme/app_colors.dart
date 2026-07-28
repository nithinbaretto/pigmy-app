import 'package:flutter/material.dart';

/// Figma design tokens from Pigmy-Final.fig.
class AppColors {
  AppColors._();

  // Surfaces
  static const Color white = Color(0xFFFFFFFF);
  static const Color scaffoldBg = Color(0xFFFAFAFA);
  static const Color dashboardBg = Color(0xFFF5F7FB);

  // Text
  static const Color textDark = Color(0xFF100D2B);
  static const Color textMuted = Color(0xFF6E6D78);
  static const Color placeholder = Color(0xFFB8B7C0);
  static const Color dividerMuted = Color(0xFFB8B7C0);

  // Brand
  static const Color primary = Color(0xFF5A3296);
  static const Color primaryLight = Color(0xFF6C75BD);
  static const Color companyBlue = Color(0xFF3655C2);
  static const Color buttonInactive = Color(0xFFB1BEEE);
  static const Color buttonActive = Color(0xFF5A3296);
  static const Color registerButtonActive = Color(0xFF5A3296);
  static const Color registerButtonInactive = Color(0xFFB1BEEE);
  static const Color linkPurple = Color(0xFF5A3296);
  static const Color statusBarPurple = Color(0xFF5A3296);

  // Inputs
  static const Color inputBorderEmpty = Color(0xFF6E6D78);
  static const Color inputBorderFilled = Color(0xFF100D2B);
  static const Color inputBorderLight = Color(0xFF6E6D78);
  static const Color inputFillLight = Color(0xFFFAFAFA);
  static const Color dividerLight = Color(0xFFB8B7C0);

  // Dashboard / dark surfaces (post-login secondary)
  static const Color black = Color(0xFF000000);
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1A1A2E);
  static const Color surfaceLight = Color(0xFF252540);
  static const Color cardBg = Color(0xFF16162A);

  static const Color secondary = Color(0xFF00B4D8);
  static const Color accent = Color(0xFF48CAE4);
  static const Color gradientStart = Color(0xFF00B4D8);
  static const Color gradientEnd = Color(0xFF0077B6);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0C0);
  static const Color textHint = Color(0xFF6B6B80);

  static const Color border = Color(0xFF2A2A45);
  static const Color divider = Color(0xFF2A2A45);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFEF5350);
  static const Color warning = Color(0xFFFFA726);

  static const Color pigmy = Color(0xFF5A3296);
  static const Color loan = Color(0xFF5A3296);
  static const Color rd = Color(0xFF5A3296);
  static const Color sb = Color(0xFF5A3296);

  static const Color inputFill = Color(0xFF1E1E35);
  static const Color inputBorder = Color(0xFF3A3A55);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF7B5CFA), Color(0xFF5A3FD4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
