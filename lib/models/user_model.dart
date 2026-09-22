class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role; // Pet Owner, Farmer, Veterinarian
  final String? profileImage;
  final String address;
  final String preferredLanguage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImage,
    required this.address,
    this.preferredLanguage = 'English',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'Pet Owner',
      profileImage: json['profileImage'],
      address: json['address'] ?? '',
      preferredLanguage: json['preferredLanguage'] ?? 'English',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'profileImage': profileImage,
      'address': address,
      'preferredLanguage': preferredLanguage,
    };
  }
}
