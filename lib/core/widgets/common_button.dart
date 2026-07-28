import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.isEnabled = true,
    this.activeColor,
    this.inactiveColor,
    this.width,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final bool isEnabled;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? width;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return SizedBox(
        width: width ?? double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.linkPurple,
            backgroundColor: AppColors.scaffoldBg,
            side: const BorderSide(color: AppColors.primary, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          ),
          child: Text(label, style: AppTextStyles.buttonOutlined),
        ),
      );
    }

    final effectiveActive = activeColor ?? AppColors.buttonActive;
    final effectiveInactive = inactiveColor ?? AppColors.buttonInactive;
    final canPress = isEnabled && !isLoading && onPressed != null;
    final bgColor = canPress ? effectiveActive : effectiveInactive;

    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: canPress ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          disabledBackgroundColor: effectiveInactive,
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : _buildLabel(),
      ),
    );
  }

  Widget _buildLabel() {
    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.button),
        ],
      );
    }
    return Text(label, style: AppTextStyles.button);
  }
}
