import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/helpers.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('My Pharmacy Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomCard(
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.lightMintBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(child: Text('💊', style: TextStyle(fontSize: 30))),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('PashuMinerals Forte (1kg)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(height: 4),
                            Text('Qty: 1 • ₹320', style: TextStyle(color: AppColors.primaryDeepGreen, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.emergencyRed),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text('Rajesh Kumar • +91 9876543210', style: AppStyles.bodyText),
                      Text('House 42, Anand District, Gujarat - 388001', style: AppStyles.subtext),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CustomCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Items Total'), Text('₹320')],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Delivery Charge'), Text('FREE', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold))],
                      ),
                      Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Grand Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('₹320', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryDeepGreen)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardTheme.color,
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Place Order • ₹320',
                isGradient: true,
                onPressed: () {
                  Helpers.showSnackBar(context, 'Order placed successfully! Delivery expected in 2 days.');
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
