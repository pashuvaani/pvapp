import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_card.dart';

class VetProfileScreen extends StatelessWidget {
  const VetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Doctor Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: AppColors.softMint,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('👨‍⚕️', style: TextStyle(fontSize: 50)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.verified_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text('Dr. Ramesh Patel', style: AppStyles.heading1),
            Text('B.V.Sc & A.H, M.V.Sc (Livestock Medicine)', style: AppStyles.subtext),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.softMint,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Cattle & Dairy Specialist', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('14+ Yrs', 'Experience'),
                _buildStat('4.9 ⭐', 'Rating'),
                _buildStat('1,240+', 'Consults'),
              ],
            ),
            const SizedBox(height: 24),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('About Doctor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    'Senior Veterinary Officer with 14+ years of expertise in bovine reproduction, mastitis management, and infectious livestock diseases. Formerly Associate Professor at Anand Veterinary College.',
                    style: AppStyles.bodyText,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Clinic Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text('📍 Anand Veterinary College Campus, Anand, Gujarat', style: AppStyles.bodyText),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Book Video Consultation • ₹350',
                isGradient: true,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.appointmentBooking),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
        Text(label, style: AppStyles.subtext),
      ],
    );
  }
}
