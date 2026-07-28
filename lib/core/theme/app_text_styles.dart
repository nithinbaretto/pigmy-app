import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Typography matching Figma Pigmy-Final (weights / sizes).
/// Uses the platform default sans-serif to avoid google_fonts + path_provider.
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle inputHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.placeholder,
  );

  static const TextStyle inputValue = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle buttonOutlined = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.linkPurple,
  );

  static const TextStyle link = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.linkPurple,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.linkPurple,
  );

  static const TextStyle companyName = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    color: AppColors.companyBlue,
  );

  static const TextStyle tagline = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.companyBlue,
  );

  static const TextStyle registerTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textDark,
  );

  static const TextStyle footerPrompt = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle footerLink = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.linkPurple,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.linkPurple,
  );

  static const TextStyle dashboardAppBar = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  static const TextStyle collectionsTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: 0.16,
  );

  static const TextStyle collectionTileLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    height: 16 / 12,
  );
}
