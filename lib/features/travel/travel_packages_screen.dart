import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/network/api_client.dart';
import 'widgets/booking_bottom_sheet.dart';

class TravelPackagesScreen extends StatefulWidget {
  const TravelPackagesScreen({super.key});

  @override
  State<TravelPackagesScreen> createState() => _TravelPackagesScreenState();
}

class _TravelPackagesScreenState extends State<TravelPackagesScreen> {
  final List<Map<String, dynamic>> _mockPackages = [
    {
      'title': 'Khatu Shyam Ji Darshan',
      'description': 'One day trip from Jaipur to Khatu Shyam Ji',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 2199,
      'assetUrl': 'assets/images/travel/1.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/1.jpeg',
    },
    {
      'title': 'Salasar Balaji Darshan',
      'description': 'One day trip from Jaipur to Salasar Balaji',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 3999,
      'assetUrl': 'assets/images/travel/3.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/3.jpeg',
    },
    {
      'title': 'Khatu Shyam & Salasar Balaji',
      'description': 'Visit two divine temples in one trip',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 4199,
      'assetUrl': 'assets/images/travel/4.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/4.jpeg',
    },
    {
      'title': 'Triple Temple Tour',
      'description': 'Visit Khatu Shyam Ji, Jeen Mata & Salasar Balaji',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 4699,
      'assetUrl': 'assets/images/travel/2.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/2.jpeg',
    },
    {
      'title': 'Complete Religious Tour',
      'description': 'Complete tour of all major temples',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 5799,
      'assetUrl': 'assets/images/travel/5.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/5.jpeg',
    },
    {
      'title': 'Ranthambore',
      'description': 'Ranthambore Journey',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 4499,
      'assetUrl': 'assets/images/travel/6.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/6.jpeg',
    },
    {
      'title': 'Jaipur Darshan Special',
      'description': 'Places Covered (Best Route - No Rush, Full Mazaa)',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 2999,
      'assetUrl': 'assets/images/travel/7.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/7.jpeg',
    },
    {
      'title': 'Udaipur',
      'description': 'Udaipur Journey',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 8599,
      'assetUrl': 'assets/images/travel/8.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/8.jpeg',
    },
    {
      'title': 'Jaipur to Delhi One Way',
      'description': 'Jaipur to Delhi One Way Journey',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 3999,
      'assetUrl': 'assets/images/travel/9.jpg',
      'imageUrl': 'https://pashuvaani.com/images/9.jpg',
    },
    {
      'title': 'Jaipur to Gurgaon One Way',
      'description': 'Jaipur to Gurgaon One Way Journey',
      'duration': '1 day',
      'location': 'Jaipur',
      'price': 3599,
      'assetUrl': 'assets/images/travel/10.jpeg',
      'imageUrl': 'https://pashuvaani.com/images/10.jpeg',
    },
  ];

  late Future<List<Map<String, dynamic>>> _packagesFuture;

  @override
  void initState() {
    super.initState();
    _packagesFuture = _fetchPackages();
  }

  Future<List<Map<String, dynamic>>> _fetchPackages() async {
    try {
      final response = await ApiClient().get('/travel');
      if (response.isSuccess && response.data != null) {
        final dynamic responseData = response.data;
        dynamic rawData = responseData;
        if (responseData is Map) {
          rawData = responseData['data'] ?? responseData['packages'] ?? responseData;
        }
        if (rawData is List && rawData.isNotEmpty) {
          return rawData.map<Map<String, dynamic>>((pkg) {
            String imgUrl = pkg['image'] ?? pkg['imageUrl'] ?? '';
            if (imgUrl.startsWith('/')) {
              imgUrl = 'https://pashuvaani.com$imgUrl';
            }
            return {
              'title': pkg['title'] ?? pkg['name'] ?? '',
              'description': pkg['description'] ?? '',
              'duration': pkg['duration'] ?? '1 day',
              'location': pkg['location'] ?? 'Jaipur',
              'price': pkg['price'] is int ? pkg['price'] : (int.tryParse(pkg['price']?.toString() ?? '2199') ?? 2199),
              'imageUrl': imgUrl,
              'assetUrl': pkg['assetUrl'] ?? '',
            };
          }).toList();
        }
      }
    } catch (_) {}
    return _mockPackages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F4),
      appBar: AppBar(
        title: const Text('Travel with Pet | Pet Cabs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Booking Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1FA7A6), Color(0xFF1F6559)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF1FA7A6).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.local_taxi, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Book Custom Pet Cab',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Safe, AC & Pet-Friendly Rides across India. Experienced Drivers with Pet Care Gear.',
                    style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showQuickCabBookingSheet(context);
                    },
                    icon: const Icon(Icons.directions_car, size: 18, color: AppColors.primaryDeepGreen),
                    label: const Text('Book Ride Now', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Featured Pet Cab Packages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: _packagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Padding(padding: EdgeInsets.all(32.0), child: CircularProgressIndicator()));
                }
                final packages = snapshot.data ?? _mockPackages;
                
