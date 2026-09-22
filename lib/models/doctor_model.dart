class DoctorModel {
  final String id;
  final String name;
  final String qualification; // B.V.Sc & A.H, M.V.Sc
  final String specialty;
  final int experienceYears;
  final double rating;
  final int totalConsultations;
  final double fee;
  final bool isAvailable;
  final String? profileImage;
  final String clinicLocation;

  DoctorModel({
    required this.id,
    required this.name,
    required this.qualification,
    required this.specialty,
    required this.experienceYears,
    required this.rating,
    required this.totalConsultations,
    required this.fee,
    this.isAvailable = true,
    this.profileImage,
    required this.clinicLocation,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      qualification: json['qualification'] ?? '',
      specialty: json['specialty'] ?? 'General Vet',
      experienceYears: json['experienceYears'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalConsultations: json['totalConsultations'] ?? 0,
      fee: (json['fee'] ?? 0.0).toDouble(),
      isAvailable: json['isAvailable'] ?? true,
      profileImage: json['profileImage'],
      clinicLocation: json['clinicLocation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'qualification': qualification,
      'specialty': specialty,
      'experienceYears': experienceYears,
      'rating': rating,
      'totalConsultations': totalConsultations,
      'fee': fee,
      'isAvailable': isAvailable,
      'profileImage': profileImage,
      'clinicLocation': clinicLocation,
    };
  }
}
