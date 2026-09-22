import '../models/product_model.dart';

class ProductService {
  final List<ProductModel> mockProducts = [
    ProductModel(
      id: 'p_1',
      name: 'PashuMinerals Forte (1kg)',
      category: 'Supplement',
      price: 320.0,
      originalPrice: 400.0,
      rating: 4.9,
      description: 'High-potency chelated mineral mixture for cattle & buffaloes. Improves milk yield and immunity.',
      targetAnimal: 'Cattle & Buffalo',
    ),
    ProductModel(
      id: 'p_2',
      name: 'Calcium Boost Gel (300ml)',
      category: 'Supplement',
      price: 250.0,
      originalPrice: 290.0,
      rating: 4.8,
      description: 'Instant oral ionic calcium supplement for post-calving milk fever prevention in dairy cows.',
      targetAnimal: 'Cattle',
    ),
    ProductModel(
      id: 'p_3',
      name: 'Canine Multivitamin Soft Chews',
      category: 'Food',
      price: 650.0,
      originalPrice: 750.0,
      rating: 4.7,
      description: 'Essential joint, skin and coat health chews for active adult dogs.',
      targetAnimal: 'Dogs',
    ),
    ProductModel(
      id: 'p_4',
      name: 'WormOut Broad Spectrum Dewormer',
      category: 'Medicine',
      price: 180.0,
      rating: 4.9,
      description: 'Veterinary prescription deworming bolus for livestock parasites.',
      targetAnimal: 'Cattle & Sheep',
      requiresPrescription: true,
    ),
  ];

  Future<List<ProductModel>> fetchProducts({String? category}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (category != null && category != 'All') {
      return mockProducts.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
    }
    return mockProducts;
  }
}
