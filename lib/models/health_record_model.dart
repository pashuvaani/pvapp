class HealthRecordModel {
  final String id;
  final String petId;
  final String title;
  final String doctorName;
  final DateTime date;
  final String diagnosis;
  final String prescriptionNotes;
  final String? reportPdfUrl;

  HealthRecordModel({
    required this.id,
    required this.petId,
    required this.title,
    required this.doctorName,
    required this.date,
    required this.diagnosis,
    required this.prescriptionNotes,
    this.reportPdfUrl,
  });

  factory HealthRecordModel.fromJson(Map<String, dynamic> json) {
    return HealthRecordModel(
      id: json['id'] ?? '',
      petId: json['petId'] ?? '',
      title: json['title'] ?? '',
      doctorName: json['doctorName'] ?? '',
      date: DateTime.parse(json['date']),
      diagnosis: json['diagnosis'] ?? '',
      prescriptionNotes: json['prescriptionNotes'] ?? '',
      reportPdfUrl: json['reportPdfUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'petId': petId,
      'title': title,
      'doctorName': doctorName,
      'date': date.toIso8601String(),
      'diagnosis': diagnosis,
      'prescriptionNotes': prescriptionNotes,
      'reportPdfUrl': reportPdfUrl,
    };
  }
}
