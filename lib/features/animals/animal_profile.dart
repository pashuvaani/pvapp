import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/components/animal_avatar.dart';
import '../../shared/widgets/custom_card.dart';

class AnimalProfileScreen extends StatelessWidget {
  const AnimalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Animal Passport Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  AnimalAvatar(species: 'Cow', radius: 44, isSelected: true),
                  SizedBox(height: 12),
                  Text('Gauri 🐮', style: AppStyles.heading1),
                  Text('Holstein Friesian Breed • 4 Years Old', style: AppStyles.subtext),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomCard(
              child: Column(
                children: [
                  _buildDetailRow('RFID / Tag Number', 'IN-GUJ-8849-2041'),
                  const Divider(height: 20),
                  _buildDetailRow('Body Weight', '420 kg'),
                  const Divider(height: 20),
                  _buildDetailRow('Gender & Lactation', 'Female • Lactating (Phase 2)'),
                  const Divider(height: 20),
                  _buildDetailRow('Daily Milk Yield', '18.5 Liters/Day'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Medical History Timeline', style: AppStyles.heading2),
            const SizedBox(height: 12),
            CustomCard(
              onTap: () => Navigator.pushNamed(context, AppRoutes.healthRecords),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.softMint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.receipt_long_rounded, color: AppColors.primaryDeepGreen),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Health Records & Prescriptions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('2 past consultations & lab reports available', style: AppStyles.subtext),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.secondaryText),
                ],
              ),
            ),
            const SizedBox(height: 12),
            CustomCard(
              onTap: () => Navigator.pushNamed(context, AppRoutes.vaccination),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.softMint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.vaccines_rounded, color: AppColors.primaryDeepGreen),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vaccination Tracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('FMD Booster (Due in 5 days)', style: TextStyle(color: AppColors.emergencyRed, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.secondaryText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppStyles.subtext),
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
