import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';

class DoctorProfileDialog extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorProfileDialog({super.key, required this.doctor});

  static void show(BuildContext context, Map<String, dynamic> doctor) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        clipBehavior: Clip.antiAlias,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: DoctorProfileDialog(doctor: doctor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String name = doctor['name'] ?? 'Doctor';
    final String specialty = (doctor['specialty'] ?? doctor['title'] ?? 'CANINE MEDICINE').toString().toUpperCase();
    final String imagePath = doctor['image'] ?? 'assets/images/doctors/dr_ananya_photo.png';
    final String description = doctor['description'] ??
        (name.toLowerCase().contains('kiran')
            ? 'Dr. Kiran Bishnoi is a compassionate veterinary professional focused on delivering attentive, reliable, and animal-centered care with empathy and precision.'
            : 'Dr. Ananya Jaitly is a dedicated veterinary professional specializing in canine medicine, focused on providing compassionate, precise, and effective healthcare for dogs.');
    
    final String exp = doctor['experience']?.toString() ?? '1';
    final String fee = doctor['consultation_fee'] != null 
        ? (doctor['consultation_fee'].toString().startsWith('₹') ? doctor['consultation_fee'].toString() : '₹${doctor['consultation_fee']}')
        : '₹199';
    final String availability = doctor['availability']?.toString() ?? 'Available';
    final String languages = doctor['languages']?.toString() ?? (name.toLowerCase().contains('ananya') ? 'English, Hindi, Punjabi' : 'English, Hindi');
    final String ratingStr = name.toLowerCase().contains('kiran') ? '4.8 (100+ reviews)' : '4.9 (110+ reviews)';

    ImageProvider imageProvider;
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      imageProvider = NetworkImage(imagePath);
    } else {
      imageProvider = AssetImage(imagePath);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Doctor Photo Banner with Gradient and Info Overlay
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),
              // Close Button 'X'
              Positioned(
                top: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ),
              // Doctor Title & Rating overlay
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      specialty,
                      style: TextStyle(
                        color: Colors.greenAccent[200],
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          ratingStr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        // Available Pill Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B4D3E).withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.4)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.greenAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                availability,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Body Content: Description & 2x2 Stats
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),

                // 2x2 Stats Grid
                Row(
                  children: [
                    Expanded(child: _buildStatBox('EXPERIENCE', exp)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatBox('CONSULT FEE', fee)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildStatBox('AVAILABILITY', availability)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatBox('LANGUAGES', languages)),
                  ],
                ),
                const SizedBox(height: 24),

                // Book Appointment Action Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRoutes.appointmentBooking, arguments: doctor);
                    },
                    icon: const Icon(Icons.calendar_today_outlined, size: 18, color: Colors.white),
                    label: const Text(
                      'Book Appointment',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDeepGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9F8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDeepGreen,
            ),
          ),
        ],
      ),
    );
  }
}
