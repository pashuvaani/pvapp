import 'package:flutter/material.dart';
import '../../shared/widgets/doctor_profile_dialog.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
      'name': 'Dr. Kiran Bishnoi',
      'title': 'Canine & Feline Medicine',
      'rating': '4.8 (100+ reviews)',
      'image': 'assets/images/doctors/dr_ananya_photo.png',
      'experience': '1',
      'consultation_fee': '199',
      'availability': 'Available',
      'languages': 'English, Hindi',
      'description': 'Dr. Kiran Bishnoi is a compassionate veterinary professional focused on delivering attentive, reliable, and animal-centered care with empathy and precision.',
    };

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.6),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: DoctorProfileDialog(doctor: args),
          ),
        ),
      ),
    );
  }
}
