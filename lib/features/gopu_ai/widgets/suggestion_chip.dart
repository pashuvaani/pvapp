import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SuggestionChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SuggestionChipWidget({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: AppColors.softMint,
      side: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      label: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.w600)),
      onPressed: onTap,
    );
  }
}
