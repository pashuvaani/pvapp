import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_card.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  const AppointmentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: AppColors.softMint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: AppColors.primaryDeepGreen, size: 60),
              ),
              const SizedBox(height: 24),
              Text('Appointment Confirmed! 🎉', style: AppStyles.heading1, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'Your video consultation has been scheduled. Doctor and pet details are saved in your appointments tab.',
                style: AppStyles.subtext,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              CustomCard(
                child: Column(
                  children: [
                    _buildRow('Animal', 'Gauri 🐮 (Holstein Cow)'),
                    const Divider(height: 16),
                    _buildRow('Veterinarian', 'Dr. Ramesh Patel'),
                    const Divider(height: 16),
                    _buildRow('Date & Time', 'Tomorrow • 10:30 AM'),
                    const Divider(height: 16),
                    _buildRow('Consultation Fee', '₹350 (Paid)'),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Go To Home Dashboard',
                  isGradient: true,
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppStyles.subtext),
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }
}
