import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double leftX = (screenWidth - 120) / 4 - 20;
    double rightX = screenWidth - 60 - (screenWidth - 120) / 4;
    double centerX = screenWidth / 2 - 38; 

    // Default to Consult (1) in center if currentIndex is -1 (Home)
    int centerIndex = (currentIndex == -1) ? 1 : currentIndex;
    
    // Circular assignment to keep order intact (Chat, Consult, Products)
    int leftIndex = (centerIndex - 1) % 3;
    if (leftIndex < 0) leftIndex += 3;
    int rightIndex = (centerIndex + 1) % 3;

    return Container(
      height: 120, // Total height for floating effect
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Background Bar with center notch
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: CustomPaint(
              painter: _BottomNavPainter(backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor ?? Colors.white),
              child: const SizedBox(
                height: 70,
                width: double.infinity,
              ),
            ),
          ),
          
          // Chat Item (0)
          _buildAnimatedItem(
            context,
            itemIndex: 0,
            icon: Icons.chat_outlined,
            label: 'Chat',
            isCenter: centerIndex == 0,
            isLeft: leftIndex == 0,
            leftX: leftX,
            centerX: centerX,
            rightX: rightX,
          ),
          
          // Consult Item (1)
          _buildAnimatedItem(
            context,
            itemIndex: 1,
            icon: Icons.videocam,
            label: 'Consultation',
            isCenter: centerIndex == 1,
            isLeft: leftIndex == 1,
            leftX: leftX,
            centerX: centerX,
            rightX: rightX,
          ),
          
          // Products Item (2)
          _buildAnimatedItem(
            context,
            itemIndex: 2,
            icon: Icons.shopping_bag_outlined,
            label: 'Pashu Raksha',
            isCenter: centerIndex == 2,
            isLeft: leftIndex == 2,
            leftX: leftX,
            centerX: centerX,
            rightX: rightX,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem(
    BuildContext context, {
    required int itemIndex,
    required IconData icon,
    required String label,
    required bool isCenter,
    required bool isLeft,
    required double leftX,
    required double centerX,
    required double rightX,
  }) {
    double xPos = isCenter ? centerX : (isLeft ? leftX : rightX);
    double yPos = isCenter ? 42 : 20; 
    double size = isCenter ? 76 : 70;
    double iconSize = isCenter ? 22 : 24;
    double textSize = isCenter ? 10 : 10;
    Color color = isCenter ? AppColors.primaryDeepGreen : Colors.transparent;
    Color iconColor = isCenter ? Colors.white : Colors.grey;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      bottom: yPos,
      left: xPos,
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!(itemIndex);
          } else {
             if (itemIndex == 0) Navigator.pushReplacementNamed(context, AppRoutes.gopuAi);
             if (itemIndex == 1) Navigator.pushReplacementNamed(context, AppRoutes.consultation);
             if (itemIndex == 2) Navigator.pushReplacementNamed(context, AppRoutes.products);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn,
          width: size,
          height: isCenter ? 76 : 70, 
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(isCenter ? 38 : 20),
            boxShadow: isCenter
                ? [
                    BoxShadow(
                      color: AppColors.primaryDeepGreen.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                child: Icon(
                  icon,
                  key: ValueKey<bool>(isCenter),
                  color: iconColor,
                  size: iconSize,
                ),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: isCenter ? FontWeight.bold : FontWeight.normal,
                    color: iconColor,
                  ),
                  child: Text(label),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavPainter extends CustomPainter {
  final Color backgroundColor;
  _BottomNavPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    const double r = 35; // corner radius of the pill
    final double w = size.width;
    final double h = size.height;
    
    // Top left corner
    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    
    // The curved dip (notch)
    final double cx = w / 2;
    const double nw = 48; // notch half-width
    const double nd = 32; // notch depth
    
    path.lineTo(cx - nw - 10, 0);
    path.quadraticBezierTo(cx - nw, 0, cx - nw + 10, nd * 0.4);
    path.quadraticBezierTo(cx, nd * 1.5, cx + nw - 10, nd * 0.4);
    path.quadraticBezierTo(cx + nw, 0, cx + nw + 10, 0);
    
    // Top right corner
    path.lineTo(w - r, 0);
    path.quadraticBezierTo(w, 0, w, r);
    
    // Bottom right corner
    path.lineTo(w, h - r);
    path.quadraticBezierTo(w, h, w - r, h);
    
    // Bottom left corner
    path.lineTo(r, h);
    path.quadraticBezierTo(0, h, 0, h - r);
    
    path.close();

    // Draw shadow
    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.3), 15, true);
    
    // Draw background
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
