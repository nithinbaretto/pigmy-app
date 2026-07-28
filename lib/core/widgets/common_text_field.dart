import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Outlined text field with floating border label — Figma exact style.
class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.readOnly = false,
    this.showVisibilityToggle = false,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool showVisibilityToggle;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool _obscured;
  late final FocusNode _focusNode;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
    _focusNode = FocusNode()..addListener(() => setState(() {}));
    _hasText = widget.controller?.text.isNotEmpty ?? false;
    widget.controller?.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final next = widget.controller?.text.isNotEmpty ?? false;
    if (next != _hasText) setState(() => _hasText = next);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  Color get _borderColor {
    if (_hasText || _focusNode.hasFocus) return AppColors.inputBorderFilled;
    return AppColors.inputBorderEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 12,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.scaffoldBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _borderColor, width: 1),
              ),
              padding: EdgeInsets.fromLTRB(
                16,
                0,
                widget.showVisibilityToggle ? 8 : 16,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      obscureText: _obscured,
                      keyboardType: widget.keyboardType,
                      onChanged: (v) {
                        widget.onChanged?.call(v);
                        setState(() {});
                      },
                      readOnly: widget.readOnly,
                      style: AppTextStyles.inputValue,
                      cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: widget.hint,
                        hintStyle: AppTextStyles.inputHint,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  if (widget.showVisibilityToggle)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      onPressed: () => setState(() => _obscured = !_obscured),
                      icon: SvgPicture.asset(
                        _obscured ? AppAssets.eyeShow : AppAssets.eyeHide,
                        width: 24,
                        height: 24,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 6,
            top: 2,
            child: Container(
              color: AppColors.scaffoldBg,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.label, style: AppTextStyles.inputLabel),
            ),
          ),
        ],
      ),
    );
  }
}
