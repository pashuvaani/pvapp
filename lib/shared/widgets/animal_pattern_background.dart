import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'dart:math';

class AnimalPatternBackground extends StatelessWidget {
  final Widget child;
  final bool useGradient;

  const AnimalPatternBackground({
    super.key,
    required this.child,
    this.useGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Make paw prints minimal dark and neat
    final Color pawColor = isDark ? const Color(0xFF3A4B45) : const Color(0xFF4A5D57); 
    final double opacity = isDark ? 0.20 : 0.15; 
    
    // Hardcoded, well-spaced positions for a neat, non-congested pattern
    final List<Map<String, double>> pawConfigs = [
      {'size': 60.0, 'left': 0.10, 'top': 0.12, 'rot': -0.3},
      {'size': 45.0, 'left': 0.80, 'top': 0.18, 'rot': 0.4},
      {'size': 70.0, 'left': 0.15, 'top': 0.45, 'rot': 0.2},
      {'size': 50.0, 'left': 0.85, 'top': 0.52, 'rot': -0.4},
      {'size': 80.0, 'left': 0.08, 'top': 0.80, 'rot': -0.2},
      {'size': 55.0, 'left': 0.75, 'top': 0.85, 'rot': 0.3},
    ];
    
    final List<Widget> paws = pawConfigs.map((config) {
      return Positioned(
        left: MediaQuery.of(context).size.width * config['left']!,
        top: MediaQuery.of(context).size.height * config['top']!,
        child: Transform.rotate(
          angle: config['rot']!,
          child: Opacity(
            opacity: opacity,
            child: Icon(Icons.pets, size: config['size'], color: pawColor),
          ),
        ),
      );
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: useGradient ? null : Theme.of(context).scaffoldBackgroundColor,
        gradient: useGradient
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.softMint,
                  AppColors.mediumLightGreen,
                ],
              )
            : null,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IgnorePointer(
            child: Stack(children: paws),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
