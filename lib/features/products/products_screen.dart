import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../services/theme_service.dart';
import '../../core/network/api_client.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedCategory = 'All Products';
  final List<String> _categories = ['All Products', 'Pet Foods', 'Veterinary Medicine', 'Supplements'];

  final List<Map<String, dynamic>> _mockProducts = [
    {
      'name': 'MASTI-MIN Mineral Premix 1Kg',
      'price': '₹320',
      'rating': '4.8 (210 reviews)',
      'image': 'assets/images/products/product_01.jpeg',
    },
    {
      'name': 'MET-BOLYTE Syrup',
      'price': '₹250',
      'rating': '4.9 (185 reviews)',
      'image': 'assets/images/products/product_04.jpeg',
    },
    {
      'name': 'Utero-Kleen Wash',
      'price': '₹180',
      'rating': '4.7 (120 reviews)',
      'image': 'assets/images/products/product_05.jpeg',
    },
    {
      'name': 'Cattle & Buffalo Supplement',
      'price': '₹650',
      'rating': '4.9 (450 reviews)',
      'image': 'assets/images/products/product_02.jpeg',
    },
  ];

  late Future<List<Map<String, dynamic>>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  Future<List<Map<String, dynamic>>> _fetchProducts() async {
    try {
      final response = await ApiClient().get('/marketplace/products');
      if (response.isSuccess && response.data != null) {
        final dynamic responseData = response.data;
        dynamic rawData = responseData;
        if (responseData is Map) {
          rawData = responseData['data'] ?? responseData['products'] ?? responseData;
        }
      if (rawData is List && rawData.isNotEmpty) {
        return rawData.map<Map<String, dynamic>>((p) {
          List<String> imagesList = [];
          if (p['images'] is List && (p['images'] as List).isNotEmpty) {
            for (var item in (p['images'] as List)) {
              String img = item.toString();
              if (img.startsWith('/')) img = 'https://pashuvaani.com$img';
              imagesList.add(img);
            }
          }
          for (var key in ['image1', 'image2', 'image3', 'image_url', 'image']) {
            if (p[key] != null && p[key].toString().isNotEmpty && !imagesList.contains(p[key])) {
              String img = p[key].toString();
              if (img.startsWith('/')) img = 'https://pashuvaani.com$img';
              imagesList.add(img);
            }
          }
          if (imagesList.isEmpty) {
            imagesList.add('assets/images/products/product_01.jpeg');
          }
          String primaryImage = imagesList.first;

          return {
            'name': p['name'] ?? 'Product',
            'price': (p['price'] != null && p['price'].toString().isNotEmpty) ? '₹${p['price']}' : '₹250',
            'rating': 'Verified Product',
            'image': primaryImage,
            'images': imagesList,
            'description': p['description'] ?? p['details'] ?? p['desc'] ?? 'High quality veterinary healthcare and animal supplement product for cattle, pets, and livestock.',
            'category': p['category'] ?? p['type'] ?? 'Veterinary Healthcare',
          };
        }).toList();
      }
    }
    } catch (e) {
      debugPrint('Live products fetch error: $e');
    }
    return _mockProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
        ),
        title: Text('Pashu Raksha', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeService().themeMode,
              builder: (context, mode, _) {
                return Icon(
                  mode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                );
              },
            ),
            onPressed: () => ThemeService().toggleTheme(),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          ),
          IconButton(
            icon: Icon(Icons.person_outline_rounded, color: Theme.of(context).colorScheme.onSurface),
            tooltip: 'Profile & Settings',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.moreMenu),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Row
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, idx) {
                final c = _categories[idx];
                final isSelected = _selectedCategory == c;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = c),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryDeepGreen : Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? Colors.transparent : Theme.of(context).dividerColor.withValues(alpha: 0.15)),
                        boxShadow: isSelected && Theme.of(context).brightness == Brightness.dark
                            ? [
                                BoxShadow(
                                  color: AppColors.primaryDeepGreen.withValues(alpha: 0.6),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                )
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          c,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Product Grid
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final products = snapshot.data ?? _mockProducts;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final String imgPath = product['image'] ?? '';
                    Widget imageWidget;
                    if (imgPath.startsWith('http://') || imgPath.startsWith('https://')) {
                      imageWidget = Image.network(imgPath, fit: BoxFit.contain, errorBuilder: (_, __, ___) => Image.asset('assets/images/products/product_01.jpeg', fit: BoxFit.contain));
                    } else if (imgPath.startsWith('assets/')) {
                      imageWidget = Image.asset(imgPath, fit: BoxFit.contain);
                    } else {
                      imageWidget = Image.asset('assets/images/products/product_01.jpeg', fit: BoxFit.contain);
                    }

                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.productDetail, arguments: product),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
                          boxShadow: AppStyles.getBoxShadow(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dividerColor.withValues(alpha: 0.02),
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: imageWidget,
                                  ),
                                ),
                              ),
                            ),
                            // Details
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'] ?? '',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).colorScheme.onSurface),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.orange, size: 12),
                                      const SizedBox(width: 4),
                                      Text(
                                        product['rating'] ?? '4.8',
                                        style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        product['price'] ?? '',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryDeepGreen,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
