import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Horizontal divider with centered text — Figma auth footer style.
class DividerWithText extends StatelessWidget {
  const DividerWithText({
    super.key,
    required this.text,
    this.linkText,
    this.onLinkTap,
    this.trailingText,
  });

  final String text;
  final String? linkText;
  final VoidCallback? onLinkTap;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Divider(
            color: AppColors.dividerMuted,
            thickness: 1,
            height: 1,
          ),
          Container(
            color: AppColors.scaffoldBg,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: linkText != null
                ? GestureDetector(
                    onTap: onLinkTap,
                    behavior: HitTestBehavior.opaque,
                    child: Text.rich(
                      TextSpan(
                        style: AppTextStyles.footerPrompt,
                        children: [
                          TextSpan(text: text),
                          TextSpan(text: ' '),
                          TextSpan(
                            text: linkText,
                            style: AppTextStyles.footerLink,
                          ),
                          if (trailingText != null)
                            TextSpan(text: ' $trailingText'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Text(
                    text,
                    style: AppTextStyles.footerPrompt,
                    textAlign: TextAlign.center,
                  ),
          ),
        ],
      ),
    );
  }
}
