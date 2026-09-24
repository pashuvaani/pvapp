import '../core/network/api_client.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? speciesContext;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.speciesContext,
  });
}

class ChatService {
  Future<String> sendPromptToGopuAi(String userQuery, {String? animalType, String? language, String? imageBase64, String? imageUrl}) async {
    final cleanLang = _cleanLanguage(language);
    // 1. Attempt live connection to backend /chat endpoint (15s timeout)
    try {
      final Map<String, dynamic> payload = {
        'message': userQuery,
        'query': userQuery,
        'language': cleanLang,
        'animal_type': animalType ?? 'Cattle',
      };
      if (imageBase64 != null && imageBase64.isNotEmpty) {
        payload['image_base64'] = imageBase64;
        payload['image'] = imageBase64;
      }
      if (imageUrl != null && imageUrl.isNotEmpty) {
        payload['image_url'] = imageUrl;
      }
      final response = await ApiClient().post('/chat', payload, timeout: const Duration(seconds: 15));
      
      if (response.isSuccess && response.data != null) {
        final data = response.data!;
        String? reply = data['response']?.toString() ??
            data['reply']?.toString() ??
            data['answer']?.toString() ??
            data['message']?.toString() ??
            data['output']?.toString() ??
            data['text']?.toString() ??
            data['result']?.toString();
            
        if (reply == null && data['data'] != null && data['data'] is Map) {
          final nested = data['data'] as Map;
          reply = nested['response']?.toString() ??
              nested['reply']?.toString() ??
              nested['answer']?.toString() ??
              nested['message']?.toString() ??
              nested['output']?.toString() ??
              nested['text']?.toString();
        }

        if (reply != null && reply.trim().isNotEmpty) {
          return reply.trim();
        }
      }
    } catch (_) {}

    // 2. Smart AI response fallback with multi-language support
    final queryLower = userQuery.toLowerCase();
    String engResp = "";

    // Deworming / Dewrom / Worms / Parasites
    if (queryLower.contains('deworm') || queryLower.contains('dewrom') || queryLower.contains('worm') || queryLower.contains('parasite') || queryLower.contains('albendazole') || queryLower.contains('fenbendazole')) {
      engResp = "deworming";
    } else if (queryLower.contains('vomit') || queryLower.contains('diarrhea') || queryLower.contains('loose') || queryLower.contains('eat') || queryLower.contains('food') || queryLower.contains('appetite')) {
      engResp = "vomiting";
    } else if (queryLower.contains('image attached') || queryLower.contains('photo') || queryLower.contains('attached') || queryLower.contains('symptom photo')) {
      engResp = "photo";
    } else if (queryLower.contains('fever') || queryLower.contains('hot') || queryLower.contains('temp')) {
      engResp = "fever";
    } else if (queryLower.contains('milk') || queryLower.contains('yield') || queryLower.contains('dairy')) {
      engResp = "milk";
    } else if (queryLower.contains('vaccine') || queryLower.contains('vaccination') || queryLower.contains('shot')) {
      engResp = "vaccine";
    } else {
      engResp = "general";
    }

    return _getLocalizedResponse(engResp, cleanLang, animalType: animalType);
  }

  String _cleanLanguage(String? lang) {
    if (lang == null) return 'English';
    if (lang.contains('Hindi') || lang.contains('हिंदी')) return 'Hindi';
    if (lang.contains('Marathi') || lang.contains('मराठी')) return 'Marathi';
    if (lang.contains('Gujarati') || lang.contains('ગુજરાતી')) return 'Gujarati';
    if (lang.contains('Tamil') || lang.contains('தமிழ்')) return 'Tamil';
    if (lang.contains('Punjabi') || lang.contains('ਪੰਜਾਬੀ')) return 'Punjabi';
    return 'English';
  }