                return LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 1;
                    if (constraints.maxWidth > 1100) {
                      crossAxisCount = 4;
                    } else if (constraints.maxWidth > 800) {
                      crossAxisCount = 3;
                    } else if (constraints.maxWidth > 550) {
                      crossAxisCount = 2;
                    }

                    if (crossAxisCount == 1) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: packages.length,
                        itemBuilder: (context, index) {
                          final pkg = packages[index];
                          return _buildPackageCard(
                            context: context,
                            title: pkg['title'] ?? '',
                            description: pkg['description'] ?? '',
                            duration: pkg['duration'] ?? '1 day',
                            location: pkg['location'] ?? 'Jaipur',
                            price: pkg['price'] is int ? pkg['price'] : 2199,
                            imageUrl: pkg['imageUrl'] ?? '',
                            assetUrl: pkg['assetUrl'] ?? 'assets/images/travel/${(index % 10) + 1}.${(index % 10) == 8 || (index % 10) == 9 ? "png" : "jpeg"}',
                          );
                        },
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.78,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: packages.length,
                      itemBuilder: (context, index) {
                        final pkg = packages[index];
                        return _buildPackageCard(
                          context: context,
                          title: pkg['title'] ?? '',
                          description: pkg['description'] ?? '',
                          duration: pkg['duration'] ?? '1 day',
                          location: pkg['location'] ?? 'Jaipur',
                          price: pkg['price'] is int ? pkg['price'] : 2199,
                          imageUrl: pkg['imageUrl'] ?? '',
                          assetUrl: pkg['assetUrl'] ?? 'assets/images/travel/${(index % 10) + 1}.${(index % 10) == 8 || (index % 10) == 9 ? "png" : "jpeg"}',
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickCabBookingSheet(BuildContext context) {
    final pickupCtrl = TextEditingController(text: 'Jaipur Junction');
    final dropCtrl = TextEditingController(text: 'Khatu Shyam Ji Temple');
    String selectedCab = 'Sedan (AC)';
    String petType = 'Dog';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Instant Pet Cab Booking', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
              const SizedBox(height: 4),
              Text('Live confirmation from PashuVaani Travel Team', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              const SizedBox(height: 16),
              TextField(
                controller: pickupCtrl,
                decoration: const InputDecoration(labelText: 'Pickup Location', prefixIcon: Icon(Icons.my_location, size: 20)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dropCtrl,
                decoration: const InputDecoration(labelText: 'Drop Location', prefixIcon: Icon(Icons.location_on, size: 20)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: petType,
                      decoration: const InputDecoration(labelText: 'Pet Type'),
                      items: ['Dog', 'Cat', 'Cattle', 'Other'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                      onChanged: (v) => petType = v!,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedCab,
                      decoration: const InputDecoration(labelText: 'Cab Class'),
                      items: ['Hatchback', 'Sedan (AC)', 'SUV (XL)', 'Ambulance'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (v) => selectedCab = v!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('✅ Pet Cab Request Confirmed from ${pickupCtrl.text} to ${dropCtrl.text}!'),
                        backgroundColor: AppColors.primaryDeepGreen,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDeepGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Confirm & Book Cab', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard({
    required BuildContext context,
    required String title,
    required String description,
    required String duration,
    required String location,
    required int price,
    required String imageUrl,
    String? assetUrl,
  }) {
    Widget imageWidget;
    final fallbackAsset = (assetUrl != null && assetUrl.isNotEmpty)
        ? assetUrl
        : 'assets/images/gopu/gopudrive.jpeg';

    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imageWidget = Image.network(
        imageUrl,
        fit: BoxFit.cover,
        headers: const {
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
          'Referer': 'https://pashuvaani.com/travel-with-pet',
          'Accept': 'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
        },
        errorBuilder: (_, __, ___) => Image.asset(
          fallbackAsset,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Image.asset('assets/images/gopu/gopudrive.jpeg', fit: BoxFit.cover),
        ),
      );
    } else {
      imageWidget = Image.asset(
        fallbackAsset,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset('assets/images/gopu/gopudrive.jpeg', fit: BoxFit.cover),
      );
    }

    // Standardize price display string with comma formatting (e.g. ₹2,199)
    final formattedPrice = price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: imageWidget,
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12, height: 1.3),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(duration, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                    const SizedBox(width: 12),
                    Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(location, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Starting from', style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                        Text(
                          '₹$formattedPrice',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BookingBottomSheet.show(context, title, price);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CA6A4),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
