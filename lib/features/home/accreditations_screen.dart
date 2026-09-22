import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AccreditationsScreen extends StatelessWidget {
  const AccreditationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> accreditations = [
      {
        'title': 'Startup India Recognition',
        'desc': 'Officially recognised under the Government of India Startup India initiative for innovation in animal healthcare.',
        'badge': 'Government Recognised',
      },
      {
        'title': 'DPIIT Registered',
        'desc': 'Registered with the Department for Promotion of Industry and Internal Trade, validating our commitment to responsible innovation.',
        'badge': 'DPIIT Certified',
      },
      {
        'title': 'ISO Compliance',
        'desc': 'Adhering to international standards for quality management and data security in our AI-powered platform.',
        'badge': 'ISO Compliant',
      },
      {
        'title': 'Veterinary Advisory Board',
        'desc': 'Backed by a panel of certified veterinary professionals ensuring clinical accuracy across all AI recommendations.',
        'badge': 'Clinical Panel',
      },
      {
        'title': 'AI Ethics Certification',
        'desc': 'Committed to responsible AI development with transparent, bias-free, and privacy-respecting systems.',
        'badge': 'Ethical AI',
      },
      {
        'title': 'Animal Welfare Compliance',
        'desc': 'Fully compliant with national animal welfare guidelines, placing animal wellbeing at the centre of every decision.',
        'badge': 'Welfare First',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accreditations & Certifications', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppColors.lightMintBg,
              child: Column(
                children: [
                  const Icon(Icons.verified, color: AppColors.primaryDeepGreen, size: 50),
                  const SizedBox(height: 12),
                  const Text(
                    'Our Accreditations',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDeepGreen,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'PashuVaani is recognised and certified by leading bodies in animal health, technology, and innovation.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryDeepGreen.withValues(alpha: 0.85),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: accreditations.length,
                itemBuilder: (context, index) {
                  final item = accreditations[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: AppColors.softMint,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.verified_user, color: AppColors.primaryDeepGreen, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['title']!,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryDeepGreen.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      item['badge']!,
                                      style: const TextStyle(fontSize: 10, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['desc']!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
