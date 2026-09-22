import 'package:flutter/material.dart';
import '../../features/home/home_screen.dart';
import '../../features/gopu_ai/chat_screen.dart';
import '../../features/products/products_screen.dart';
import '../../features/consultation/consultation_screen.dart';
import '../../shared/components/bottom_nav_bar.dart';
import '../../core/routes/app_routes.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;
  const MainLayout({super.key, this.initialIndex = 3}); // 0: Chat, 1: Consult, 2: Products, 3: Home

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavTapped(int index) {
    // If they click the exact tab they are on, do nothing
    if (index == _currentIndex) return;
    
    // Animate to the new page for that "smooth slide" effect!
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600), // Slower, more elegant duration
      curve: Curves.fastOutSlowIn, // Smoother material deceleration curve
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Bottom nav bar expects -1 for home, 0 for chat, 1 for consult, 2 for products
    int bottomNavIndex = _currentIndex;
    if (_currentIndex == 3) bottomNavIndex = -1;

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe if you only want button clicks
        children: const [
          GopuChatScreen(),
          ConsultationScreen(),
          ProductsScreen(),
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: _currentIndex != 0
          ? CustomBottomNavBar(
              currentIndex: bottomNavIndex,
              onTap: _onNavTapped,
            )
          : null,
    );
  }
}
