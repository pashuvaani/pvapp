import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/network/api_client.dart';
import '../../shared/widgets/doctor_profile_dialog.dart';

class VetTeamScreen extends StatefulWidget {
  const VetTeamScreen({super.key});

  @override
  State<VetTeamScreen> createState() => _VetTeamScreenState();
}

class _VetTeamScreenState extends State<VetTeamScreen> {
  final List<Map<String, dynamic>> _mockDoctors = [
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

  late Future<List<Map<String, dynamic>>> _doctorsFuture;

  @override
  void initState() {
    super.initState();
    _doctorsFuture = _fetchDoctors();
  }

  Future<List<Map<String, dynamic>>> _fetchDoctors() async {
    try {
      final response = await ApiClient().get('/doctors');
      if (response.isSuccess && response.data != null) {
        final dynamic responseData = response.data;
        dynamic rawData = responseData;
        if (responseData is Map) {
          rawData = responseData['data'] ?? responseData['doctors'] ?? responseData;
        }
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

            double ratingVal = 4.8;
            if (doc['rating'] != null) {
              final parsed = double.tryParse(doc['rating'].toString());
              if (parsed != null && parsed > 0) ratingVal = parsed;
            }
            if (name.toLowerCase().contains('ananya')) ratingVal = 4.9;

            int reviewsVal = name.toLowerCase().contains('kiran') ? 100 : 110;
            if (doc['reviews'] != null) {
              final parsedRev = int.tryParse(doc['reviews'].toString());
              if (parsedRev != null && parsedRev > 0) reviewsVal = parsedRev;
            } else if (doc['review_count'] != null) {
              final parsedRev = int.tryParse(doc['review_count'].toString());
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
    } catch (e) {
      debugPrint('Live doctor fetch error: $e');
    }
    return _mockDoctors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Theme.of(context).colorScheme.onSurface),
            tooltip: 'Profile & Settings',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.moreMenu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Vet Team', style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Meet our experienced\nveterinary professionals', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _doctorsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final doctors = snapshot.data ?? _mockDoctors;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doc = doctors[index];
                      final String imgPath = doc['image'] ?? '';
                      ImageProvider imageProvider;
                      if (imgPath.startsWith('http://') || imgPath.startsWith('https://')) {
                        imageProvider = NetworkImage(imgPath);
                      } else if (imgPath.startsWith('assets/')) {
                        imageProvider = AssetImage(imgPath);
                      } else {
                        imageProvider = const AssetImage('assets/images/doctors/dr ananya.jpeg');
                      }

                      return GestureDetector(
                        onTap: () => DoctorProfileDialog.show(context, doc),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
                            boxShadow: AppStyles.getBoxShadow(context),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 16),
                              CircleAvatar(
                                radius: 36,
                                backgroundImage: imageProvider,
                                backgroundColor: Theme.of(context).dividerColor.withValues(alpha: 0.05),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  doc['name'] ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).colorScheme.onSurface),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  doc['title'] ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    doc['rating'] ?? '4.8 ★',
                                    style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    DoctorProfileDialog.show(context, doc);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryDeepGreen,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    minimumSize: const Size(double.infinity, 32),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  child: const Text('View Profile', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
