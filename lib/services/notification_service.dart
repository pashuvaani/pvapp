import 'package:flutter/material.dart';

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final String type; // appointment, reminder, emergency

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
  });
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final ValueNotifier<List<AppNotification>> notifications = ValueNotifier([
    AppNotification(
      id: 'n_1',
      title: 'Vaccination Due Tomorrow 💉',
      body: 'Gauri (Holstein Friesian Cow) is due for FMD booster vaccine.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: 'reminder',
    ),
    AppNotification(
      id: 'n_2',
      title: 'Consultation Confirmed 🩺',
      body: 'Dr. Ramesh Patel has accepted your video consultation for tomorrow 10:30 AM.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      type: 'appointment',
    ),
  ]);

  void addNotification(AppNotification notification) {
    final newList = List<AppNotification>.from(notifications.value);
    newList.insert(0, notification);
    notifications.value = newList;
  }
}
