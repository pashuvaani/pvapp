import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Supplements 💊', 'Medicines 🧪', 'Food 🌾', 'Accessories 🦮'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Pashu Pharmacy & Care'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search minerals, vaccines, supplements...',
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.secondaryText),
                filled: true,
                fillColor: Theme.of(context).cardTheme.color,
              ),
            ),
          ),
          // Category Chips
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: AppColors.primaryDeepGreen,
                    backgroundColor: Theme.of(context).cardTheme.color,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.primaryText),
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final images = ['assets/images/products/product_01.jpeg', 'assets/images/products/product_04.jpeg', 'assets/images/products/product_05.jpeg', 'assets/images/products/product_02.jpeg'];
                final titles = ['MASTI-MIN Mineral Premix 1Kg', 'MET-BOLYTE', 'Utero-Kleen', 'Cattle & Buffalo Syrup'];
                final prices = ['₹320', '₹250', '₹180', '₹650'];
                final badges = ['Cattle & Buffalo', 'Dairy Cows', 'Dairy Cows', 'Dogs & Pets'];

                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.productDetail),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: AppStyles.cardBorderRadius,
                      border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
                      boxShadow: const [AppStyles.cardShadow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.lightMintBg,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.softMint,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(badges[index], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
                        ),
                        const SizedBox(height: 6),
                        Text(titles[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(prices[index], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryDeepGreen,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add_shopping_cart_rounded, color: Colors.white, size: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
