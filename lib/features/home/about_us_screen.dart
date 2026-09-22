import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About PashuVaani', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner matching website
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppColors.lightMintBg,
              child: Column(
                children: [
                  Image.asset('assets/images/logo/logopsv.png', height: 80, width: 80),
                  const SizedBox(height: 16),
                  const Text(
                    'About PashuVaani',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDeepGreen,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Animals communicate constantly.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDeepGreen.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Intro Section
                  Text(
                    'Through their behaviour, posture, sounds, and subtle changes in activity, animals express discomfort, illness, stress, and pain. Yet for many farmers and pet families, these signals are difficult to interpret until situations become serious.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepGreen.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primaryDeepGreen.withValues(alpha: 0.2)),
                    ),
                    child: const Text(
                      'PashuVaani was created to bridge this gap. An AI-powered animal intelligence platform designed to help humans better understand the animals they care for.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: AppColors.primaryDeepGreen,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // 4 Core Pillars Cards matching website
                  Text(
                    'Our Four Pillars',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildPillarCard(context, Icons.auto_awesome, 'Artificial Intelligence')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildPillarCard(context, Icons.favorite, 'Veterinary Expertise')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildPillarCard(context, Icons.bolt, 'Data Intelligence')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildPillarCard(context, Icons.shield, 'Compassionate Design')),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Meet Gopu Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.softMint,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: const AssetImage('assets/images/gopu/gopu_hi.jpeg'),
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(width: 16),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Meet Gopu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primaryDeepGreen)),
                                Text('The Heart of PashuVaani', style: TextStyle(fontSize: 12, color: AppColors.primaryDeepGreen)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Warm, Caring, Always Alert.',
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Gopu listens before he speaks — noticing subtle changes, asking the right questions, and helping you act early. Designed to feel less like a tool and more like a trusted companion.',
                          style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.primaryDeepGreen.withValues(alpha: 0.9)),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.gopuAi),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDeepGreen,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.white),
                          label: const Text('Try Gopu AI', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Story & Mission Section
                  Text(
                    'The Story Behind PashuVaani',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Founded by Mohan Vij, PashuVaani was born from a simple but powerful question — when an animal falls sick, why is it so difficult to find reliable guidance quickly?',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Accreditations & Certifications matching website
                  Text(
                    'Our Accreditations & Recognition',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAccreditationTile(
                    context,
                    'Startup India Recognition',
                    'Officially recognised under the Government of India Startup India initiative for innovation in animal healthcare.',
                  ),
                  _buildAccreditationTile(
                    context,
                    'DPIIT Registered',
                    'Registered with the Department for Promotion of Industry and Internal Trade, validating our commitment.',
                  ),
                  _buildAccreditationTile(
                    context,
                    'Veterinary Advisory Board',
                    'Backed by a panel of certified veterinary professionals ensuring clinical accuracy across all AI recommendations.',
                  ),
                  _buildAccreditationTile(
                    context,
                    'Animal Welfare Compliance',
                    'Fully compliant with national animal welfare guidelines, placing animal wellbeing at the centre.',
                  ),

                  const SizedBox(height: 40),
                  const Center(
                    child: Column(
                      children: [
                        Text('PashuVaani — The Voice of Animal Health', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
                        SizedBox(height: 4),
                        Text('Pashu Bhi Pariwar Hai 🌿', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        SizedBox(height: 12),
                        Text('Version 1.0.0 (Production Build)', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillarCard(BuildContext context, IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryDeepGreen, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAccreditationTile(BuildContext context, String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified, color: AppColors.primaryDeepGreen, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600], height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
