import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';

class VetListScreen extends StatelessWidget {
  const VetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Our Vet Team'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: const CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.softMint,
                child: Text('👨‍⚕️', style: TextStyle(fontSize: 24)),
              ),
              title: const Text('Dr. Ramesh Patel', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Senior Livestock Specialist • 14 Yrs Exp'),
              trailing: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.vetProfile),
                child: const Text('Profile'),
              ),
            ),
          );
        },
      ),
    );
  }
}
