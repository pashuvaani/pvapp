import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';

class HealthRecordDetailScreen extends StatefulWidget {
  const HealthRecordDetailScreen({super.key});

  @override
  State<HealthRecordDetailScreen> createState() => _HealthRecordDetailScreenState();
}

class _HealthRecordDetailScreenState extends State<HealthRecordDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_outlined, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline_rounded, color: Theme.of(context).colorScheme.onSurface),
            tooltip: 'Profile & Settings',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.moreMenu),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Detail Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration( color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
                boxShadow: AppStyles.getBoxShadow(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F7F3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primaryDeepGreen.withValues(alpha: 0.3)),
                        ),
                        child: const Icon(Icons.calendar_today_outlined, color: AppColors.primaryDeepGreen, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Vaccination', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primaryDeepGreen)),
                            const SizedBox(height: 4),
                            Text('Rabies Vaccine', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Theme.of(context).colorScheme.onSurface)),
                          ],
                        ),
                      ),
                      const Text('Completed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primaryDeepGreen)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1, color: Colors.black12),
                  const SizedBox(height: 16),
                  _buildDetailRow('Date', '12 May 2024'),
                  _buildDetailRow('Next Due', '12 May 2025'),
                  _buildDetailRow('Given By', 'Dr. Kiran Bishnoi'),
                  const SizedBox(height: 12),
                  const Text('Notes', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text('Regular annual vaccination', style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('All Records', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 16),
            // History List
            Container(
              decoration: BoxDecoration( color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  _buildHistoryItem(Icons.calendar_today_outlined, 'DHPP Vaccine', '22 Mar 2024', 'Completed'),
                  const Divider(height: 1, indent: 60, endIndent: 20),
                  _buildHistoryItem(Icons.calendar_today_outlined, 'Booster Vaccine', '12 Dec 2023', 'Completed'),
                  const Divider(height: 1, indent: 60, endIndent: 20),
                  _buildHistoryItem(Icons.health_and_safety_outlined, 'Health Checkup', '05 May 2024', 'Normal', statusColor: AppColors.primaryDeepGreen),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(IconData icon, String title, String date, String status, {Color statusColor = AppColors.primaryDeepGreen}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7F3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryDeepGreen.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: AppColors.primaryDeepGreen, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).colorScheme.onSurface)),
                const SizedBox(height: 2),
                Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(status, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: statusColor)),
        ],
      ),
    );
  }
}
