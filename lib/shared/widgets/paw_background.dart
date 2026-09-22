import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class PawBackground extends StatelessWidget {
  final Widget child;

  const PawBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.softMint,
            AppColors.mediumLightGreen,
          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background elements
          Positioned(
            top: 50, left: 30,
            child: Transform.rotate(
              angle: -0.2,
              child: Icon(Icons.pets, size: 60, color: AppColors.primaryDeepGreen.withValues(alpha: 0.12)),
            ),
          ),
          Positioned(
            top: 120, right: -10,
            child: Transform.rotate(
              angle: 0.3,
              child: Icon(Icons.pets, size: 100, color: AppColors.primaryDeepGreen.withValues(alpha: 0.10)),
            ),
          ),
          Positioned(
            top: 300, left: -20,
            child: Transform.rotate(
              angle: 0.1,
              child: Icon(Icons.pets, size: 80, color: AppColors.primaryDeepGreen.withValues(alpha: 0.10)),
            ),
          ),
          Positioned(
            top: 400, right: 40,
            child: Transform.rotate(
              angle: -0.4,
              child: Icon(Icons.pets, size: 50, color: AppColors.primaryDeepGreen.withValues(alpha: 0.15)),
            ),
          ),
          Positioned(
            bottom: 100, left: 40,
            child: Transform.rotate(
              angle: 0.2,
              child: Icon(Icons.pets, size: 70, color: AppColors.primaryDeepGreen.withValues(alpha: 0.12)),
            ),
          ),
          Positioned(
            bottom: -20, right: 10,
            child: Transform.rotate(
              angle: -0.1,
              child: Icon(Icons.pets, size: 120, color: AppColors.primaryDeepGreen.withValues(alpha: 0.10)),
            ),
          ),
          // Content
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
