import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/helpers.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class AddAnimalScreen extends StatefulWidget {
  const AddAnimalScreen({super.key});

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  String _selectedCategory = 'Cow / Cattle 🐮';
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _rfidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Add Animal / Pet Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.lightMintBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryDeepGreen, width: 2),
                    ),
                    child: const Center(child: Icon(Icons.add_a_photo_rounded, color: AppColors.primaryDeepGreen, size: 36)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(child: Text('Upload Animal Photo', style: AppStyles.subtext)),
            const SizedBox(height: 24),
            Text('Category', style: AppStyles.heading3),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: InputDecoration(fillColor: Theme.of(context).cardTheme.color, filled: true),
              items: AppConstants.animalCategories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Animal / Pet Name',
              hintText: 'e.g. Gauri or Sheru',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Breed',
              hintText: 'e.g. Holstein Friesian, Murrah, Labrador',
              controller: _breedController,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Age (Years)',
                    hintText: 'e.g. 4',
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: CustomTextField(
                    label: 'Weight (kg)',
                    hintText: 'e.g. 420',
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Ear Tag / RFID / Microchip ID (Optional)',
              hintText: 'e.g. IN-GUJ-8849-2041',
              controller: _rfidController,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Save Animal Profile',
                isGradient: true,
                onPressed: () {
                  Helpers.showSnackBar(context, 'Animal profile added successfully!');
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
