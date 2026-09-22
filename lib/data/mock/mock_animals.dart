import '../models/animal_model.dart';

class MockAnimals {
  static final List<AnimalModel> animals = [
    AnimalModel(
      id: 'an_1',
      name: 'Gauri 🐮',
      species: 'Cow',
      breed: 'Holstein Friesian Cross',
      ageYears: 4,
      weightKg: 420,
      gender: 'Female',
      rfidTagNumber: 'IN-GUJ-8849-2041',
      ownerId: 'usr_1',
      healthStatus: 'Healthy (Lactating)',
    ),
    AnimalModel(
      id: 'an_2',
      name: 'Sheru 🐶',
      species: 'Dog',
      breed: 'German Shepherd',
      ageYears: 2,
      weightKg: 32,
      gender: 'Male',
      ownerId: 'usr_1',
      healthStatus: 'Healthy (Vaccinated)',
    ),
    AnimalModel(
      id: 'an_3',
      name: 'Moti 🦬',
      species: 'Buffalo',
      breed: 'Murrah Buffalo',
      ageYears: 5,
      weightKg: 540,
      gender: 'Female',
      rfidTagNumber: 'IN-GUJ-9921-1055',
      ownerId: 'usr_1',
      healthStatus: 'Healthy',
    ),
    AnimalModel(
      id: 'an_4',
      name: 'Chetak 🐴',
      species: 'Horse',
      breed: 'Marwari Horse',
      ageYears: 3,
      weightKg: 380,
      gender: 'Male',
      ownerId: 'usr_1',
      healthStatus: 'Active',
    ),
  ];
}
