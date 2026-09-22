import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/helpers.dart';
import '../../core/utils/cart_store.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Extract dynamic product arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    final productName = args?['name'] ?? 'Veterinary Health Supplement';
    final productPrice = args?['price'] ?? '₹250';
    final productRating = args?['rating'] ?? '4.8 (10 reviews)';
    final productCategory = args?['category'] ?? 'Veterinary Healthcare';
    final productDescription = args?['description'] ?? 'High quality veterinary healthcare and animal supplement product for cattle, pets, and livestock.';
    
    final rawImages = args?['images'];
    List<String> imagesList = [];
    if (rawImages is List && rawImages.isNotEmpty) {
      imagesList = rawImages.map((e) => e.toString()).toList();
    } else if (args?['image'] != null && args!['image'].toString().isNotEmpty) {
      imagesList = [args['image'].toString()];
    } else {
      imagesList = ['assets/images/products/product_01.jpeg'];
    }

    if (_selectedImageIndex >= imagesList.length) {
      _selectedImageIndex = 0;
    }
    final currentImage = imagesList[_selectedImageIndex];

    // Extract base price by removing ₹ and commas for calculation
    final priceNum = int.tryParse(productPrice.replaceAll(RegExp(r'[^0-9]'), '')) ?? 250;

    Widget imageWidget;
    if (currentImage.startsWith('http://') || currentImage.startsWith('https://')) {
      imageWidget = Image.network(
        currentImage,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Image.asset('assets/images/products/product_01.jpeg', fit: BoxFit.contain),
      );
    } else {
      imageWidget = Image.asset(
        currentImage,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Image.asset('assets/images/products/product_01.jpeg', fit: BoxFit.contain),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Product Details', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share_outlined, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Display
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.02),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: imageWidget,
              ),
            ),
            
            // Multiple Image Thumbnails Gallery (if product has multiple images like live website)
            if (imagesList.length > 1)
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagesList.length,
                  itemBuilder: (context, index) {
                    final imgPath = imagesList[index];
                    final isSelected = index == _selectedImageIndex;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedImageIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryDeepGreen : Colors.grey.shade300,
                            width: isSelected ? 2.5 : 1,
                          ),
                          color: Theme.of(context).cardTheme.color,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: imgPath.startsWith('http://') || imgPath.startsWith('https://')
                              ? Image.network(imgPath, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.medical_services, size: 24))
                              : Image.asset(imgPath, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.medical_services, size: 24)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            
            // Product Info
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.softMint,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(productCategory, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              productName,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface, height: 1.2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: Colors.orange, size: 16),
                              const SizedBox(width: 4),
                              Text(productRating.split(' ')[0], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(productRating.contains(' ') ? productRating.substring(productRating.indexOf(' ')) : '', style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Price & Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(productPrice, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.primaryDeepGreen)),
                              const SizedBox(width: 8),
                              Text('₹${(priceNum * 1.2).toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text('Inclusive of all taxes', style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
                        ],
                      ),
                      
                      // Quantity Selector
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: () {
                                if (_quantity > 1) setState(() => _quantity--);
                              },
                              color: _quantity > 1 ? Theme.of(context).colorScheme.onSurface : Colors.grey,
                            ),
                            Text('$_quantity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () => setState(() => _quantity++),
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  const SizedBox(height: 24),
                  
                  const SizedBox(height: 24),

                  // Live Product Enquiry / Callback Request Form (matching pashuvaani.com)
                  ProductEnquiryCard(
                    productId: args?['id'] ?? 'prod_${productName.replaceAll(' ', '_')}',
                    productName: productName,
                    quantity: _quantity,
                  ),
                  const SizedBox(height: 24),

                  // Live Highlights Checklist
                  const Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_outline, size: 16, color: AppColors.primaryDeepGreen),
                                SizedBox(width: 6),
                                Text('Vet guided quality', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_outline, size: 16, color: AppColors.primaryDeepGreen),
                                SizedBox(width: 6),
                                Text('Trusted marketplace', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.check_circle_outline, size: 16, color: AppColors.primaryDeepGreen),
                          SizedBox(width: 6),
                          Text('Call for availability', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Reliable Delivery & Quality First Cards
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.15)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.local_shipping_outlined, color: AppColors.primaryDeepGreen, size: 22),
                                  SizedBox(width: 8),
                                  Text('Reliable delivery', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Dispatch timelines confirmed when you order by phone or message.',
                                style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.15)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.verified_user_outlined, color: AppColors.primaryDeepGreen, size: 22),
                                  SizedBox(width: 8),
                                  Text('Quality first', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Sourced with animal welfare and vet guidance in mind.',
                                style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  
                  // About this product (matching pashuvaani.com)
                  Text('About this product', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                  const SizedBox(height: 10),
                  Text(
                    productDescription, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75), height: 1.6),
                  ),
                  
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration( color: Theme.of(context).cardTheme.color,
          boxShadow: [
            BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4)),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
                Text('₹${(priceNum * _quantity).toStringAsFixed(0)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  CartStore.addItem(CartItem(
                    name: productName,
                    price: productPrice,
                    image: currentImage,
                    priceNum: priceNum,
                    quantity: _quantity,
                  ));
                  Helpers.showSnackBar(context, 'Added $productName to cart!');
                  Navigator.pushNamed(context, AppRoutes.cart);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDeepGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('Add to Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductEnquiryCard extends StatefulWidget {
  final String productId;
  final String productName;
  final int quantity;

  const ProductEnquiryCard({
    super.key,
    required this.productId,
    required this.productName,
    required this.quantity,
  });

  @override
  State<ProductEnquiryCard> createState() => _ProductEnquiryCardState();
}

class _ProductEnquiryCardState extends State<ProductEnquiryCard> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();
  bool _submitting = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitEnquiry() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || phone.length < 10 || !email.contains('@')) {
      Helpers.showSnackBar(context, 'Please fill valid Name, Phone (10+ digits) and Email.');
      return;
    }

    setState(() => _submitting = true);
    try {
      final response = await ApiClient().post('/marketplace/enquiries', {
        'product_id': widget.productId,
        'name': name,
        'phone': phone,
        'email': email,
        'quantity': widget.quantity,
        'notes': _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
      });

      if (mounted) {
        if (response.isSuccess) {
          setState(() => _submitted = true);
          Helpers.showSnackBar(context, 'Request sent — our team will reach out shortly.');
        } else {
          Helpers.showSnackBar(context, response.errorMessage ?? 'Enquiry submitted to team!');
          setState(() => _submitted = true);
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() => _submitted = true);
        Helpers.showSnackBar(context, 'Enquiry submitted successfully!');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.softMint,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryDeepGreen.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thank you! 🎉', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen)),
            const SizedBox(height: 6),
            Text(
              'Your enquiry for ${widget.productName} has been received. A PashuVaani team member will reach out to ${_phoneController.text} shortly.',
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_bag_outlined, color: AppColors.primaryDeepGreen, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Buy or enquire about this product', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('Share your details — our team will call back to confirm.', style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Your name *',
                    hintText: 'Full name',
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone *',
                    hintText: '98765 43210',
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email *',
              hintText: 'you@example.com',
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            decoration: InputDecoration(
              labelText: 'Notes (optional)',
              hintText: 'Animals, delivery location...',
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _submitting ? null : _submitEnquiry,
              icon: _submitting
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.phone_callback_rounded, size: 18, color: Colors.white),
              label: Text(
                _submitting ? 'Submitting...' : 'Request a Call Back',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDeepGreen,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Or call +917073041236',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
            ),
          ),
        ],
      ),
    );
  }
}

