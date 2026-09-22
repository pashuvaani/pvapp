import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/helpers.dart';
import '../../core/utils/cart_store.dart';
import '../../core/utils/user_store.dart';
import '../../services/theme_service.dart';

class MoreMenuScreen extends StatefulWidget {
  const MoreMenuScreen({super.key});

  @override
  State<MoreMenuScreen> createState() => _MoreMenuScreenState();
}

class _MoreMenuScreenState extends State<MoreMenuScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo/logopsv.png',
          height: 32,
          width: 32,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeService().themeMode,
              builder: (context, mode, _) {
                return Icon(
                  mode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                );
              },
            ),
            onPressed: () => ThemeService().toggleTheme(),
          ),
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          IconButton(
            icon: Icon(Icons.person_outline_rounded, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfile),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile & More', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface)),
              const SizedBox(height: 16),
              ValueListenableBuilder<UserProfileData>(
                valueListenable: UserStore.userNotifier,
                builder: (context, user, _) {
                  final ImageProvider? avatarImage = buildAvatarImageProvider(user.photoUrl);

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: AppColors.softMint,
                          backgroundImage: avatarImage,
                          child: avatarImage == null
                              ? Icon(Icons.pets, size: 30, color: Theme.of(context).primaryColor)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.ownerName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                              const SizedBox(height: 4),
                              Text(user.petInfo, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                              const SizedBox(height: 4),
                              Text(user.phone, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, color: AppColors.primaryDeepGreen),
                              onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfile),
                            ),
                            const Text('Edit', style: TextStyle(fontSize: 12, color: AppColors.primaryDeepGreen)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration( color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppStyles.getBoxShadow(context),
                  border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.05)),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.health_and_safety_outlined, 'Health Records', () => Navigator.pushNamed(context, AppRoutes.healthRecords)),
                    _buildDivider(),
                    _buildMenuItem(Icons.emergency_outlined, 'Emergency Help', () => Navigator.pushNamed(context, AppRoutes.emergencyHelp)),
                    _buildDivider(),
                    _buildMenuItem(Icons.lightbulb_outline, 'Pet Care Tips', () => Navigator.pushNamed(context, AppRoutes.petCareTips)),
                    _buildDivider(),
                    _buildMenuItem(Icons.play_circle_outline, 'Articles & Videos', () => Navigator.pushNamed(context, AppRoutes.articlesVideos)),
                    _buildDivider(),
                    _buildMenuItem(Icons.help_outline, 'FAQs', () => Navigator.pushNamed(context, AppRoutes.faqs)),
                    _buildDivider(),
                    _buildMenuItem(Icons.info_outline, 'About Us', () => Navigator.pushNamed(context, AppRoutes.aboutUs)),
                    _buildDivider(),
                    _buildMenuItem(Icons.auto_stories_outlined, 'Founders Stories', () => Navigator.pushNamed(context, AppRoutes.foundersStories)),
                    _buildDivider(),
                    _buildMenuItem(Icons.verified_outlined, 'Accreditations', () => Navigator.pushNamed(context, AppRoutes.accreditations)),
                    _buildDivider(),
                    _buildMenuItem(Icons.phone_outlined, 'Contact Us', () => Navigator.pushNamed(context, AppRoutes.contactUs)),
                    _buildDivider(),
                    _buildMenuItem(Icons.chat_bubble_outline, 'Feedback', () => Navigator.pushNamed(context, AppRoutes.feedback)),
                    _buildDivider(),
                    _buildMenuItem(Icons.settings_outlined, 'Settings', () => Navigator.pushNamed(context, AppRoutes.settings)),
                    _buildDivider(),
                    _buildMenuItem(Icons.logout_rounded, 'Log Out', () async {
                      await UserStore.logoutSession();
                      CartStore.clear();
                      if (context.mounted) {
                        Helpers.showSnackBar(context, 'Logged out successfully.');
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                      }
                    }, showBorder: false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.gopuAi, (route) => false),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Need help right now?', style: TextStyle(fontSize: 14, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.w600)),
                            SizedBox(height: 4),
                            Text('Chat with Gopu AI', style: TextStyle(fontSize: 18, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return const RadialGradient(
                              center: Alignment.center,
                              radius: 0.5,
                              colors: [Colors.black, Colors.transparent],
                              stops: [0.7, 1.0],
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.asset('assets/images/gopu/gopu_hi.jpeg', fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Theme.of(context).dividerColor.withValues(alpha: 0.05), indent: 56, endIndent: 20);
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool showBorder = true}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7), size: 22),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface))),
            const Icon(Icons.chevron_right, color: Colors.black38, size: 20),
          ],
        ),
      ),
    );
  }
}
