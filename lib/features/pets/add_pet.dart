import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/helpers.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  String _selectedSpecies = 'Cattle / Cow 🐮';
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _rfidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Register Animal / Pet'),
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
            Text('Species / Category', style: AppStyles.heading3),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedSpecies,
              decoration: InputDecoration(fillColor: Theme.of(context).cardTheme.color, filled: true),
              items: AppConstants.speciesList.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => _selectedSpecies = val!),
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
                  final name = _nameController.text.trim();
                  final breed = _breedController.text.trim();
                  final ageStr = _ageController.text.trim();
                  final weightStr = _weightController.text.trim();

                  if (name.isEmpty || !RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
                    Helpers.showSnackBar(context, '⚠️ Pet name must contain letters only');
                    return;
                  }
                  if (breed.isNotEmpty && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(breed)) {
                    Helpers.showSnackBar(context, '⚠️ Breed must contain letters only');
                    return;
                  }
                  if (ageStr.isNotEmpty) {
                    final age = int.tryParse(ageStr);
                    if (age == null || age < 0 || age > 35) {
                      Helpers.showSnackBar(context, '⚠️ Pet age must be between 0 and 35 years');
                      return;
                    }
                  }
                  if (weightStr.isNotEmpty) {
                    final w = double.tryParse(weightStr);
                    if (w == null || w < 0.1 || w > 1000) {
                      Helpers.showSnackBar(context, '⚠️ Weight must be between 0.1 and 1000 kg');
                      return;
                    }
                  }

                  Helpers.showSnackBar(context, 'New animal registered in PashuVaani!');
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
