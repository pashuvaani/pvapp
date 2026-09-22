import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/network/api_client.dart';
import '../../shared/widgets/doctor_profile_dialog.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  String _selectedCategory = 'All Vets';

  final List<String> _categories = [
    'All Vets',
    'Cattle & Dairy 🐮',
    'Small Animals 🐶',
    'Poultry 🐔',
    'Equine 🐴'
  ];

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
    return _mockDoctors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certified Veterinarians'),
      ),
      body: Column(
        children: [
          // Category filter
          SizedBox(
            height: 46,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: AppColors.primaryDeepGreen,
                    backgroundColor: Theme.of(context).cardTheme.color,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _doctorsFuture,
              builder: (context, snapshot) {
                final doctors = snapshot.data ?? _mockDoctors;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doc = doctors[index];
                    final name = doc['name'] ?? 'Doctor';
                    final title = doc['title'] ?? 'Veterinary Specialist';
                    final exp = '${doc['experience'] ?? '1'} Yr Exp';
                    final ratingStr = doc['rating'] ?? '4.8 ★ (100+ reviews)';
                    final imageUrl = doc['image'] ?? '';

                    ImageProvider imgProvider;
                    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
                      imgProvider = NetworkImage(imageUrl);
                    } else {
                      imgProvider = AssetImage(imageUrl);
                    }

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColors.softMint,
                              backgroundImage: imgProvider,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 2),
                                  Text(title, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w600, fontSize: 13)),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(exp, style: AppStyles.subtext),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          ratingStr,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                          textStyle: const TextStyle(fontSize: 12),
                                        ),
                                        onPressed: () => Navigator.pushNamed(
                                          context,
                                          AppRoutes.appointmentBooking,
                                          arguments: doc,
                                        ),
                                        child: const Text('Book Consult'),
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        ),
                                        onPressed: () => DoctorProfileDialog.show(context, doc),
                                        child: const Text('View Profile', style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ],
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
    );
  }
}
