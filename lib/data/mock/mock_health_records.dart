import '../../models/health_record_model.dart';

class MockHealthRecords {
  static final List<HealthRecordModel> records = [
    HealthRecordModel(
      id: 'hr_1',
      petId: 'an_1',
      title: 'Bovine Mastitis Treatment',
      doctorName: 'Dr. Ramesh Patel',
      date: DateTime.now().subtract(const Duration(days: 12)),
      diagnosis: 'Mild Left Quarter Mastitis',
      prescriptionNotes: 'Intramammary antibiotic infusion + Anti-inflammatory 3 days.',
      reportPdfUrl: 'assets/docs/prescription_1.pdf',
    ),
  ];
}
