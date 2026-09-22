import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock/mock_appointments.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  const AppointmentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = MockAppointments.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation History'),
        centerTitle: true,
      ),
      body: history.isEmpty
          ? const Center(child: Text('No past consultations found.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final appointment = history[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('MMM dd, yyyy').format(appointment.dateTime),
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.softMint,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                appointment.status,
                                style: const TextStyle(fontSize: 12, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Doctor: ${appointment.doctorName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Pet: ${appointment.petName}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(appointment.consultationType == 'Video Call' ? Icons.videocam : Icons.local_hospital, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(appointment.consultationType, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                            const Spacer(),
                            Text('₹${appointment.fee.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
