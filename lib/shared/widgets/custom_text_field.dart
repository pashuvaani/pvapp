import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? label;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.label,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : AppColors.primaryText;
    final Color labelColor = isDark ? Colors.white : AppColors.primaryText;
    final Color hintColor = isDark ? Colors.white54 : AppColors.secondaryText;
    final Color iconColor = isDark ? Colors.white70 : AppColors.secondaryText;
    final Color fillColor = isDark ? const Color(0xFF1E2D27) : (Theme.of(context).cardTheme.color ?? Colors.white);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppStyles.bodyText.copyWith(fontWeight: FontWeight.w600, color: labelColor),
          ),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          style: AppStyles.bodyText.copyWith(color: textColor),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyles.subtext.copyWith(color: hintColor),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: iconColor, size: 20) : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: AppStyles.inputBorderRadius,
              borderSide: BorderSide(color: isDark ? Colors.white24 : Theme.of(context).dividerColor.withValues(alpha: 0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppStyles.inputBorderRadius,
              borderSide: BorderSide(color: isDark ? Colors.white24 : Theme.of(context).dividerColor.withValues(alpha: 0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppStyles.inputBorderRadius,
              borderSide: const BorderSide(color: AppColors.primaryDeepGreen, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
