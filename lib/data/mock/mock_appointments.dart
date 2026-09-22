import '../../models/appointment_model.dart';

class MockAppointments {
  static final List<AppointmentModel> appointments = [
    AppointmentModel(
      id: 'app_1',
      petId: 'an_1',
      petName: 'Gauri 🐮',
      doctorId: 'doc_1',
      doctorName: 'Dr. Ramesh Patel',
      dateTime: DateTime.now().add(const Duration(days: 1)),
      consultationType: 'Video Call',
      status: 'Scheduled',
      fee: 350.0,
      symptoms: 'Reduced milk yield and mild fever in evening.',
    ),
  ];

  static final List<AppointmentModel> history = [
    AppointmentModel(
      id: 'app_hist_1',
      petId: 'an_1',
      petName: 'Gauri 🐮',
      doctorId: 'doc_2',
      doctorName: 'Dr. Ananya Sharma',
      dateTime: DateTime.now().subtract(const Duration(days: 15)),
      consultationType: 'In-Clinic',
      status: 'Completed',
      fee: 500.0,
      symptoms: 'Routine checkup and deworming.',
    ),
    AppointmentModel(
      id: 'app_hist_2',
      petId: 'an_2',
      petName: 'Sheru 🐶',
      doctorId: 'doc_3',
      doctorName: 'Dr. Gurpreet Singh',
      dateTime: DateTime.now().subtract(const Duration(days: 45)),
      consultationType: 'Video Call',
      status: 'Completed',
      fee: 300.0,
      symptoms: 'Skin allergy consultation.',
    ),
  ];
}
