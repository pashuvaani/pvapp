class AnimalModel {
  final String id;
  final String name;
  final String species; // Dog, Cat, Cow, Buffalo, Goat, etc.
  final String breed;
  final int ageYears;
  final double weightKg;
  final String gender;
  final String? rfidTagNumber;
  final String ownerId;
  final String? imageUrl;
  final String? healthStatus;

  AnimalModel({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.ageYears,
    required this.weightKg,
    required this.gender,
    this.rfidTagNumber,
    required this.ownerId,
    this.imageUrl,
    this.healthStatus = 'Healthy',
  });

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      species: json['species'] ?? 'Cow',
      breed: json['breed'] ?? 'Mixed',
      ageYears: json['ageYears'] ?? 0,
      weightKg: (json['weightKg'] ?? 0).toDouble(),
      gender: json['gender'] ?? 'Female',
      rfidTagNumber: json['rfidTagNumber'],
      ownerId: json['ownerId'] ?? '',
      imageUrl: json['imageUrl'],
      healthStatus: json['healthStatus'] ?? 'Healthy',
    );
  }
}
