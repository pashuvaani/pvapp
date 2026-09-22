import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class PetCareTipsScreen extends StatefulWidget {
  const PetCareTipsScreen({super.key});

  @override
  State<PetCareTipsScreen> createState() => _PetCareTipsScreenState();
}

class _PetCareTipsScreenState extends State<PetCareTipsScreen> {
  bool _isHindi = false;
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _tips = [
    {
      'title': 'Balanced Diet & Nutrition for Cattle',
      'title_hi': 'मवेशियों के लिए संतुलित आहार और पोषण',
      'category': 'Cattle & Dairy',
      'content': 'Ensure cows and buffaloes receive a balanced mix of green fodder (berseem, sorghum), dry roughage, and mineral premix supplements. Balanced feeding prevents metabolic disorders and boosts milk yield.',
      'content_hi': 'सुनिश्चित करें कि गायों और भैंसों को हरे चारे, सूखे चारे और खनिज प्रीमिक्स पूरक का संतुलित मिश्रण मिले। संतुलित आहार दूध की पैदावार बढ़ाता है।',
      'icon': Icons.grass,
    },
    {
      'title': 'Clean Water & Hydration Hygiene',
      'title_hi': 'स्वच्छ पानी और जलयोजन स्वच्छता',
      'category': 'General Care',
      'content': 'Lactating animals require 70–100 liters of clean drinking water daily. Always clean water troughs daily to prevent bacterial or algal infection.',
      'content_hi': 'दुधारू पशुओं को रोजाना 70-100 लीटर साफ पानी की जरूरत होती है। जीवाणु संक्रमण को रोकने के लिए पानी की टंकियों को दैनिक साफ करें।',
      'icon': Icons.water_drop,
    },
    {
      'title': 'Timely Vaccination & Disease Prevention',
      'title_hi': 'समय पर टीकाकरण और बीमारी की रोकथाम',
      'category': 'Preventive Care',
      'content': 'Safeguard livestock against Foot-and-Mouth Disease (FMD), Hemorrhagic Septicemia (HS), and Black Quarter (BQ) by adhering strictly to government vaccination calendars.',
      'content_hi': 'सरकारी टीकाकरण कैलेंडर का कड़ाई से पालन करके मवेशियों को खुरपका-मुंहपका (FMD) और गलघोंटू से बचाएं।',
      'icon': Icons.vaccines,
    },
    {
      'title': 'Early Deworming Protocol for Calves',
      'title_hi': 'बछड़ों के लिए प्रारंभिक कृमिनाशक प्रोटोकॉल',
      'category': 'Calf Care',
      'content': 'Calves should be dewormed within the first 10-14 days of birth, then monthly up to 6 months. Colostrum feeding in first 2 hours of life is essential for calf survival.',
      'content_hi': 'बछड़ों को जन्म के पहले 10-14 दिनों के भीतर कीड़े की दवा दी जानी चाहिए। जीवन के पहले 2 घंटों में खीस (कोलस्ट्रम) पिलाना अनिवार्य है।',
      'icon': Icons.pets,
    },
    {
      'title': 'Hygienic Milking & Mastitis Prevention',
      'title_hi': 'स्वच्छ दोहन और थनेला (मास्टाइटिस) की रोकथाम',
      'category': 'Hygiene & Barn',
      'content': 'Clean teats with warm water and use post-milking teat dips. Keep barn floors dry and sanitized to prevent mastitis bacteria from entering teat canals.',
      'content_hi': 'दूध निकालने के बाद थनों को एंटीसेप्टिक घोल में डुबोएं। थनेला रोग से बचाव के लिए गोशाला के फर्श को सूखा और साफ रखें।',
      'icon': Icons.cleaning_services,
    },
    {
      'title': 'Summer Heat Stress Management for Pets',
      'title_hi': 'पालतू पशुओं के लिए गर्मी और लू से बचाव',
      'category': 'Smart Pets',
      'content': 'Never walk dogs on hot pavement during peak sun hours (11 AM - 4 PM). Provide shady resting spots, adequate fresh water, and watch for excessive panting.',
      'content_hi': 'दोपहर 11 बजे से 4 बजे के बीच पालतू कुत्तों को गर्म डामर सड़क पर न टहलाएं। उन्हें ठंडे छायादार स्थान में रखें और ताजा पानी उपलब्ध कराएं।',
      'icon': Icons.wb_sunny,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTips = _tips.where((t) {
      return _selectedCategory == 'All' || t['category'] == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet & Animal Care Tips', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                _isHindi = !_isHindi;
              });
            },
            icon: const Icon(Icons.language, size: 18, color: AppColors.primaryDeepGreen),
            label: Text(
              _isHindi ? 'English' : 'हिंदी',
              style: const TextStyle(
                color: AppColors.primaryDeepGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['All', 'Cattle & Dairy', 'General Care', 'Preventive Care', 'Calf Care', 'Hygiene & Barn', 'Smart Pets'].map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(cat),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.primaryDeepGreen,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                    selectedColor: AppColors.primaryDeepGreen,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.primaryDeepGreen : AppColors.primaryDeepGreen.withValues(alpha: 0.2),
                      ),
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTips.length,
              itemBuilder: (context, index) {
                final tip = filteredTips[index];
                final String title = _isHindi ? tip['title_hi'] : tip['title'];
                final String content = _isHindi ? tip['content_hi'] : tip['content'];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                  color: Theme.of(context).cardTheme.color,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.softMint,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(tip['icon'] as IconData, color: AppColors.primaryDeepGreen, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryDeepGreen.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tip['category']!,
                                style: const TextStyle(fontSize: 11, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          content,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                            height: 1.5,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
