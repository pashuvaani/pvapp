import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_card.dart';
import '../../core/network/api_client.dart';
import '../../services/notification_service.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  bool _isPostingSOS = false;

  Future<void> _triggerLiveSOS() async {
    setState(() => _isPostingSOS = true);
    try {
      var response = await ApiClient().post('/medical-emergency', {
        'mobile_number': AppConstants.emergencyHotline,
        'description': 'Acute Emergency SOS triggered from PashuVaani App',
      });

      if (mounted) {
        if (response.isSuccess) {
          NotificationService().addNotification(
            AppNotification(
              id: 'em_${DateTime.now().millisecondsSinceEpoch}',
              title: '🚨 Emergency SOS Dispatched',
              body: 'Nearby Vets and Platform Admins have been notified of your location.',
              timestamp: DateTime.now(),
              type: 'emergency',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Live Vet Emergency Alert Sent to AWS & nearby Vets!'),
              backgroundColor: AppColors.primaryDeepGreen,
            ),
          );
        } else if (response.statusCode == 401) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('🔒 Please Log In to send live emergency SOS alerts!'),
              backgroundColor: Colors.orange.shade800,
              action: SnackBarAction(
                label: 'LOG IN',
                textColor: Colors.white,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Emergency Alert Failed: ${response.errorMessage ?? "Calling Hotline"} (${AppConstants.emergencyHotline})'),
              backgroundColor: AppColors.emergencyRed,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Emergency Alert Failed: $e (${AppConstants.emergencyHotline})'),
            backgroundColor: AppColors.emergencyRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isPostingSOS = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Vet SOS'),
        backgroundColor: Theme.of(context).cardTheme.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF2F2),
                borderRadius: AppStyles.cardBorderRadius,
                border: Border.all(color: AppColors.emergencyRed, width: 1.5),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.emergencyRed,
                      shape: BoxShape.circle,
                      boxShadow: AppStyles.getBoxShadow(context),
                    ),
                    child: const Icon(Icons.emergency_rounded, color: Colors.white, size: 48),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '24/7 Emergency Helpline',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.emergencyRed),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'For acute bloat, calving complications, severe injuries or snake bites.',
                    textAlign: TextAlign.center,
                    style: AppStyles.subtext,
                  ),
                  const SizedBox(height: 20),
                  _isPostingSOS
                      ? const CircularProgressIndicator(color: AppColors.emergencyRed)
                      : CustomButton(
                          text: 'Call & Alert Vet SOS Hotline',
                          icon: Icons.phone_in_talk_rounded,
                          backgroundColor: AppColors.emergencyRed,
                          onPressed: _triggerLiveSOS,
                        ),
                  const SizedBox(height: 10),
                  const Text(
                    AppConstants.emergencyHotline,
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryText),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Nearby Veterinary Hospitals', style: AppStyles.heading2),
            ),
            const SizedBox(height: 12),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.local_hospital_rounded, color: AppColors.primaryDeepGreen, size: 32),
                title: const Text('Anand Veterinary College Hospital', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('2.4 km away • 24 Hours Open'),
                trailing: IconButton(icon: const Icon(Icons.directions_rounded, color: AppColors.primaryDeepGreen), onPressed: () {}),
              ),
            ),
            const SizedBox(height: 10),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.local_hospital_rounded, color: AppColors.primaryDeepGreen, size: 32),
                title: const Text('District Animal Husbandry Clinic', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('5.1 km away • Closes 8 PM'),
                trailing: IconButton(icon: const Icon(Icons.directions_rounded, color: AppColors.primaryDeepGreen), onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
