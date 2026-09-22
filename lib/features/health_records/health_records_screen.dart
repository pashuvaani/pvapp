import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../shared/widgets/custom_card.dart';

class HealthRecordsScreen extends StatelessWidget {
  const HealthRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Prescriptions & Lab Reports'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('🐮 Gauri (Holstein Cow)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('14 Aug 2026', style: AppStyles.subtext.copyWith(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                const Text('Doctor: Dr. Ramesh Patel', style: TextStyle(color: AppColors.primaryDeepGreen, fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                const Text('Diagnosis: Mild Bovine Mastitis (Left Quarter)', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('Prescription: Intramammary Antibiotic Infusion + Anti-inflammatory 3 days.', style: AppStyles.subtext),
                const Divider(height: 20),
                Row(
                  children: [
                    const Icon(Icons.picture_as_pdf_rounded, color: AppColors.emergencyRed, size: 20),
                    const SizedBox(width: 8),
                    const Text('Prescription_Gauri_Aug14.pdf', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primaryDeepGreen)),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.download_rounded, color: AppColors.primaryGreen), onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
