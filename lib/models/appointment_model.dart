class AppointmentModel {
  final String id;
  final String petId;
  final String petName;
  final String doctorId;
  final String doctorName;
  final DateTime dateTime;
  final String consultationType; // Video Call, Home Visit, Clinic Visit
  final String status; // Scheduled, Completed, Cancelled
  final double fee;
  final String symptoms;

  AppointmentModel({
    required this.id,
    required this.petId,
    required this.petName,
    required this.doctorId,
    required this.doctorName,
    required this.dateTime,
    required this.consultationType,
    required this.status,
    required this.fee,
    required this.symptoms,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? '',
      petId: json['petId'] ?? '',
      petName: json['petName'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      dateTime: DateTime.parse(json['dateTime']),
      consultationType: json['consultationType'] ?? 'Video Call',
      status: json['status'] ?? 'Scheduled',
      fee: (json['fee'] ?? 0.0).toDouble(),
      symptoms: json['symptoms'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'petId': petId,
      'petName': petName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'dateTime': dateTime.toIso8601String(),
      'consultationType': consultationType,
      'status': status,
      'fee': fee,
      'symptoms': symptoms,
    };
  }
}
