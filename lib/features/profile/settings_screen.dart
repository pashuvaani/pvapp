import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_styles.dart';
import '../../shared/widgets/custom_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English';
  bool _pushNotifications = true;
  bool _whatsappReminders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('App Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Language Preferences', style: AppStyles.heading3),
          const SizedBox(height: 8),
          CustomCard(
            child: DropdownButtonFormField<String>(
              initialValue: _selectedLanguage,
              decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
              items: AppConstants.languages.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
              onChanged: (val) => setState(() => _selectedLanguage = val!),
            ),
          ),
          const SizedBox(height: 24),
          Text('Notifications & Alerts', style: AppStyles.heading3),
          const SizedBox(height: 8),
          CustomCard(
            child: Column(
              children: [
                SwitchListTile(
                  value: _pushNotifications,
                  title: const Text('Push Notifications'),
                  subtitle: const Text('Vaccination reminders & doctor updates'),
                  activeThumbColor: AppColors.primaryDeepGreen,
                  onChanged: (val) => setState(() => _pushNotifications = val),
                ),
                const Divider(),
                SwitchListTile(
                  value: _whatsappReminders,
                  title: const Text('WhatsApp Alerts'),
                  subtitle: const Text('Get prescription PDF link on WhatsApp'),
                  activeThumbColor: AppColors.primaryDeepGreen,
                  onChanged: (val) => setState(() => _whatsappReminders = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
