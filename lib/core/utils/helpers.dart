import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class Helpers {
  static String formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(0)}';
  }

  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'verified':
      case 'active':
        return AppColors.primaryGreen;
      case 'pending':
      case 'scheduled':
        return AppColors.teal;
      case 'cancelled':
      case 'emergency':
        return AppColors.emergencyRed;
      default:
        return AppColors.secondaryText;
    }
  }

  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.emergencyRed : AppColors.primaryDeepGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
