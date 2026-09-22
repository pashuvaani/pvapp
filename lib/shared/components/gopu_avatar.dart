import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class GopuAvatar extends StatelessWidget {
  final double radius;
  final bool showBadge;

  const GopuAvatar({
    super.key,
    this.radius = 24.0,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(radius * 0.15),
          decoration: const BoxDecoration(
            gradient: AppColors.brandAccentGradient,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.softMint,
            child: Text(
              '🐮',
              style: TextStyle(fontSize: radius * 1.1),
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.freshLimeAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bolt_rounded, size: 10, color: AppColors.primaryDeepGreen),
            ),
          ),
      ],
    );
  }
}
