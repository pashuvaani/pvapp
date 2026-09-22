import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _selectedRole = 'Farmer / Livestock Owner';
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final List<String> _roles = [
    'Farmer / Livestock Owner',
    'Pet Parent (Dogs/Cats)',
    'Veterinary Doctor / Para-vet'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Join PashuVaani 🌿', style: AppStyles.heading1),
            const SizedBox(height: 6),
            Text(
              'Select your account type and fill in your details to start tele-vet consultation.',
              style: AppStyles.subtext,
            ),
            const SizedBox(height: 24),
            const Text('Account Type', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _roles.map((role) {
                final isSelected = _selectedRole == role;
                return ChoiceChip(
                  label: Text(role),
                  selected: isSelected,
                  selectedColor: AppColors.softMint,
                  backgroundColor: Theme.of(context).cardTheme.color,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.primaryDeepGreen : AppColors.primaryText,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedRole = role);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Full Name',
              hintText: 'e.g. Ramesh Patel',
              controller: _nameController,
              prefixIcon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Phone Number',
              hintText: '+91 9876543210',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_android_rounded,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Village / City / District',
              hintText: 'e.g. Anand, Gujarat',
              controller: _addressController,
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Register & Continue',
                isGradient: true,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
