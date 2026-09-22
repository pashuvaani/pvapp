
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../shared/widgets/custom_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Notifications & Reminders'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomCard(
            backgroundColor: AppColors.lightMintBg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: AppColors.freshLimeAccent, shape: BoxShape.circle),
                  child: const Icon(Icons.vaccines_rounded, color: AppColors.primaryDeepGreen, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Vaccination Due Tomorrow 💉', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text('Gauri (Holstein Cow) is due for FMD booster vaccine at 10:00 AM.', style: AppStyles.subtext),
                      const SizedBox(height: 4),
                      const Text('2 hours ago', style: TextStyle(fontSize: 10, color: AppColors.secondaryText)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: AppColors.softMint, shape: BoxShape.circle),
                  child: const Icon(Icons.video_call_rounded, color: AppColors.primaryDeepGreen, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Consultation Confirmed 🩺', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text('Dr. Ramesh Patel accepted your appointment for tomorrow 10:30 AM.', style: AppStyles.subtext),
                      SizedBox(height: 4),
                      Text('Yesterday', style: TextStyle(fontSize: 10, color: AppColors.secondaryText)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
