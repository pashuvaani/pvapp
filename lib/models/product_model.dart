class ProductModel {
  final String id;
  final String name;
  final String category; // Medicine, Supplement, Food, Accessories
  final double price;
  final double? originalPrice;
  final double rating;
  final String description;
  final String targetAnimal; // Cattle, Dogs, Cats, All
  final bool requiresPrescription;
  final String? imageUrl;
  final bool inStock;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.description,
    required this.targetAnimal,
    this.requiresPrescription = false,
    this.imageUrl,
    this.inStock = true,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? 'Supplement',
      price: (json['price'] ?? 0.0).toDouble(),
      originalPrice: json['originalPrice'] != null ? (json['originalPrice']).toDouble() : null,
      rating: (json['rating'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      targetAnimal: json['targetAnimal'] ?? 'All',
      requiresPrescription: json['requiresPrescription'] ?? false,
      imageUrl: json['imageUrl'],
      inStock: json['inStock'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'description': description,
      'targetAnimal': targetAnimal,
      'requiresPrescription': requiresPrescription,
      'imageUrl': imageUrl,
      'inStock': inStock,
    };
  }
}
