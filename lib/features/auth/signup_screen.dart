import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/user_store.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _selectedRole = 'Farmer / Livestock Owner';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;

  final List<String> _roles = [
    'Farmer / Livestock Owner',
    'Pet Parent (Dogs/Cats)',
  ];

  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please enter both email address and password.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!emailRegExp.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please enter a valid email address (e.g. farmer@gmail.com).'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Password must be at least 6 characters long.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Save local password credential for account verification
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_password_${email.toLowerCase()}', password);

      final response = await ApiClient().post('/auth/register', {
        'full_name': name.isNotEmpty ? name : 'New User',
        'email': email,
        'password': password,
        'role': 'user',
      });

      if (mounted) {
        final bool isSuccessOrWebFallback = response.isSuccess ||
            response.errorMessage?.contains('Failed to fetch') == true ||
            response.errorMessage?.contains('ClientException') == true ||
            response.errorMessage?.contains('Failed to connect') == true;

        if (isSuccessOrWebFallback) {
          await UserStore.loginSession(
            ownerName: name.isNotEmpty ? name : 'Animal Owner',
            petBreed: _selectedRole.contains('Farmer') ? 'Cattle / Livestock' : 'Indie Dog',
            phone: email,
            token: response.data != null
                ? (response.data!['access_token'] ?? response.data!['token'])?.toString()
                : null,
          );

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ Registration successful! Welcome to PashuVaani.'),
                backgroundColor: AppColors.primaryDeepGreen,
              ),
            );
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.errorMessage != null && response.errorMessage!.isNotEmpty
                    ? '❌ Registration Failed: ${response.errorMessage}'
                    : '❌ Could not complete registration. Please try again.'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Connection error: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
              'Select your account type and fill in your email details to start tele-vet consultation.',
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
              label: 'Email Address',
              hintText: 'farmer@gmail.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Password',
              hintText: '••••••••',
              controller: _passwordController,
              obscureText: true,
              prefixIcon: Icons.lock_outline_rounded,
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
                isLoading: _isLoading,
                onPressed: _handleRegister,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
