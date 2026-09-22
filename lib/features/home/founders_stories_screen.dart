import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FoundersStoriesScreen extends StatelessWidget {
  const FoundersStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Founders Stories', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppColors.lightMintBg,
              child: Column(
                children: [
                  Text(
                    'PASHUVAANI ORIGINS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: AppColors.primaryDeepGreen.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Our Story',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDeepGreen,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'From the Desk of the Founders',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDeepGreen,
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
                  Text(
                    'Where the Idea Began',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Founder 1: Mr. Mohan Vij
                  _buildFounderCard(
                    context,
                    name: 'Mr. Mohan Vij',
                    role: 'Founder & CEO',
                    localAsset: 'assets/images/doctors/foundermohan.jpg',
                    imageUrl: 'https://pashuvaani.com/foundermohan.jpg',
                    paragraphs: [
                      'The idea behind PashuVaani began with a moment that changed how our founder saw the relationship between humans and animals.',
                      'During a visit to a village, he noticed a farmer sitting beside his cow. The animal appeared restless and uncomfortable. The farmer gently patted her and kept asking softly:',
                      '“What is wrong? Tell me what is wrong.”',
                      'But the cow could not answer.',
                      'The nearest veterinarian was far away, and it would take hours before help could arrive. The farmer cared deeply about his animal, yet he had no way of understanding what the cow was trying to communicate.',
                      'That moment revealed something powerful: animals communicate constantly through behaviour, posture, and sound — but humans often struggle to understand these signals in time.',
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Founder 2: Mr. Utkarsh Srivastava
                  _buildFounderCard(
                    context,
                    name: 'Mr. Utkarsh Srivastava',
                    role: 'Co-Founder & COO',
                    localAsset: 'assets/images/doctors/founderutkarsh.jpg',
                    imageUrl: 'https://pashuvaani.com/founderutkarsh.jpg',
                    paragraphs: [
                      'To turn the idea of PashuVaani into something real, our founder shared the vision with Mr. Utkarsh Srivastava, our co-founder.',
                      'From the very first conversation, the idea resonated strongly with him. The possibility of using technology to help humans better understand animals represented more than just a product idea — it was an opportunity to solve a meaningful problem faced by millions of farmers, pet owners, and animal caretakers.',
                      'Utkarsh recognized that many challenges in animal healthcare arise not because people do not care, but because they lack the tools and information needed to recognize problems early.',
                      'Together, Mohan and Utkarsh began shaping the concept of PashuVaani into a platform that could combine artificial intelligence, practical animal health knowledge, and accessible technology to support better decision-making for animal care.',
                    ],
                  ),

                  const SizedBox(height: 32),

                  // The Journey Ahead Quote Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.softMint,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryDeepGreen.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.format_quote_rounded, size: 36, color: AppColors.primaryDeepGreen),
                        const SizedBox(height: 8),
                        const Text(
                          '“Because when animals cannot speak our language, technology can help us listen.”',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                            color: AppColors.primaryDeepGreen,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'What began as a quiet moment between a farmer and his cow has now grown into a mission to transform how humans care for animals.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: AppColors.primaryDeepGreen.withValues(alpha: 0.8)),
                        ),
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

  Widget _buildFounderCard(
    BuildContext context, {
    required String name,
    required String role,
    String? localAsset,
    required String imageUrl,
    required List<String> paragraphs,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.softMint,
                  border: Border.all(color: AppColors.primaryDeepGreen.withValues(alpha: 0.2), width: 2),
                ),
                clipBehavior: Clip.antiAlias,
                child: localAsset != null
                    ? Image.asset(
                        localAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          final filename = localAsset.split('/').last;
                          return Image.network(
                            filename,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.person, color: AppColors.primaryDeepGreen, size: 32),
                            ),
                          );
                        },
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.person, color: AppColors.primaryDeepGreen, size: 32),
                      ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepGreen.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(role, style: const TextStyle(fontSize: 11, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...paragraphs.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  p,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.85),
                    fontStyle: p.startsWith('“') ? FontStyle.italic : FontStyle.normal,
                    fontWeight: p.startsWith('“') ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
