import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // Brand Logo / Icon Header
              Center(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: const BoxDecoration(
                    gradient: AppColors.brandSignatureGradient,
                    shape: BoxShape.circle,
                    boxShadow: [AppStyles.glowShadow],
                  ),
                  child: const Center(
                    child: Text('🐮', style: TextStyle(fontSize: 44)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'PashuVaani',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDeepGreen,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'AI-Powered Tele-Veterinary Care',
                  style: AppStyles.subtext,
                ),
              ),
              const SizedBox(height: 40),
              Text('Welcome Back!', style: AppStyles.heading1),
              const SizedBox(height: 6),
              Text(
                'Enter your mobile number or email to access your pet & cattle health portal.',
                style: AppStyles.subtext.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 28),
              CustomTextField(
                label: 'Mobile Number / Email',
                hintText: '+91 9876543210 or farmer@gmail.com',
                controller: _phoneController,
                prefixIcon: Icons.phone_android_rounded,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),
              CustomTextField(
                label: 'Password',
                hintText: '••••••••',
                controller: _passwordController,
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Sign In',
                  isGradient: true,
                  isLoading: _isLoading,
                  onPressed: _handleLogin,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: AppStyles.subtext),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        color: AppColors.primaryDeepGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
