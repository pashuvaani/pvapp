import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  bool _isHindi = false;
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _faqs = [
    {
      'category': 'General',
      'q': 'What is PashuVaani?',
      'q_hi': 'पशुवाणी क्या है?',
      'a': 'PashuVaani is an AI-powered animal health guidance platform designed to provide early awareness and structured support for pet owners and dairy farmers in India.',
      'a_hi': 'पशुवाणी एक AI आधारित पशु स्वास्थ्य मार्गदर्शन प्लेटफॉर्म है जो भारत में पेट ओनर्स और डेयरी किसानों को शुरुआती जागरूकता और संरचित सहायता प्रदान करने के लिए बनाया गया है।'
    },
    {
      'category': 'Gopu AI',
      'q': 'Does Gopu AI diagnose diseases?',
      'q_hi': 'क्या गोपू AI बीमारियों का निदान करता है?',
      'a': 'No. Gopu AI provides early guidance and risk awareness but does not replace veterinary diagnosis or treatment.',
      'a_hi': 'नहीं। गोपू AI केवल शुरुआती मार्गदर्शन और जोखिम जागरूकता देता है और पशु चिकित्सक के निदान या उपचार की जगह नहीं लेता।'
    },
    {
      'category': 'Suraksha Plan',
      'q': 'How does the PashuCare Suraksha Credit System work?',
      'q_hi': 'पशुकेयर सुरक्षा क्रेडिट सिस्टम कैसे काम करता है?',
      'a': 'You get 10 free messages every day to try Gopu AI. After 10 messages, you can buy a Daily Pass for ₹10 (24 hours unlimited) or Monthly Smart Plan for ₹199.',
      'a_hi': 'आपको गोपू AI आजमाने के लिए रोज 10 मुफ्त संदेश मिलते हैं। 10 संदेशों के बाद, आप ₹10 में दैनिक पास या ₹199 में मासिक स्मार्ट प्लान ले सकते हैं।'
    },
    {
      'category': 'Consultations',
      'q': 'How do I book a video consultation with a vet?',
      'q_hi': 'मैं पशु चिकित्सक के साथ वीडियो परामर्श कैसे बुक करूं?',
      'a': 'Go to the Consultation tab and tap on "Video Consultation". Select an available vet, pick your preferred date and slot, and confirm booking.',
      'a_hi': 'परामर्श टैब पर जाएं और "वीडियो परामर्श" पर टैप करें। एक पशु चिकित्सक चुनें, अपनी पसंदीदा तारीख और समय चुनें, और बुकिंग की पुष्टि करें।'
    },
    {
      'category': 'Health Records',
      'q': 'Can I add multiple animals and track vaccination schedules?',
      'q_hi': 'क्या मैं कई पशु जोड़ सकता हूं और टीकाकरण को ट्रैक कर सकता हूं?',
      'a': 'Yes! Navigate to "My Animals" to add profile cards for your cattle or pets. You can maintain digital health passports and receive automated vaccination reminders.',
      'a_hi': 'हाँ! अपने मवेशियों या पालतू जानवरों के लिए प्रोफ़ाइल जोड़ने के लिए "मेरे पशु" पर जाएँ। आप डिजिटल स्वास्थ्य पासपोर्ट रख सकते हैं और स्वचालित टीकाकरण अनुस्मारक प्राप्त कर सकते हैं।'
    },
    {
      'category': 'Marketplace',
      'q': 'Do you deliver veterinary products across India?',
      'q_hi': 'क्या आप पूरे भारत में पशु चिकित्सा उत्पाद वितरित करते हैं?',
      'a': 'Yes, you can order verified mineral premixes, syrups, and supplements through our Products section with delivery across pin codes in India.',
      'a_hi': 'हाँ, आप भारत में पिन कोड पर डिलीवरी के साथ हमारे उत्पाद अनुभाग के माध्यम से खनिज प्रीमिक्स, सिरप और पूरक ऑर्डर कर सकते हैं।'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = _faqs.where((faq) {
      return _selectedCategory == 'All' || faq['category'] == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions', style: TextStyle(fontWeight: FontWeight.bold)),
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
          // Category Filter Chips
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['All', 'General', 'Gopu AI', 'Suraksha Plan', 'Consultations', 'Health Records', 'Marketplace'].map((cat) {
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
              itemCount: filteredFaqs.length,
              itemBuilder: (context, index) {
                final faq = filteredFaqs[index];
                final String question = _isHindi ? faq['q_hi'] : faq['q'];
                final String answer = _isHindi ? faq['a_hi'] : faq['a'];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  color: Theme.of(context).cardTheme.color,
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      iconColor: AppColors.primaryDeepGreen,
                      title: Text(
                        question,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            answer,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                        )
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
