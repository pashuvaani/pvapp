import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants/app_colors.dart';
import '../../core/network/api_client.dart';

class ArticlesVideosScreen extends StatefulWidget {
  const ArticlesVideosScreen({super.key});

  @override
  State<ArticlesVideosScreen> createState() => _ArticlesVideosScreenState();
}

class _ArticlesVideosScreenState extends State<ArticlesVideosScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _liveBlogs = [
    {
      'id': 'a118575a-900b-4614-bdc1-63413b1ebf7b',
      'title': 'Neglect Hurts More Than Any Disease: Why Our Animals Really Suffer',
      'title_hi': 'उपेक्षा किसी भी बीमारी से अधिक दर्द देती है: हमारे जानवर वास्तव में क्यों पीड़ित हैं',
      'tag': 'ANIMAL HEALTH',
      'readTime': '5 min read',
      'author': 'Dr. Ananya Jaitly',
      'image': 'https://images.unsplash.com/photo-1576201836106-db1758fd1c97',
      'description': 'Catching subtle warning signs early through consistent daily care prevents minor health issues from becoming severe animal emergencies. (By, Dr. Ananya Jaitly)',
      'description_hi': 'लगातार दैनिक देखभाल के माध्यम से सूक्ष्म चेतावनी संकेतों को जल्दी पकड़ना मामूली स्वास्थ्य समस्याओं को गंभीर पशु आपात स्थिति बनने से रोकता है।\n\nडॉ. अनन्या जेटली',
      'content': '''People say they want their pets and farm animals to be healthy. But, the truth is, what hurts animals most isn’t skipping the latest vet treatments or not having fancy gear. It’s something simpler: people just miss the early warning signs, or they see them and shrug them off. Neglect causes more suffering than almost anything else.

Here’s what usually happens: most problems don’t roll in with sirens blaring. They sneak up, showing tiny changes at first. A dog that seems a little quieter than usual. A cow who leaves food in the trough. A goat suddenly hanging back from the herd. These little things? If you notice and jump in early, you can save your animal a world of trouble and spare yourself a ton of stress and expense. Ignore it for too long, and you’re dealing with a full-blown emergency.

So, how do you actually do better for your animals? Surprisingly, it’s not rocket science. Small habits, done every day, matter:

1. Notice the Small Stuff
Animals don’t complain when they feel off. It’s up to you to catch those subtle changes—sleeping more than usual, acting grouchy, or just seeming a bit "off." Jump on those little things early and you’ll prevent a lot of big headaches.

2. Watch How They Eat
If they’re off their food, don’t ignore it. Appetite changes are big clues something’s wrong. Trying to force-feed or pretending it’s nothing won’t help. Pay attention and start figuring out why.

3. Use Simple Tech like GOPU AI
Sometimes you can’t get the vet on the line right away. That’s when apps and chatbots like GOPU come in handy. Chatbot like GOPU AI helps you manage the situation, until the vet arrives at the location.

4. Consult a Vet
If something feels wrong, run it by a veterinarian. Even online portals like PashuVaani connect you with experts before things spiral.

In the end, animals suffer most when nobody’s really watching. Pay attention, take small changes seriously, and act fast when things don’t seem right. That extra bit of care isn’t just good for your animals, it saves you a load of worry, and sometimes, it saves a life. Don’t wait it out. Step in. That’s what makes the real difference.

Written By, Dr. Ananya Jaitly''',
      'content_hi': '''लोग कहते हैं कि वे चाहते हैं कि उनके पालतू जानवर और खेत के जानवर स्वस्थ रहें। लेकिन, सच्चाई यह है कि जानवरों को सबसे ज़्यादा जो नुकसान होता है, वह है नवीनतम पशु चिकित्सक उपचारों को न छोड़ना या फैंसी गियर न रखना। यह कुछ आसान है, लोग बस शुरुआती चेतावनी संकेतों को याद करते हैं, या वे उन्हें देखते हैं और उन्हें बंद कर देते हैं। उपेक्षा, लगभग किसी भी चीज़ की तुलना में अधिक पीड़ा का कारण बनती है।

यहाँ बताया गया है कि आमतौर पर क्या होता है: अधिकांश समस्याएं सायरन के धुंधलेपन के साथ नहीं आती हैं। वे चुपके से उठते हैं, शुरू में छोटे बदलाव दिखाते हैं। एक कुत्ता जो सामान्य से थोड़ा शांत लगता है। एक गाय जो गर्त में भोजन छोड़ देती है। एक बकरी अचानक झुंड से वापस लटकी हुई है। ये छोटी - छोटी बातें? यदि आप ध्यान देते हैं और जल्दी कूदते हैं, तो आप अपने जानवर को मुसीबत की दुनिया से बचा सकते हैं और अपने आप को तनाव और खर्च का एक टन बचा सकते हैं। इसे बहुत लंबे समय तक अनदेखा करें, और आप एक पूर्ण विकसित आपात स्थिति से निपट रहे हैं।

तो, आप वास्तव में अपने जानवरों के लिए बेहतर कैसे करते हैं? हैरानी की बात है, यह रॉकेट विज्ञान नहीं है। छोटी आदतें, जो हर दिन की जाती हैं, मायने रखती हैं:

1. छोटे सामान पर ध्यान दें
जानवरों को महसूस होने पर शिकायत नहीं होती है। उन सूक्ष्म परिवर्तनों को पकड़ना, सामान्य से अधिक सोना, घबराहट करना, या बस थोड़ा "बंद" दिखना आपके ऊपर है। उन छोटी चीजों पर जल्दी से कूदो और आप बहुत सारे बड़े सिरदर्द को रोकेंगे।

2. देखें कि वे कैसे खाते हैं
अगर वे अपने भोजन से दूर हैं, तो इसे अनदेखा न करें। भूख में बदलाव बड़े संकेत हैं कि कुछ गड़बड़ है। जबरदस्ती - फ़ीड करने की कोशिश करना या इसका नाटक करना कुछ भी मदद नहीं करेगा। ध्यान दें और इसका कारण समझना शुरू करें।

3. GOPU AI जैसी सरल तकनीक का उपयोग करें
कभी - कभी आप पशु चिकित्सक को तुरंत लाइन पर नहीं ला सकते। ऐसा तब होता है जब GOPU जैसे ऐप और चैटबॉट काम में आते हैं। जीओपीयू एआई (GOPU AI) जैसे चैटबॉट आपको स्थिति को प्रबंधित करने में मदद करते हैं, जब तक कि पशु चिकित्सक लोकेशन पर नहीं पहुंच जाता।

4. एक पशु चिकित्सक से परामर्श करें
अगर कोई गड़बड़ी महसूस होती है, तो उसे किसी पशु चिकित्सक द्वारा चलाएँ। यहां तक कि पशुवाणी जैसे ऑनलाइन पोर्टल भी सर्पिल होने से पहले आपको विशेषज्ञों से जोड़ते हैं।

अंत में, जानवर सबसे अधिक पीड़ित होते हैं जब कोई वास्तव में नहीं देख रहा होता है। ध्यान दें, छोटे बदलावों को गंभीरता से लें, और जब चीजें ठीक नहीं लगती हैं तो तेज़ी से काम करें। वह अतिरिक्त देखभाल न केवल आपके जानवरों के लिए अच्छी है, यह आपको चिंता का भार बचाता है, और कभी - कभी, यह एक जीवन बचाता है। इसका इंतज़ार न करें। अंदर आ जाओ। यही असली फर्क है।''',
      'faqs': [
        {
          'q': '1. Why is neglect considered worse for animals than a disease itself?',
          'a': 'Because most severe health issues start with small, subtle signs. When owners miss or ignore these early warnings, a manageable condition escalates into a painful, full-blown emergency.',
          'q_hi': '1. जानवरों के लिए उपेक्षा को बीमारी से भी बदतर क्यों माना जाता है?',
          'a_hi': 'क्योंकि अधिकांश गंभीर स्वास्थ्य समस्याएं छोटे, सूक्ष्म संकेतों से शुरू होती हैं। जब मालिक इन शुरुआती चेतावनियों को मिस या अनदेखा करते हैं, तो एक प्रबंधनीय स्थिति एक दर्दनाक, पूर्ण विकसित आपात स्थिति में बदल जाती है।'
        },
        {
          'q': '2. What are the earliest signs that an animal might be unwell?',
          'a': 'Subtle behavioral changes—such as a pet being unusually quiet, a cow leaving food in the trough, or a goat lagging behind the herd—are typical early indicators.',
          'q_hi': '2. शुरुआती संकेत क्या हैं कि एक जानवर अस्वस्थ हो सकता है?',
          'a_hi': 'सूक्ष्म व्यवहार परिवर्तन - जैसे कि एक पालतू जानवर असामान्य रूप से शांत होना, एक गाय को गर्त में भोजन छोड़ना, या झुंड के पीछे एक बकरी - विशिष्ट प्रारंभिक संकेतक हैं।'
        },
        {
          'q': '3. What should I do if my animal stops eating?',
          'a': 'Never ignore a drop in appetite or try to force-feed. A loss of appetite is a major warning sign that requires immediate attention to figure out the underlying cause.',
          'q_hi': '3. अगर मेरा जानवर खाना बंद कर देता है तो मुझे क्या करना चाहिए?',
          'a_hi': 'भूख की एक बूंद को कभी अनदेखा न करें या जबरन फ़ीड करने की कोशिश न करें। भूख न लगना एक प्रमुख चेतावनी संकेत है जिसके लिए अंतर्निहित कारण का पता लगाने के लिए तत्काल ध्यान देने की आवश्यकता होती है।'
        },
        {
          'q': '4. How can tools like GOPU AI help during an animal health issue?',
          'a': 'Smart tools and chatbots provide quick, temporary guidance to help you manage the situation until professional help or a vet arrives.',
          'q_hi': '4. पशु स्वास्थ्य समस्या के दौरान GOPU AI जैसे उपकरण कैसे मदद कर सकते हैं?',
          'a_hi': 'स्मार्ट टूल और चैटबॉट आपको पेशेवर मदद या पशु चिकित्सक के आने तक स्थिति को प्रबंधित करने में मदद करने के लिए त्वरित, अस्थायी मार्गदर्शन प्रदान करते हैं।'
        },
        {
          'q': '5. When is the right time to contact a veterinarian?',
          'a': 'As soon as you notice something feels wrong or off. Reaching out early—whether in person or via platforms like PashuVaani—prevents minor issues from spiraling out of control.',
          'q_hi': '5. पशु चिकित्सक से संपर्क करने का सही समय कब है?',
          'a_hi': 'जैसे ही आपको कुछ गलत या बंद महसूस होता है। जल्दी पहुंचना - चाहे व्यक्तिगत रूप से या पशुवाणी जैसे प्लेटफार्मों के माध्यम से - नियंत्रण से बाहर होने से छोटी समस्याओं को रोकता है।'
        }
      ]
    },
    {
      'id': 'pashuvaani-ai-animal-health',
      'title': 'How PashuVaani is Bringing AI to Animal Health in India: From Smart Pets to Smart Dairy Farms',
      'title_hi': 'कैसे पशुवाणी भारत में पशु स्वास्थ्य में AI ला रहा है: स्मार्ट पेट से स्मार्ट डेयरी फार्म तक',
      'tag': 'ANIMAL HEALTH',
      'readTime': '6 min read',
      'author': 'PashuVaani AI Team',
      'image': 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee',
      'description': 'Discover how PashuVaani is using AI-powered early guidance to transform animal health in India: from smart pet care to intelligent dairy farming.',
      'description_hi': 'जानिए कैसे पशुवाणी AI की मदद से भारत में पशु स्वास्थ्य को बेहतर बनाने की दिशा में काम कर रहा है।',
      'content': '''India is home to one of the world’s largest livestock populations and a rapidly growing pet ecosystem. Yet millions of animal owners still face delayed disease detection, limited veterinary access in rural areas, lack of structured health monitoring, and income loss due to preventable illnesses.

For dairy farmers, even a small drop in milk production directly affects daily earnings.

What is AI in Animal Health?
Artificial Intelligence (AI) in animal health refers to smart systems that analyse reported symptoms, detect abnormal patterns, track productivity changes, provide early risk awareness, and encourage timely veterinary consultation. AI does not replace veterinarians. It supports better decision-making.

AI in Smart Pet Healthcare
Urban India is witnessing rapid growth in digital pet care. Gopu AI provides:
- Symptom-based early guidance
- Behaviour awareness prompts
- Preventive health education
- Simple understandable insights

AI in Dairy & Livestock Health: The PashuVaani Vision
India’s dairy ecosystem represents one of the largest economic opportunities for digital transformation. PashuVaani AI helps farmers spot early signs of infection, heat stress, or nutritional deficiency before yields drop.

Conclusion: Building the Future of Animal Health in India
Artificial Intelligence is reshaping industries across the world. PashuVaani is committed to building a responsible, scalable and farmer-centric AI guidance platform.''',
      'content_hi': '''भारत दुनिया की सबसे बड़ी पशुधन आबादी वाले देशों में से एक है और यहाँ पालतू पशुओं का तेजी से बढ़ता इकोसिस्टम भी है। फिर भी लाखों पशु मालिकों को देर से बीमारी का पता लगना, ग्रामीण क्षेत्रों में पशु चिकित्सकों की कमी, संरचित स्वास्थ्य निगरानी की कमी और रोकी जा सकने वाली बीमारियों के कारण आय में नुकसान जैसी समस्याओं का सामना करना पड़ता है।

डेयरी किसानों के लिए दूध उत्पादन में थोड़ी सी गिरावट भी उनकी दैनिक आय को सीधे प्रभावित करती है।

पशु स्वास्थ्य में AI क्या है?
आर्टिफिशियल इंटेलिजेंस (AI) पशु स्वास्थ्य में ऐसे स्मार्ट सिस्टम को दर्शाता है जो लक्षणों का विश्लेषण करता है, असामान्य पैटर्न पहचानता है, उत्पादन में बदलाव को ट्रैक करता है और शुरुआती जोखिम की चेतावनी देता है। AI पशु चिकित्सकों की जगह नहीं लेता बल्कि बेहतर निर्णय लेने में मदद करता है।

स्मार्ट पेट हेल्थकेयर में AI
शहरी भारत में डिजिटल पेट केयर तेजी से बढ़ रहा है।
- लक्षण आधारित शुरुआती मार्गदर्शन
- व्यवहार जागरूकता संकेत
- रोकथाम आधारित स्वास्थ्य शिक्षा
- सरल और समझने योग्य जानकारी

डेयरी और पशुधन स्वास्थ्य में AI: पशुवाणी का विज़न
भारत का डेयरी इकोसिस्टम डिजिटल परिवर्तन के लिए सबसे बड़े आर्थिक अवसरों में से एक है।

निष्कर्ष: भारत में पशु स्वास्थ्य का भविष्य
आर्टिफिशियल इंटेलिजेंस दुनिया भर के उद्योगों को बदल रहा है। पशुवाणी एक जिम्मेदार, स्केलेबल और किसान-केंद्रित AI प्लेटफॉर्म बनाने के लिए प्रतिबद्ध है।''',
      'faqs': [
        {
          'q': 'What is PashuVaani?',
          'a': 'PashuVaani is an AI-powered animal health guidance platform designed to provide early awareness and structured support for pet owners and dairy farmers in India.',
          'q_hi': 'पशुवाणी क्या है?',
          'a_hi': 'पशुवाणी एक AI आधारित पशु स्वास्थ्य मार्गदर्शन प्लेटफॉर्म है जो भारत में पेट ओनर्स और डेयरी किसानों को शुरुआती जागरूकता और संरचित सहायता प्रदान करने के लिए बनाया गया है।'
        },
        {
          'q': 'Does PashuVaani diagnose diseases?',
          'a': 'No. PashuVaani provides early guidance and risk awareness but does not replace veterinary diagnosis or treatment.',
          'q_hi': 'क्या पशुवाणी बीमारियों का निदान करता है?',
          'a_hi': 'नहीं। पशुवाणी केवल शुरुआती मार्गदर्शन और जोखिम जागरूकता देता है और पशु चिकित्सक के निदान या उपचार की जगह नहीं लेता।'
        },
        {
          'q': 'How does AI help dairy farmers?',
          'a': 'AI analyses reported symptoms and productivity patterns to provide early alerts and encourage timely veterinary consultation.',
          'q_hi': 'AI डेयरी किसानों की कैसे मदद करता है?',
          'a_hi': 'AI लक्षणों और उत्पादन पैटर्न का विश्लेषण करके शुरुआती चेतावनी देता है और समय पर पशु चिकित्सक से संपर्क करने के लिए प्रेरित करता है।'
        },
        {
          'q': 'Is PashuVaani suitable for small farmers?',
          'a': 'Yes. The platform is designed to be mobile-first, simple, and accessible for small and medium-scale farmers.',
          'q_hi': 'क्या पशुवाणी छोटे किसानों के लिए उपयुक्त है?',
          'a_hi': 'हाँ। यह प्लेटफॉर्म मोबाइल-फर्स्ट, सरल और छोटे व मध्यम किसानों के लिए आसानी से उपयोग करने योग्य बनाया गया है।'
        }
      ]
    }
  ];

  late Future<List<Map<String, dynamic>>> _blogsFuture;

  @override
  void initState() {
    super.initState();
    _blogsFuture = _fetchBlogs();
  }

  Future<List<Map<String, dynamic>>> _fetchBlogs() async {
    List<Map<String, dynamic>> combined = List.from(_liveBlogs);

    try {
      final response = await ApiClient().get('/blogs');
      if (response.isSuccess && response.data != null) {
        final dynamic rawData = response.data!['data'] ?? response.data;
        if (rawData is List && rawData.isNotEmpty) {
          for (var b in rawData) {
            String bId = (b['id'] ?? b['slug'] ?? '').toString();
            String bTitle = (b['title'] ?? '').toString();
            String imgUrl = b['cover_image_url'] ?? b['image'] ?? 'https://images.unsplash.com/photo-1576201836106-db1758fd1c97';
            if (imgUrl.startsWith('/')) {
              imgUrl = 'https://pashuvaani.com$imgUrl';
            }

            // Find matching item in combined list or update details
            int existingIndex = combined.indexWhere(
                (item) => item['id'] == bId || item['title'].toString().toLowerCase() == bTitle.toLowerCase());

            Map<String, dynamic> blogItem = {
              'id': bId.isNotEmpty ? bId : 'blog-$bTitle',
              'title': bTitle.isNotEmpty ? bTitle : 'Blog Article',
              'title_hi': b['title_hi'] ?? '',
              'tag': (b['tag'] ?? 'ANIMAL HEALTH').toString().toUpperCase(),
              'readTime': b['readTime'] ?? b['duration'] ?? '5 min read',
              'author': b['author'] ?? 'Dr. Ananya Jaitly',
              'image': imgUrl,
              'description': b['description'] ?? '',
              'description_hi': b['description_hi'] ?? '',
              'content': (b['content'] ?? '').toString().isNotEmpty ? b['content'] : '',
              'content_hi': b['content_hi'] ?? '',
              'faqs': b['faqs'] ?? [],
            };

            if (existingIndex != -1) {
              // Merge AWS live content into existing card while preserving fallback details
              combined[existingIndex]['image'] = imgUrl;
              if (blogItem['content'].isNotEmpty) {
                combined[existingIndex]['content'] = blogItem['content'];
              }
              if (blogItem['content_hi'].isNotEmpty) {
                combined[existingIndex]['content_hi'] = blogItem['content_hi'];
              }
              if (b['faqs'] != null && (b['faqs'] as List).isNotEmpty) {
                combined[existingIndex]['faqs'] = b['faqs'];
              }
            } else {
              combined.add(blogItem);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Live blogs API endpoint error: $e');
    }

    return combined;
  }

  void _openBlogDetail(Map<String, dynamic> blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlogDetailScreen(blog: blog),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs & Articles', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing PashuVaani Blogs...')),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _blogsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryDeepGreen));
          }

          final allBlogs = snapshot.data ?? _liveBlogs;

          final filteredBlogs = allBlogs.where((blog) {
            final matchesCategory = _selectedCategory == 'All' ||
                (blog['tag'] ?? '').toString().toLowerCase().contains(_selectedCategory.toLowerCase());
            final matchesSearch = _searchQuery.isEmpty ||
                (blog['title'] ?? '').toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
                (blog['description'] ?? '').toString().toLowerCase().contains(_searchQuery.toLowerCase());
            return matchesCategory && matchesSearch;
          }).toList();

          return Column(
            children: [
              // Header Banner matching PashuVaani web
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.lightMintBg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PashuVaani Insights',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDeepGreen.withValues(alpha: 0.8),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Blogs & Animal Care Articles',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryDeepGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Learn about pet wellness, dairy herd health, and AI guidance.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 12),
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search blogs or topics...',
                        prefixIcon: const Icon(Icons.search, color: AppColors.primaryDeepGreen),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Filter Chips
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    'All',
                    'Animal Health',
                    'Smart Pets',
                    'Dairy & Livestock'
                  ].map((cat) {
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

              // Blog Feed List
              Expanded(
                child: filteredBlogs.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.article_outlined, size: 60, color: Colors.grey[400]),
                            const SizedBox(height: 12),
                            Text(
                              'No blogs found for "$_searchQuery"',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredBlogs.length,
                        itemBuilder: (context, index) {
                          final blog = filteredBlogs[index];
                          return _buildBlogCard(context, blog);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBlogCard(BuildContext context, Map<String, dynamic> blog) {
    final String imgUrl = blog['image'] ?? 'https://images.unsplash.com/photo-1576201836106-db1758fd1c97';
    final bool isNetwork = imgUrl.startsWith('http');
    final String tag = (blog['tag'] ?? 'ANIMAL HEALTH').toString().toUpperCase();
    final String readTime = blog['readTime'] ?? '5 min read';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openBlogDetail(blog),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Category Tag Badge
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: AppColors.lightMintBg,
                  child: isNetwork
                      ? Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            'assets/images/products/product_01.jpeg',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          imgUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.article, size: 50),
                        ),
                ),
                // Category Pill Badge matching pashuvaani.com
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B4D3E), // Dark green badge
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Card Body Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Read time indicator
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        readTime,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      if ((blog['author'] ?? '').toString().isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            blog['author'],
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    blog['title'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Description preview
                  if ((blog['description'] ?? '').isNotEmpty)
                    Text(
                      blog['description'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 16),

                  // Read More Action Link matching pashuvaani.com
                  Row(
                    children: [
                      const Text(
                        'Read More',
                        style: TextStyle(
                          color: AppColors.primaryDeepGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppColors.primaryDeepGreen,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogDetailScreen extends StatefulWidget {
  final Map<String, dynamic> blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  bool _isHindi = false;
  late Map<String, dynamic> _currentBlog;

  @override
  void initState() {
    super.initState();
    _currentBlog = Map<String, dynamic>.from(widget.blog);
    _fetchLiveDetail();
  }

  Future<void> _fetchLiveDetail() async {
    final String blogId = _currentBlog['id'] ?? '';
    // Skip backend fetch for static website blogs or non-UUID slugs to avoid 404s
    final bool isUuid = RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$').hasMatch(blogId);
    if (blogId.isEmpty || !isUuid) return;
    try {
      final response = await ApiClient().get('/blogs/$blogId');
      if (response.isSuccess && response.data != null) {
        final dynamic b = response.data!['data'] ?? response.data;
        if (b is Map) {
          setState(() {
            if ((b['content'] ?? '').toString().isNotEmpty) {
              _currentBlog['content'] = b['content'];
            }
            if ((b['content_hi'] ?? '').toString().isNotEmpty) {
              _currentBlog['content_hi'] = b['content_hi'];
            }
            if ((b['title_hi'] ?? '').toString().isNotEmpty) {
              _currentBlog['title_hi'] = b['title_hi'];
            }
            if (b['faqs'] != null && (b['faqs'] as List).isNotEmpty) {
              _currentBlog['faqs'] = b['faqs'];
            }
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching live blog detail for $blogId: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final blog = _currentBlog;
    final String imgUrl = blog['image'] ?? 'https://images.unsplash.com/photo-1576201836106-db1758fd1c97';
    final bool isNetwork = imgUrl.startsWith('http');
    final String titleEn = blog['title'] ?? 'Blog Article';
    final String titleHi = (blog['title_hi'] ?? '').toString().isNotEmpty ? blog['title_hi'] : titleEn;
    final String currentTitle = _isHindi ? titleHi : titleEn;

    final String author = blog['author'] ?? 'Dr. Ananya Jaitly';
    final String readTime = blog['readTime'] ?? '5 min read';
    final String tag = (blog['tag'] ?? 'ANIMAL HEALTH').toString().toUpperCase();

    final String contentEn = blog['content'] ?? blog['description'] ?? '';
    final String contentHi = (blog['content_hi'] ?? '').toString().isNotEmpty ? blog['content_hi'] : contentEn;
    final String currentContent = _isHindi ? contentHi : contentEn;

    final List<dynamic> faqs = blog['faqs'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Detail'),
        actions: [
          // Language Switcher Toggle matching pashuvaani.com (EN / HI)
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
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Article saved to bookmarks!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image Banner with Badge
            Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  color: AppColors.lightMintBg,
                  child: isNetwork
                      ? Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            'assets/images/products/product_01.jpeg',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.article, size: 60),
                          ),
                        )
                      : Image.asset(imgUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.article, size: 60)),
                ),
                Positioned(
                  bottom: 12,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B4D3E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta Row
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: AppColors.primaryDeepGreen),
                      const SizedBox(width: 6),
                      Text(author, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      const Spacer(),
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(readTime, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Main Article Title
                  Text(
                    currentTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 1.35,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Full Multi-paragraph Body Content matching pashuvaani.com/blogs/a118575a...
                  ...currentContent.split('\n\n').map<Widget>((paragraph) {
                    final pText = paragraph.trim();
                    if (pText.isEmpty) return const SizedBox.shrink();

                    // Check if it's a section header or bullet point
                    final isHeader = pText.startsWith('1.') || pText.startsWith('2.') || pText.startsWith('3.') || pText.startsWith('4.') || pText.contains('What is AI') || pText.contains('Conclusion:');

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        pText,
                        style: TextStyle(
                          fontSize: isHeader ? 15 : 14,
                          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                          height: 1.6,
                          color: isHeader
                              ? AppColors.primaryDeepGreen
                              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.85),
                        ),
                      ),
                    );
                  }),

                  // FAQ Section matching live website
                  if (faqs.isNotEmpty) ...[
                    const Divider(height: 32),
                    const Text(
                      'Frequently Asked Questions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen),
                    ),
                    const SizedBox(height: 12),
                    ...faqs.map<Widget>((faq) {
                      String q = _isHindi ? (faq['q_hi'] ?? faq['question'] ?? '') : (faq['question'] ?? faq['q'] ?? '');
                      String a = _isHindi ? (faq['a_hi'] ?? faq['answer'] ?? '') : (faq['answer'] ?? faq['a'] ?? '');

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                        color: Theme.of(context).cardTheme.color,
                        child: ExpansionTile(
                          iconColor: AppColors.primaryDeepGreen,
                          title: Text(
                            q,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Text(
                                a,
                                style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],

                  const SizedBox(height: 24),

                  // Author Signoff Card matching web
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColors.softMint,
                          child: Icon(Icons.verified, color: AppColors.primaryDeepGreen),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Written By, $author', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 2),
                              Text('Reviewed by certified veterinary practitioners for animal health accuracy.', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