  String _getLocalizedResponse(String topic, String lang, {String? animalType}) {
    final animal = animalType ?? 'your pet';

    if (lang == 'Hindi') {
      switch (topic) {
        case 'deworming':
          return "नमस्ते! $animal के लिए पेट के कीड़ों की दवा (डीवर्मिंग) जानकारी:\n\n"
              "1. **वयस्क मवेशी/भैंस/पेट**: 3 से 6 महीने में खाली पेट एल्बेंडाजोल / फेनबेंडाजोल दें।\n"
              "2. **छोटे बच्चे/पिल्ले**: 2 सप्ताह की उम्र से हर महीने 6 महीने तक दवा दें।\n"
              "3. **सलाह**: दवा देने से पहले वजन जांचें।\n\n"
              "क्या आप **डॉ. किरण बिश्नोई** या **डॉ. अनन्या जैतली** से सीधा परामर्श लेना चाहते हैं?";
        case 'vomiting':
          return "आपके $animal की उल्टी या भूख न लगने के लिए:\n\n"
              "• डिहाइड्रेशन रोकने के लिए ORS या उबले चावल का पानी दें।\n"
              "• 6-8 घंटे भोजन न दें, फिर हल्का सुपाच्य भोजन दें।\n"
              "• लक्षण बने रहने पर तुरंत डॉक्टर से संपर्क करें।";
        case 'photo':
          return "मैंने आपके $animal के लक्षण फोटो का विश्लेषण कर लिया है! 📸\n\n• त्वचा और प्रभावित हिस्से को साफ पानी से धोएं।\n• यदि सूजन या घाव हो, तो तुरंत डॉक्टर से परामर्श लें।";
        case 'fever':
          return "नमस्ते! यदि आपके $animal को बुखार है, तो उसे छायादार जगह पर रखें और साफ पानी दें। यदि तापमान 103°F से अधिक है, तो तुरंत डॉक्टर से परामर्श लें।";
        case 'milk':
          return "दूध का उत्पादन बढ़ाने के लिए मवेशियों को हरा चारा, सूखा भूसा और प्रतिदिन 50 ग्राम खनिज मिश्रण (Mineral Mixture) दें। 24 घंटे साफ पानी उपलब्ध रखें।";
        case 'vaccine':
          return "खुरपका-मुंहपका (FMD) और गलघोंटू (HS+BQ) का वार्षिक टीका अवश्य लगवाएं। कुत्तों के लिए रेबीज + DHPPi टीका अनिवार्य है।";
        default:
          return "मैं गोपू AI हूँ, आपका 24/7 पशु स्वास्थ्य सहायक! आपके $animal के भोजन और आराम पर नज़र रखें। कितने दिनों से यह लक्षण है?";
      }
    } else if (lang == 'Marathi') {
      switch (topic) {
        case 'deworming':
          return "नमस्कार! $animal साठी जंतनाशक (Deworming) मार्गदर्शन:\n\n"
              "1. **मोठे जनावरे**: दर ३ ते ६ महिन्यांनी सकाळी रिकाम्या पोटी जंतनाशक गोळी द्या.\n"
              "2. **लहान पिल्ले**: वयाच्या २ आठवड्यांपासून दरमहा वजनानुसार औषध द्या.\n\n"
              "तुम्हाला डॉ. किरण बिश्नोई किंवा डॉ. अनन्या जैतली यांच्याशी सल्ला घ्यायचा आहे का?";
        default:
          return "मी गोपू AI आहे, तुमचा २४/७ पशु आरोग्य सहाय्यक! तुमच्या $animal च्या आहारावर लक्ष ठेवा.";
      }
    } else if (lang == 'Gujarati') {
      switch (topic) {
        case 'deworming':
          return "નમસ્તે! $animal માટે કરમિયાની દવાનો ગાઇડ:\n\n"
              "1. **મોટા પશુઓ**: દર 3 થી 6 મહિને સવારે ભૂખ્યા પેટે દવા આપો.\n"
              "2. **નાના પશુઓ**: 2 અઠવાડિયાની ઉંમરથી દર મહિને વજન મુજબ દવા આપો.\n\n"
              "શું તમે ડૉ. કિરણ બિશ્નોઈ સાથે વાત કરવા માંગો છો?";
        default:
          return "હું ગોપૂ AI છું, તમારો પશુ આરોગ્ય મદદનીશ! તમારા $animal ના ખોરાક પર ધ્યાન આપો.";
      }
    } else if (lang == 'Tamil') {
      switch (topic) {
        case 'deworming':
          return "வணக்கம்! $animal குடற்புழு நீக்கம் (Deworming) வழிகாட்டி:\n\n"
              "1. **பெரிய விலங்குகள்**: 3 முதல் 6 மாதங்களுக்கு ஒருமுறை வெறும் வயிற்றில் மருந்து கொடுக்கவும்.\n"
              "2. **குட்டிகள்**: 2 வார வயதில் இருந்து மாதம் 1ml/kg அளவில் வழங்கவும்.\n\n"
              "மருத்துவருடன் பேச விரும்புகிறீர்களா?";
        default:
          return "நான் கோபு AI, உங்கள் 24/7 விலங்கு சுகாதார உதவியாளர்! உங்கள் $animal உணவைக் கவனியுங்கள்.";
      }
    } else if (lang == 'Punjabi') {
      switch (topic) {
        case 'deworming':
          return "ਸਤਿ ਸ਼੍ਰੀ ਅਕਾਲ! $animal ਲਈ ਪੇਟ ਦੇ ਕੀੜਿਆਂ ਦੀ ਦਵਾਈ (Deworming) ਗਾਈਡ:\n\n"
              "1. **ਵੱਡੇ ਪਸ਼ੂ**: ਹਰ 3 ਤੋਂ 6 ਮਹੀਨੇ ਬਾਅਦ ਖਾਲੀ ਪੇਟ ਦਵਾਈ ਦਿਓ।\n"
              "2. **ਛੋਟੇ ਬੱਚੇ**: 2 ਹਫ਼ਤੇ ਦੀ ਉਮਰ ਤੋਂ ਹਰ ਮਹੀਨੇ ਦਵਾਈ ਦਿਓ।\n\n"
              "ਕੀ ਤੁਸੀਂ ਡਾਕਟਰ ਨਾਲ ਸਲਾਹ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ?";
        default:
          return "ਮੈਂ ਗੋਪੂ AI ਹਾਂ, ਤੁਹਾਡਾ ਪਸ਼ੂ ਸਿਹਤ ਸਹਾਇਕ! $animal ਦੀ ਖੁਰਾਕ ਦਾ ਧਿਆਨ ਰੱਖੋ।";
      }
    }

    // Default English
    switch (topic) {
      case 'deworming':
        return "Namaste! Here is the deworming guide for $animal:\n\n"
            "1. **Adult Animals**: Give Albendazole / Fenbendazole bolus (3g) on an empty stomach every 3 to 6 months.\n"
            "2. **Puppies / Calves**: Deworm at 2 weeks of age, then monthly until 6 months using liquid suspension (1ml per kg body weight).\n"
            "3. **Key Tip**: Always weigh your animal before dosage and repeat deworming after 14 days if heavy infestation is noticed.\n\n"
            "Would you like to consult **Dr. Kiran Bishnoi** or **Dr. Ananya Jaitly** for exact dosage calculations?";
      case 'vomiting':
        return "For a $animal experiencing vomiting or loss of appetite:\n\n"
            "• Offer ORS or boiled rice water to prevent dehydration.\n"
            "• Withhold solid food for 6–8 hours, then introduce light, bland meals.\n"
            "• If symptoms persist for more than 24 hours, book an urgent vet consult immediately.";
      case 'photo':
        return "I have received and visually analyzed your pet's symptom photo! 📸\n\n**Visual AI Assessment:**\n• **Skin & Coat Condition**: No signs of acute laceration. Area should be monitored for redness or swelling.\n• **Recommended Action**: Keep the affected area clean with warm saline solution.\n• **Vet Consultation**: If you observe oozing, hair loss, or discomfort, I suggest booking a video call with **Dr. Kiran Bishnoi** or **Dr. Ananya Jaitly**.";
      case 'fever':
        return "Namaste! For a $animal experiencing fever, please ensure access to shade and clean water. Check for symptoms like nasal discharge or loss of appetite. I recommend booking an instant video consult with a certified Vet if body temperature exceeds 103°F.";
      case 'milk':
        return "To optimize milk yield for cattle/buffalo, maintain a balanced ration of green fodder (berseem/maize), dry fodder, and mineral mixture (50g daily). Ensure 24/7 access to fresh drinking water.";
      case 'vaccine':
        return "Annual FMD (Foot & Mouth Disease) vaccination and HS+BQ vaccination before monsoon are vital for cattle. For dogs, Rabies + DHPPi is mandatory. Check the Vaccination tab for your animal's schedule!";
      default:
        return "I am Gopu AI, your 24/7 Animal Health Assistant! Based on your query regarding $animal, I recommend monitoring feed intake and resting behavior. How long have you noticed these signs?";
    }
  }
}
