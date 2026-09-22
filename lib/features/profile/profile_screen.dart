import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';

import '../../core/utils/helpers.dart';
import '../../core/utils/cart_store.dart';
import '../../core/utils/user_store.dart';
import '../../shared/widgets/custom_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String _selectedLanguage = 'English / हिंदी / ગુજરાતી';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile & Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ValueListenableBuilder<UserProfileData>(
            valueListenable: UserStore.userNotifier,
            builder: (context, user, _) {
              final ImageProvider? avatarImage = buildAvatarImageProvider(user.photoUrl);

              return CustomCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.softMint,
                      backgroundImage: avatarImage,
                      child: avatarImage == null
                          ? const Text('👨‍🌾', style: TextStyle(fontSize: 32))
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.ownerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(user.petInfo, style: const TextStyle(color: AppColors.primaryDeepGreen, fontWeight: FontWeight.w600, fontSize: 13)),
                          const SizedBox(height: 2),
                          Text(user.phone, style: AppStyles.subtext),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text('Account & Preferences', style: AppStyles.heading3),
          const SizedBox(height: 10),
          CustomCard(
            onTap: () => Navigator.pushNamed(context, AppRoutes.addAnimal),
            child: const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.pets_rounded, color: AppColors.primaryDeepGreen),
              title: Text('My Registered Animals'),
              subtitle: Text('3 Animals (2 Cattle, 1 Dog)'),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
          ),
          const SizedBox(height: 10),
          CustomCard(
            onTap: () {},
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.translate_rounded, color: AppColors.primaryDeepGreen),
              title: const Text('App Language'),
              subtitle: Text(_selectedLanguage),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
          ),
          const SizedBox(height: 10),
          CustomCard(
            onTap: () => Navigator.pushNamed(context, AppRoutes.emergencyHelp),
            child: const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.phone_in_talk_rounded, color: AppColors.emergencyRed),
              title: Text('Emergency Hotline Config'),
              subtitle: Text('1-Tap SOS helpline setup'),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
          ),
          const SizedBox(height: 24),
          CustomCard(
            onTap: () async {
              await UserStore.logoutSession();
              CartStore.clear();
              if (context.mounted) {
                Helpers.showSnackBar(context, 'Logged out successfully.');
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: AppColors.emergencyRed),
                SizedBox(width: 8),
                Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.emergencyRed)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
