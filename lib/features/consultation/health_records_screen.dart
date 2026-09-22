import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/user_store.dart';

class HealthRecordsScreen extends StatefulWidget {
  const HealthRecordsScreen({super.key});

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {
  int _selectedTabIndex = 0;
  bool _isLoading = true;
  List<Map<String, dynamic>> _records = [];

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  Future<void> _fetchRecords() async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiClient().get('/health-records');
      if (response.isSuccess && response.data != null && response.data is List) {
        final list = (response.data as List).cast<Map<String, dynamic>>();
        setState(() {
          _records = list;
          _isLoading = false;
        });
        return;
      }
    } catch (_) {}

    // Default fallback initial list if offline or no records
    setState(() {
      _records = [
        {
          'id': 'rec_1',
          'title': 'Vaccination',
          'record_type': 'Vaccination',
          'diagnosis': 'Rabies Vaccine',
          'doctor_name': 'Dr. Ramesh Patel',
          'date': '2024-05-12T00:00:00.000Z',
          'status': 'Completed',
        },
        {
          'id': 'rec_2',
          'title': 'Health Checkup',
          'record_type': 'Consultation',
          'diagnosis': 'General Checkup - Healthy',
          'doctor_name': 'Dr. Ananya Jaitly',
          'date': '2024-05-05T00:00:00.000Z',
          'status': 'Normal',
        },
        {
          'id': 'rec_3',
          'title': 'Deworming',
          'record_type': 'Prescription',
          'diagnosis': 'Drontal Plus Administered',
          'doctor_name': 'Dr. Kiran Bishnoi',
          'date': '2024-04-18T00:00:00.000Z',
          'status': 'Completed',
        },
      ];
      _isLoading = false;
    });
  }

  void _showAddRecordDialog() {
    final titleController = TextEditingController();
    final doctorController = TextEditingController();
    final diagnosisController = TextEditingController();
    String selectedType = 'Consultation';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add Health Record',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Record Title *',
                      hintText: 'e.g. Rabies Vaccination, Routine Checkup',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Record Type',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Consultation', child: Text('Consultation')),
                      DropdownMenuItem(value: 'Vaccination', child: Text('Vaccination')),
                      DropdownMenuItem(value: 'Lab Report', child: Text('Lab Report')),
                      DropdownMenuItem(value: 'Prescription', child: Text('Prescription')),
                    ],
                    onChanged: (val) {
                      if (val != null) setModalState(() => selectedType = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: doctorController,
                    decoration: const InputDecoration(
                      labelText: 'Doctor / Vet Name',
                      hintText: 'e.g. Dr. Ananya Jaitly',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: diagnosisController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Diagnosis & Notes',
                      hintText: 'Prescription or medical observation...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final title = titleController.text.trim();
                        if (title.isEmpty) return;

                        final newRecord = {
                          'pet_name': UserStore.currentUser.petName,
                          'title': title,
                          'record_type': selectedType,
                          'doctor_name': doctorController.text.trim().isEmpty
                              ? 'Dr. Vet'
                              : doctorController.text.trim(),
                          'diagnosis': diagnosisController.text.trim(),
                          'prescription_notes': diagnosisController.text.trim(),
                          'date': DateTime.now().toIso8601String(),
                        };

                        Navigator.pop(ctx);
                        setState(() => _isLoading = true);

                        final res = await ApiClient().post('/health-records', newRecord);
                        if (res.isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('✅ Health record saved successfully!'),
                              backgroundColor: AppColors.primaryDeepGreen,
                            ),
                          );
                        }
                        await _fetchRecords();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDeepGreen,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Save Record', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> get _filteredRecords {
    if (_selectedTabIndex == 1) {
      return _records.where((r) => r['record_type'] == 'Vaccination' || r['title'].toString().toLowerCase().contains('vaccin')).toList();
    }
    if (_selectedTabIndex == 2) {
      return _records.where((r) =>
          r['record_type'] == 'Lab Report' ||
          r['record_type'] == 'Prescription' ||
          r['record_type'] == 'Consultation').toList();
    }
    return _records;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Image.asset(
          'assets/images/logo/logopsv.png',
          height: 32,
          width: 32,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          IconButton(
            icon: Icon(Icons.person_outline_rounded, color: Theme.of(context).colorScheme.onSurface),
            tooltip: 'Profile & Settings',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.moreMenu),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Health Records', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface)),
                const SizedBox(height: 4),
                Text('Track your pet\'s health\nhistory & stay updated', style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                _buildTab('All Records', isActive: _selectedTabIndex == 0, index: 0),
                _buildTab('Vaccinations', isActive: _selectedTabIndex == 1, index: 1),
                _buildTab('Reports', isActive: _selectedTabIndex == 2, index: 2),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
          // List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      // Pet Passport Card
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.petPassport);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.healthBlue, Color(0xFF0D3D61)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppStyles.getBoxShadow(context),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                                ),
                                child: const Icon(Icons.assignment_ind_rounded, color: Colors.white, size: 30),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Pet Passport', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                    const SizedBox(height: 4),
                                    Text('Travel docs, ID & Certifications', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('View', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                              )
                            ],
                          ),
                        ),
                      ),
                      // General Records List
                      if (_filteredRecords.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text('No health records found in this category.'),
                          ),
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
                            boxShadow: AppStyles.getBoxShadow(context),
                          ),
                          child: Column(
                            children: _filteredRecords.asMap().entries.map((entry) {
                              final idx = entry.key;
                              final item = entry.value;
                              final isLast = idx == _filteredRecords.length - 1;
                              final dateStr = item['date']?.toString() ?? '';
                              String formattedDate = 'Recent';
                              if (dateStr.isNotEmpty) {
                                try {
                                  final dt = DateTime.parse(dateStr);
                                  formattedDate = '${dt.day}/${dt.month}/${dt.year}';
                                } catch (_) {}
                              }
                              return Column(
                                children: [
                                  _buildRecordItem(
                                    context,
                                    icon: item['record_type'] == 'Vaccination'
                                        ? Icons.vaccines_outlined
                                        : item['record_type'] == 'Prescription'
                                            ? Icons.medication_liquid_outlined
                                            : Icons.health_and_safety_outlined,
                                    title: item['title']?.toString() ?? 'Health Record',
                                    subtitle: item['diagnosis']?.toString() ?? item['doctor_name']?.toString() ?? 'General Checkup',
                                    date: formattedDate,
                                    status: item['status']?.toString() ?? 'Completed',
                                  ),
                                  if (!isLast) const Divider(height: 1, indent: 60, endIndent: 20),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
          ),
          // Bottom Doctor-Certified Info Banner
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryDeepGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryDeepGreen.withValues(alpha: 0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified_user_outlined, color: AppColors.primaryDeepGreen, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Verified Doctor Records — Automatically logged by certified veterinarians after every consultation & vaccination.',
                      style: TextStyle(fontSize: 12, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, {required bool isActive, required int index}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.primaryDeepGreen : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? AppColors.primaryDeepGreen : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordItem(BuildContext context, {required IconData icon, required String title, required String subtitle, required String date, required String status}) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.healthRecordDetail),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryDeepGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryDeepGreen, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
                  const SizedBox(height: 2),
                  Text(date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
            Text(status, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.primaryDeepGreen)),
          ],
        ),
      ),
    );
  }
}
