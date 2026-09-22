import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class PetAvatar extends StatelessWidget {
  final String species;
  final double radius;
  final bool isSelected;

  const PetAvatar({
    super.key,
    required this.species,
    this.radius = 28.0,
    this.isSelected = false,
  });

  String _getEmoji(String speciesName) {
    final lower = speciesName.toLowerCase();
    if (lower.contains('dog')) return '🐶';
    if (lower.contains('cat')) return '🐱';
    if (lower.contains('cow') || lower.contains('cattle')) return '🐮';
    if (lower.contains('buffalo')) return '🦬';
    if (lower.contains('goat') || lower.contains('sheep')) return '🐐';
    if (lower.contains('poultry') || lower.contains('chicken')) return '🐔';
    if (lower.contains('horse')) return '🐴';
    return '🐾';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.freshLimeAccent : Theme.of(context).dividerColor.withValues(alpha: 0.1),
          width: isSelected ? 3 : 1.5,
        ),
        boxShadow: isSelected ? AppStyles.getBoxShadow(context) : null,
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: isSelected ? AppColors.softMint : AppColors.lightMintBg,
        child: Text(
          _getEmoji(species),
          style: TextStyle(fontSize: radius * 0.9),
        ),
      ),
    );
  }
}
