import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../shared/widgets/custom_card.dart';

class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Vaccination Tracker'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomCard(
            backgroundColor: AppColors.lightMintBg,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: AppColors.freshLimeAccent, shape: BoxShape.circle),
                  child: const Icon(Icons.notifications_active_rounded, color: AppColors.primaryDeepGreen),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Vaccine Alert 💉', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('FMD Booster Vaccine is due in 5 days for Gauri 🐮', style: AppStyles.subtext),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Immunization Schedule', style: AppStyles.heading2),
          const SizedBox(height: 12),
          _buildVaccineItem('Foot & Mouth Disease (FMD)', 'Due: 31 Aug 2026', 'Pending', true),
          _buildVaccineItem('Haemorrhagic Septicaemia (HS)', 'Done: 15 May 2026', 'Completed', false),
          _buildVaccineItem('Black Quarter (BQ)', 'Done: 10 Jan 2026', 'Completed', false),
        ],
      ),
    );
  }

  Widget _buildVaccineItem(String name, String date, String status, bool isDue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CustomCard(
        child: Row(
          children: [
            Icon(
              isDue ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
              color: isDue ? AppColors.emergencyRed : AppColors.primaryGreen,
              size: 26,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(date, style: AppStyles.subtext),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isDue ? const Color(0xFFFDE8E8) : AppColors.softMint,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDue ? AppColors.emergencyRed : AppColors.primaryDeepGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
