import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/components/bottom_nav_bar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../services/theme_service.dart';
import '../../shared/widgets/blinking_emergency_icon.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/app_constants.dart';
import '../../services/notification_service.dart';
import '../../shared/widgets/doctor_profile_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            _buildQuickActions(),
            _buildPromoBanner(),
            _buildSectionHeader('Care & Consultations'),
            _buildMainServices(),
            _buildSectionHeader('Vet Team', action: 'View All', onActionTap: () {
              Navigator.pushNamed(context, AppRoutes.vetTeam);
            }),
            _buildVetTeam(),
            _buildSectionHeader('Articles & Blogs', action: 'View All', onActionTap: () {
              Navigator.pushNamed(context, AppRoutes.articlesVideos);
            }),
            _buildBlogsPreview(),
            const SizedBox(height: 120), // Extra padding for floating nav bar
          ],
        ),
      ),
    );
  }

  void _showEmergencyUrgencySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text(
                'What is the emergency?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              const SizedBox(height: 16),
              _buildUrgencyOption(context, 'Severe bleeding', Icons.water_drop),
              _buildUrgencyOption(context, 'Difficulty breathing', Icons.air),
              _buildUrgencyOption(context, 'Suspected poisoning', Icons.warning),
              _buildUrgencyOption(context, 'Other / Not sure', Icons.help_outline),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.map_outlined, color: AppColors.primaryDeepGreen),
                  label: const Text('View Helplines & Clinics', style: TextStyle(color: AppColors.primaryDeepGreen)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryDeepGreen),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.emergencyHelp);
                  },
                ),
              )
            ],
          ),
        ),
      );
      },
    );
  }

  Widget _buildUrgencyOption(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        Navigator.pop(context);
        _simulateDoctorConnection(context, title);
      },
    );
  }

  void _simulateDoctorConnection(BuildContext context, String urgency) async {
    bool isDialogClosed = false;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(color: Colors.red, strokeWidth: 4),
              ),
              const SizedBox(height: 20),
              Text(
                'Alerting nearest available vets for:\n$urgency',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Please standby...', style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  if (!isDialogClosed) {
                    Navigator.of(dialogCtx).pop();
                  }
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      isDialogClosed = true;
    });

    // Send real emergency request to live AWS backend with 8s timeout
    ApiResponse<Map<String, dynamic>>? resp;
    try {
      resp = await ApiClient().post(
        '/medical-emergency',
        {
          'mobile_number': AppConstants.emergencyHotline,
          'description': '$urgency - Emergency Alert from PashuVaani App',
        },
        timeout: const Duration(seconds: 8),
      );
    } catch (_) {}

    // Instantly close popup dialog when completed if still open
    if (context.mounted && !isDialogClosed) {
      Navigator.of(context, rootNavigator: true).pop();
      isDialogClosed = true;
    }

    if (context.mounted) {
      if (resp != null && resp.isSuccess) {
        NotificationService().addNotification(
          AppNotification(
            id: 'em_${DateTime.now().millisecondsSinceEpoch}',
            title: '🚨 Emergency SOS Dispatched ($urgency)',
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
      } else if (resp != null && resp.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('🔒 Please Log In to send live emergency alerts!'),
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
            content: Text('❌ Emergency Alert Failed: ${resp?.errorMessage ?? "Could not reach server"}'),
            backgroundColor: AppColors.emergencyRed,
          ),
        );
      }
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Image.asset(
          'assets/images/logo/logopsv.png',
          height: 30,
          width: 30,
          fit: BoxFit.contain,
        ),
      ),
      title: const Padding(
        padding: EdgeInsets.only(left: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pashuvaani', style: TextStyle(color: AppColors.primaryDeepGreen, fontWeight: FontWeight.bold, fontSize: 16, height: 1.1)),
            Text('The Voice of Animal Health', style: TextStyle(color: Colors.grey, fontSize: 9, height: 1.1)),
          ],
        ),
      ),
      actions: [
        BlinkingEmergencyIcon(onTap: () => _showEmergencyUrgencySheet(context)),
        IconButton(
          iconSize: 20,
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          icon: ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeService().themeMode,
            builder: (context, mode, _) {
              return Icon(
                mode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: Theme.of(context).iconTheme.color,
              );
            },
          ),
          onPressed: () => ThemeService().toggleTheme(),
        ),
        IconButton(
          iconSize: 20,
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          icon: Icon(Icons.notifications_outlined, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
        ),
        IconButton(
          iconSize: 20,
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          icon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.moreMenu),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Namaste!', style: TextStyle(color: AppColors.primaryDeepGreen, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('I\'m Gopu AI', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface)),
                const SizedBox(height: 4),
                Text('Your Animal Health Assistant', style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
                const SizedBox(height: 12),
                Text('How can I help you and\nyour furry friend today?', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.gopuAi),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDeepGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.white),
                  label: const Text('Chat with Gopu', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Transform.scale(
              scale: 1.3,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const RadialGradient(
                    center: Alignment.center,
                    radius: 0.45,
                    colors: [Colors.black, Colors.transparent],
                    stops: [0.5, 0.9],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/gopu/gopu_hi.jpeg',
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGreen.withValues(alpha: 0.25), // Green Glowing effect
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActionItem(Icons.video_camera_front_outlined, 'Consultation', 'Book video or\nclinic consultation', () => Navigator.pushNamed(context, AppRoutes.consultation)),
            _buildActionItem(Icons.calendar_month_outlined, 'Appointment', 'Schedule with\nour vet team', () => Navigator.pushNamed(context, AppRoutes.appointmentBooking)),
            _buildActionItem(Icons.medical_services_outlined, 'Vet Team', 'Meet our\nexpert vets', () => Navigator.pushNamed(context, AppRoutes.vetTeam)),
            _buildActionItem(Icons.chat_outlined, 'Gopu AI Chat', '24/7 AI support\nfor your pet', () => Navigator.pushNamed(context, AppRoutes.gopuAi)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.softMint,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryDeepGreen),
          ),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Theme.of(context).colorScheme.onSurface), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 9, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return const PromoCarousel();
  }

  Widget _buildSectionHeader(String title, {String? action, VoidCallback? onActionTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface), overflow: TextOverflow.ellipsis)),
          if (action != null)
            GestureDetector(
              onTap: onActionTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(action, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
                  const Icon(Icons.chevron_right, size: 16, color: AppColors.primaryDeepGreen),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _buildMainServices() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildServiceCard('Video Consultation', 'Talk face-to-face\nwith a vet', Icons.video_call, const Color(0xFFE8F5E9), () => Navigator.pushNamed(context, AppRoutes.appointmentBooking, arguments: {'isVideoCall': true})),
          _buildServiceCard('In-Clinic Consultation', 'Visit our verified\nvet clinics', Icons.pets, const Color(0xFFFFF3E0), () => Navigator.pushNamed(context, AppRoutes.appointmentBooking)),
          _buildServiceCard('Health Records', 'Track health, vaccines\n& reports', Icons.assignment, const Color(0xFFE3F2FD), () => Navigator.pushNamed(context, AppRoutes.healthRecords)),
          _buildServiceCard('Travel with Pet', 'Pet passport &\ntravel info', Icons.flight_takeoff, const Color(0xFFF3E5F5), () => Navigator.pushNamed(context, AppRoutes.travelPackages)),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, String subtitle, IconData icon, Color bgColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primaryDeepGreen, size: 30),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.primaryDeepGreen)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 10, color: AppColors.primaryDeepGreen.withValues(alpha: 0.7))),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryDeepGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, size: 14, color: AppColors.primaryDeepGreen),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopProducts() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildProductCard('MASTI-MIN\nMineral Premix', '₹320', 'assets/images/products/product_01.jpeg'),
          _buildProductCard('MET-BOLYTE\nSyrup', '₹250', 'assets/images/products/product_04.jpeg'),
          _buildProductCard('Utero-Kleen\nWash', '₹180', 'assets/images/products/product_05.jpeg'),
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, String price, String imageUrl) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration( color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                Text(price, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDeepGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVetTeam() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchHomeDoctors(),
      builder: (context, snapshot) {
        final doctors = snapshot.data ?? [
          {
            'name': 'Dr. Kiran Bishnoi',
            'title': 'Canine & Feline Medicine',
            'rating': '4.8 ★ (100+ reviews)',
            'image': 'assets/images/doctors/dr_ananya_photo.png',
            'experience': '1',
            'consultation_fee': '199',
            'availability': 'Available',
            'languages': 'English, Hindi',
            'description': 'Dr. Kiran Bishnoi is a compassionate veterinary professional focused on delivering attentive, reliable, and animal-centered care with empathy and precision.',
          },
          {
            'name': 'Dr. Ananya Jaitly',
            'title': 'Canine Medicine',
            'rating': '4.9 ★ (110+ reviews)',
            'image': 'assets/images/doctors/IMG-20260904-WA0036.jpg.jpeg',
            'experience': '1',
            'consultation_fee': '199',
            'availability': 'Available',
            'languages': 'English, Hindi, Punjabi',
            'description': 'Dr. Ananya Jaitly is a dedicated veterinary professional specializing in canine medicine, focused on providing compassionate, precise, and effective healthcare for dogs.',
          },
        ];

        return SizedBox(
          height: 170,
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doc = doctors[index];
              return _buildVetCard(doc);
            },
          ),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchHomeDoctors() async {
    try {
      final response = await ApiClient().get('/doctors');
      if (response.isSuccess && response.data != null) {
        final rawData = response.data!['data'] ?? response.data;
        if (rawData is List && rawData.isNotEmpty) {
          return rawData.map<Map<String, dynamic>>((doc) {
            String imgUrl = doc['image'] ?? 'assets/images/doctors/IMG-20260904-WA0036.jpg.jpeg';
            final String docNameRaw = doc['name']?.toString() ?? 'Doctor';
            final String name = docNameRaw.toLowerCase().startsWith('dr.')
                ? docNameRaw.trim()
                : 'Dr. ${docNameRaw.trim()}';

            if (name.toLowerCase().contains('kiran')) {
              imgUrl = 'assets/images/doctors/dr_ananya_photo.png';
            } else if (name.toLowerCase().contains('ananya')) {
              imgUrl = 'assets/images/doctors/IMG-20260904-WA0036.jpg.jpeg';
            } else if (imgUrl.startsWith('/')) {
              imgUrl = 'https://pashuvaani.com$imgUrl';
            }

            double ratingVal = name.toLowerCase().contains('kiran') ? 4.8 : 4.9;
            if (doc['rating'] != null) {
              final parsed = double.tryParse(doc['rating'].toString());
              if (parsed != null && parsed > 0) ratingVal = parsed;
            }

            int reviewsVal = name.toLowerCase().contains('kiran') ? 100 : 110;
            if (doc['reviews'] != null) {
              final parsedRev = int.tryParse(doc['reviews'].toString());
              if (parsedRev != null && parsedRev > 0) reviewsVal = parsedRev;
            } else if (doc['review_count'] != null) {
              final parsedRev = int.tryParse(doc['review_count'].toString());
              if (parsedRev != null && parsedRev > 0) reviewsVal = parsedRev;
            } else if (doc['total_reviews'] != null) {
              final parsedRev = int.tryParse(doc['total_reviews'].toString());
              if (parsedRev != null && parsedRev > 0) reviewsVal = parsedRev;
            }

            return {
              'name': name,
              'title': doc['specialty'] ?? doc['title'] ?? 'Veterinary Specialist',
              'rating': '${ratingVal.toStringAsFixed(1)} ★ ($reviewsVal+ reviews)',
              'image': imgUrl,
              'experience': doc['experience']?.toString() ?? '1',
              'consultation_fee': doc['consultation_fee']?.toString() ?? '199',
              'availability': doc['availability']?.toString() ?? 'Available',
              'languages': doc['languages']?.toString() ?? (name.toLowerCase().contains('ananya') ? 'English, Hindi, Punjabi' : 'English, Hindi'),
              'description': doc['description']?.toString(),
            };
          }).toList();
        }
      }
    } catch (_) {}
    return [
      {
        'name': 'Dr. Kiran Bishnoi',
        'title': 'Canine & Feline Medicine',
        'rating': '4.8 ★ (100+ reviews)',
        'image': 'assets/images/doctors/dr_ananya_photo.png',
        'experience': '1',
        'consultation_fee': '199',
        'availability': 'Available',
        'languages': 'English, Hindi',
        'description': 'Dr. Kiran Bishnoi is a compassionate veterinary professional focused on delivering attentive, reliable, and animal-centered care with empathy and precision.',
      },
      {
        'name': 'Dr. Ananya Jaitly',
        'title': 'Canine Medicine',
        'rating': '4.9 ★ (110+ reviews)',
        'image': 'assets/images/doctors/IMG-20260904-WA0036.jpg.jpeg',
        'experience': '1',
        'consultation_fee': '199',
        'availability': 'Available',
        'languages': 'English, Hindi, Punjabi',
        'description': 'Dr. Ananya Jaitly is a dedicated veterinary professional specializing in canine medicine, focused on providing compassionate, precise, and effective healthcare for dogs.',
      },
    ];
  }

  Widget _buildVetCard(Map<String, dynamic> doc) {
    final String name = doc['name'] ?? '';
    final String title = doc['title'] ?? '';
    final String rating = doc['rating'] ?? '4.8';
    final String imageUrl = doc['image'] ?? '';

    ImageProvider imgProvider;
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imgProvider = NetworkImage(imageUrl);
    } else {
      imgProvider = AssetImage(imageUrl);
    }

    return GestureDetector(
      onTap: () => DoctorProfileDialog.show(context, doc),
      child: Container(
        width: 125,
        margin: const EdgeInsets.only(right: 12, bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGreen.withValues(alpha: 0.15),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).dividerColor.withValues(alpha: 0.05),
              backgroundImage: imgProvider,
            ),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 9, color: Colors.grey), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                rating,
                style: TextStyle(fontSize: 9, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogsPreview() {
    final List<Map<String, String>> blogs = [
      {
        'title': 'Neglect Hurts More Than Any Disease: Why Our Animals Really Suffer',
        'tag': 'ANIMAL HEALTH',
        'time': '5 min read',
        'image': 'https://images.unsplash.com/photo-1576201836106-db1758fd1c97',
      },
      {
        'title': 'How PashuVaani is Bringing AI to Animal Health in India...',
        'tag': 'ANIMAL HEALTH',
        'time': '6 min read',
        'image': 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee',
      },
    ];

    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final item = blogs[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.articlesVideos),
            child: Container(
              width: 260,
              margin: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 110,
                        width: double.infinity,
                        color: AppColors.lightMintBg,
                        child: Image.network(
                          item['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.article),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B4D3E),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item['tag']!,
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['time']!,
                          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, height: 1.2),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 1500);
  int _currentPage = 1500;
  Timer? _timer;
  late AnimationController _carController;
  late Animation<double> _carAnimation;

  @override
  void initState() {
    super.initState();
    _carController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _carAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _carController, curve: Curves.easeInOutSine)
    );

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _carController.dispose();
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 195,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              int pageIndex = index % 2;
              if (pageIndex == 0) return _buildFirstSlide(context);
              return _buildTravelSlide(context);
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            bool isActive = _currentPage % 2 == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isActive 
                    ? AppColors.primaryDeepGreen 
                    : Theme.of(context).dividerColor.withValues(alpha: 0.1),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFirstSlide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.lightMintBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Compassion. Technology. Care.', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen.withValues(alpha: 0.8))),
                  const SizedBox(height: 8),
                  const Text('Trusted care for\nyour best friend', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primaryDeepGreen)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.aboutUs),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDeepGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    child: const Text('Explore More', style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Transform.scale(
                scale: 1.5,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const RadialGradient(
                      center: Alignment.center,
                      radius: 0.45,
                      colors: [Colors.black, Colors.transparent],
                      stops: [0.5, 0.9],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/gopu/gopu_home.jpeg',
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTravelSlide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3E5F5), // Soft purple
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Pet Passports & More', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF6A1B9A).withValues(alpha: 0.8))),
                  const SizedBox(height: 8),
                  const Text('Travel with\nyour pet safely', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF4A148C))),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.travelPackages),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B1FA2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    child: const Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: AnimatedBuilder(
                animation: _carAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_carAnimation.value * 0.5, _carAnimation.value * 0.2),
                    child: child,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/gopu/gopudrive.jpeg',
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car, size: 60, color: Color(0xFFCE93D8)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
