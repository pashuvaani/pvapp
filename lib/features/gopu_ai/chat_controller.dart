import 'package:flutter/material.dart';
import '../../core/utils/user_store.dart';
import '../../services/chat_service.dart';

class ChatController extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  String _selectedSpecies = 'Cattle';

  String _selectedLanguage = 'English';

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;
  String get selectedSpecies => _selectedSpecies;
  String get selectedLanguage => _selectedLanguage;

  ChatController() {
    _selectedLanguage = UserStore.language;
    _initWelcomeMessage();
    UserStore.languageNotifier.addListener(_onGlobalLanguageChanged);
  }

  @override
  void dispose() {
    UserStore.languageNotifier.removeListener(_onGlobalLanguageChanged);
    super.dispose();
  }

  void _onGlobalLanguageChanged() {
    if (_selectedLanguage != UserStore.language) {
      _selectedLanguage = UserStore.language;
      _updateWelcomeMessage(_selectedLanguage);
      notifyListeners();
    }
  }

  void setSpecies(String species) {
    _selectedSpecies = species;
    notifyListeners();
  }

  void setLanguage(String lang) {
    _selectedLanguage = lang;
    UserStore.setLanguage(lang);
    _updateWelcomeMessage(lang);
    notifyListeners();
  }

  void _updateWelcomeMessage(String lang) {
    String welcomeText = 'Namaste! I\'m Gopu AI 👋\n\nYour 24/7 AI health & feeding assistant.\n\nAsk me anything about your pet\'s symptoms, vaccination, nutrition, feeding, or general care.';
    
    if (lang.contains('Hindi') || lang.contains('हिंदी')) {
      welcomeText = 'नमस्ते! मैं गोपू AI हूँ 👋\n\nआपका 24/7 पशु स्वास्थ्य और पोषण सहायक।\n\nअपने पशु के लक्षण, टीकाकरण, पोषण या देखभाल के बारे में कुछ भी पूछें।';
    } else if (lang.contains('Marathi') || lang.contains('मराठी')) {
      welcomeText = 'नमस्कार! मी गोपू AI आहे 👋\n\nतुमचा २४/७ पशु आरोग्य आणि पोषण सहाय्यक.\n\nजनावरांचे आजार, लसीकरण किंवा आहाराबद्दल काहीही विचारा.';
    } else if (lang.contains('Gujarati') || lang.contains('ગુજરાતી')) {
      welcomeText = 'નમસ્તે! હું ગોપૂ AI છું 👋\n\nતમારો 24/7 પશુ આરોગ્ય અને પોષણ મદદનીશ.\n\nપશુના લક્ષણો, રસીકરણ અથવા સંભાળ વિશે કંઈપણ પૂછો.';
    } else if (lang.contains('Tamil') || lang.contains('தமிழ்')) {
      welcomeText = 'வணக்கம்! நான் கோபு AI 👋\n\nஉங்கள் 24/7 விலங்கு சுகாதார உதவியாளர்.\n\nவிலங்கு நோய்கள், தடுப்பூசி அல்லது பராமரிப்பு பற்றி எதையும் கேட்கலாம்.';
    } else if (lang.contains('Punjabi') || lang.contains('ਪੰਜਾਬੀ')) {
      welcomeText = 'ਸਤਿ ਸ਼੍ਰੀ ਅਕਾਲ! ਮੈਂ ਗੋਪੂ AI ਹਾਂ 👋\n\nਤੁਹਾਡਾ 24/7 ਪਸ਼ੂ ਸਿਹਤ ਅਤੇ ਖੁਰਾਕ ਸਹਾਇਕ।\n\nਪਸ਼ੂਆਂ ਦੇ ਲੱਛਣ, ਟੀਕਾਕਰਨ ਜਾਂ ਦੇਖਭਾਲ ਬਾਰੇ ਕੁਝ ਵੀ ਪੁੱਛੋ।';
    }

    if (_messages.isNotEmpty && !_messages[0].isUser) {
      _messages[0] = ChatMessage(
        id: 'msg_welcome',
        text: welcomeText,
        isUser: false,
        timestamp: DateTime.now(),
        speciesContext: _selectedSpecies,
      );
    }
  }

  void _initWelcomeMessage() {
    _messages.add(
      ChatMessage(
        id: 'msg_welcome',
        text: 'Namaste! I\'m Gopu AI 👋\n\nYour 24/7 AI health & feeding assistant.\n\nAsk me anything about your pet\'s symptoms, vaccination, nutrition, feeding, or general care.',
        isUser: false,
        timestamp: DateTime.now(),
        speciesContext: _selectedSpecies,
      ),
    );
    _updateWelcomeMessage(_selectedLanguage);
  }

  Future<void> sendMessage(String text, {String? imageBase64, String? imageUrl}) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
      speciesContext: _selectedSpecies,
    );

    _messages.add(userMsg);
    _isTyping = true;
    notifyListeners();

    try {
      final responseText = await _chatService.sendPromptToGopuAi(
        text,
        animalType: _selectedSpecies,
        language: _selectedLanguage,
        imageBase64: imageBase64,
        imageUrl: imageUrl,
      );

      final aiMsg = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        text: responseText,
        isUser: false,
        timestamp: DateTime.now(),
        speciesContext: _selectedSpecies,
      );

      _messages.add(aiMsg);
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }
}
