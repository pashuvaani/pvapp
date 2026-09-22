import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool hasBorder;
  final bool hasShadow;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.hasBorder = true,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardTheme.color,
        borderRadius: AppStyles.cardBorderRadius,
        border: hasBorder
            ? Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryDeepGreen.withValues(alpha: 0.5)
                    : Theme.of(context).dividerColor.withValues(alpha: 0.1),
                width: 1)
            : null,
        boxShadow: hasShadow ? AppStyles.getBoxShadow(context) : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: AppStyles.cardBorderRadius,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
