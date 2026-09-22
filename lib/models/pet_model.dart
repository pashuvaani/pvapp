class PetModel {
  final String id;
  final String name;
  final String species; // Dog, Cat, Cattle, Buffalo, Goat, etc.
  final String breed;
  final int ageYears;
  final double weightKg;
  final String gender;
  final String? rfidTagNumber;
  final String ownerId;
  final String? imageUrl;

  PetModel({
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
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      species: json['species'] ?? 'Dog',
      breed: json['breed'] ?? 'Mixed',
      ageYears: json['ageYears'] ?? 0,
      weightKg: (json['weightKg'] ?? 0).toDouble(),
      gender: json['gender'] ?? 'Male',
      rfidTagNumber: json['rfidTagNumber'],
      ownerId: json['ownerId'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'breed': breed,
      'ageYears': ageYears,
      'weightKg': weightKg,
      'gender': gender,
      'rfidTagNumber': rfidTagNumber,
      'ownerId': ownerId,
      'imageUrl': imageUrl,
    };
  }
}
