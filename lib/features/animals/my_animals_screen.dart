import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_animals.dart';
import '../../shared/components/animal_avatar.dart';
import '../../shared/widgets/custom_card.dart';

class MyAnimalsScreen extends StatelessWidget {
  const MyAnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('My Animals & Livestock'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primaryDeepGreen),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.addAnimal),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockAnimals.animals.length,
        itemBuilder: (context, index) {
          final animal = MockAnimals.animals[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: CustomCard(
              onTap: () => Navigator.pushNamed(context, AppRoutes.animalProfile),
              child: Row(
                children: [
                  AnimalAvatar(species: animal.species, radius: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(animal.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('${animal.breed} • ${animal.ageYears} Yrs', style: AppStyles.subtext.copyWith(fontSize: 12)),
                        if (animal.rfidTagNumber != null) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.softMint,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('RFID: ${animal.rfidTagNumber}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.secondaryText),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
