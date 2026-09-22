import '../../models/product_model.dart';

class MockProducts {
  static final List<ProductModel> products = [
    ProductModel(
      id: 'p_1',
      name: 'PashuMinerals Forte (1kg)',
      category: 'Supplement',
      price: 320.0,
      originalPrice: 400.0,
      rating: 4.9,
      description: 'High-potency chelated mineral mixture for cattle & buffaloes. Boosts milk fat % and immunity.',
      targetAnimal: 'Cattle & Buffalo',
    ),
    ProductModel(
      id: 'p_2',
      name: 'Calcium Boost Gel (300ml)',
      category: 'Supplement',
      price: 250.0,
      originalPrice: 290.0,
      rating: 4.8,
      description: 'Instant oral ionic calcium supplement for post-calving milk fever prevention.',
      targetAnimal: 'Cattle',
    ),
    ProductModel(
      id: 'p_3',
      name: 'WormOut Deworming Bolus',
      category: 'Medicine',
      price: 180.0,
      rating: 4.9,
      description: 'Veterinary broad-spectrum dewormer for cattle and livestock parasites.',
      targetAnimal: 'Cattle & Sheep',
      requiresPrescription: true,
    ),
    ProductModel(
      id: 'p_4',
      name: 'Canine Multivitamin Chews',
      category: 'Food',
      price: 650.0,
      originalPrice: 750.0,
      rating: 4.7,
      description: 'Essential joint, skin and coat health chews for active dogs.',
      targetAnimal: 'Dogs',
    ),
  ];
}
