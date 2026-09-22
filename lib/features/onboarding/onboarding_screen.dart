import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/animal_pattern_background.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/images/gopu/gopu_hi.jpeg',
      'title': 'Meet Gopu AI Assistant',
      'desc': 'Instant 24/7 symptom diagnosis & milk yield guidance for your cattle and pets in your regional language.',
    },
    {
      'image': 'assets/images/doctors/dr_ananya_photo.png',
      'title': 'Certified Tele-Vet Consults',
      'desc': 'Connect with experienced Livestock Vets & Surgeons via live 1-on-1 video call in under 3 minutes.',
    },
    {
      'icon': Icons.assignment_turned_in_rounded,
      'title': 'Digital Animal Health Passports',
      'desc': 'Track RFID ear tags, vaccination schedules, lab reports, and order genuine veterinary supplements.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimalPatternBackground(
        useGradient: true,
        child: SafeArea(
          child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                child: const Text('Skip', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            gradient: AppColors.mintCardGradient,
                            shape: BoxShape.circle,
                            boxShadow: [AppStyles.cardShadow],
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: page.containsKey('image')
                              ? Image.asset(page['image'], fit: BoxFit.cover)
                              : Icon(page['icon'], size: 72, color: AppColors.primaryDeepGreen),
                        ),
                        const SizedBox(height: 36),
                        Text(page['title']!, style: AppStyles.heading1, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        Text(
                          page['desc']!,
                          style: AppStyles.subtext.copyWith(fontSize: 15, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i ? AppColors.primaryDeepGreen : Theme.of(context).dividerColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                  isGradient: true,
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
