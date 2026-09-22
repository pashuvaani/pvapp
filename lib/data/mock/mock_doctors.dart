import '../../models/doctor_model.dart';

class MockDoctors {
  static final List<DoctorModel> doctors = [
    DoctorModel(
      id: 'doc_1',
      name: 'Dr. Kiran Bishnoi',
      qualification: 'B.V.Sc & A.H, M.V.Sc (Canine & Feline Medicine)',
      specialty: 'Canine & Feline Medicine',
      experienceYears: 1,
      rating: 4.9,
      totalConsultations: 320,
      fee: 199.0,
      isAvailable: true,
      clinicLocation: 'PashuCare Clinic, Sector 12, Gandhinagar',
    ),
    DoctorModel(
      id: 'doc_2',
      name: 'Dr. Ananya Jaitly',
      qualification: 'B.V.Sc & A.H, Small Animal Surgery',
      specialty: 'Canine Medicine',
      experienceYears: 1,
      rating: 4.8,
      totalConsultations: 290,
      fee: 199.0,
      isAvailable: true,
      clinicLocation: 'Anand Veterinary Health Center',
    ),
  ];
}
