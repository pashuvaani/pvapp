import 'package:flutter/material.dart';

class BlinkingEmergencyIcon extends StatefulWidget {
  final VoidCallback onTap;
  
  const BlinkingEmergencyIcon({super.key, required this.onTap});

  @override
  State<BlinkingEmergencyIcon> createState() => _BlinkingEmergencyIconState();
}

class _BlinkingEmergencyIconState extends State<BlinkingEmergencyIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 800)
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final glowValue = Tween<double>(begin: 0.1, end: 0.8).animate(_controller).value;
        final iconOpacity = Tween<double>(begin: 0.5, end: 1.0).animate(_controller).value;
        
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: glowValue),
                  blurRadius: 15,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Opacity(
              opacity: iconOpacity,
              child: IconButton(
                icon: const Icon(Icons.emergency_share, color: Colors.red),
                iconSize: 20,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                onPressed: widget.onTap,
                tooltip: 'Emergency Help',
              ),
            ),
          ),
        );
      },
    );
  }
}
