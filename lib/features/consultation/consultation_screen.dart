import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/components/bottom_nav_bar.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final int _currentBottomNavIndex = 1; // 1 for Consultation in the bottom nav

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildConsultationCard(
                title: 'Video Consultation',
                subtitle: 'Talk face-to-face\nwith a vet',
                icon: Icons.video_camera_front_outlined,
                onTap: () => Navigator.pushNamed(context, AppRoutes.appointmentBooking, arguments: {'isVideoCall': true}),
              ),
              const SizedBox(height: 16),
              _buildConsultationCard(
                title: 'In-Clinic Consultation',
                subtitle: 'Visit our verified\nvet clinics',
                icon: Icons.local_hospital_outlined,
                onTap: () => Navigator.pushNamed(context, AppRoutes.appointmentBooking, arguments: {'isVideoCall': false}),
              ),
              const SizedBox(height: 16),
              _buildConsultationCard(
                title: 'Consultation History',
                subtitle: 'View your past\nappointments',
                icon: Icons.history_outlined,
                buttonText: 'View',
                onTap: () => Navigator.pushNamed(context, AppRoutes.appointmentHistory),
              ),
              const SizedBox(height: 32),
              Text(
                'Why consult with us?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              _buildCheckListItem('Experienced & verified vets'),
              _buildCheckListItem('Safe & confidential'),
              _buildCheckListItem('Easy & quick process'),
              _buildCheckListItem('Care from the comfort of home'),
              const SizedBox(height: 100), // Space for bottom nav bar
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
        onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
      ),
      title: Image.asset(
        'assets/images/logo/logopsv.png',
        height: 32,
        width: 32,
        fit: BoxFit.contain,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
        ),
        IconButton(
          icon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color),
          tooltip: 'Profile & Settings',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.moreMenu),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Consultation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how you want\nto consult our vets',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const RadialGradient(
                center: Alignment.center,
                radius: 0.5,
                colors: [Colors.black, Colors.transparent],
                stops: [0.7, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              'assets/images/gopu/gopu_consult.jpeg',
              height: 110,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConsultationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    String buttonText = 'Book Now',
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppStyles.getBoxShadow(context),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDeepGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primaryDeepGreen, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDeepGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: const Size(0, 36),
                  ),
                  child: Text(buttonText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.primaryDeepGreen,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }
}
