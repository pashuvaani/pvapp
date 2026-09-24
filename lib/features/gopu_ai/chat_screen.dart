import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/platform_web_helper.dart';
import '../../core/utils/user_store.dart';
import 'chat_controller.dart';
import 'widgets/chat_bubble.dart';
import '../../shared/widgets/animal_pattern_background.dart';
import '../../services/theme_service.dart';

class GopuChatScreen extends StatefulWidget {
  const GopuChatScreen({super.key});

  @override
  State<GopuChatScreen> createState() => _GopuChatScreenState();
}

class _GopuChatScreenState extends State<GopuChatScreen> with SingleTickerProviderStateMixin {
  final ChatController _controller = ChatController();
  final TextEditingController _inputController = TextEditingController();
  
  late AnimationController _mascotController;
  late Animation<double> _mascotFade;
  late Animation<double> _mascotScale;
  late Animation<Offset> _mascotMove;

  final List<Map<String, String>> _quickQuestions = [
    {'icon': '🤢', 'text': 'Is your pet vomiting?'},
    {'icon': '🍽️', 'text': 'Is your pet not eating or drinking?'},
    {'icon': '📅', 'text': 'Would you like to book an appointment?'},
    {'icon': '🥗', 'text': 'What should I feed my pet daily?'},
    {'icon': '💊', 'text': 'How do I deworm my pet?'},
    {'icon': '🌡️', 'text': 'My pet has a fever — what do I do?'},
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });

    _mascotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _mascotFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _mascotController, curve: Curves.easeOut));
    _mascotScale = Tween<double>(begin: 0.96, end: 1.0).animate(CurvedAnimation(parent: _mascotController, curve: Curves.easeOutBack));
    _mascotMove = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(CurvedAnimation(parent: _mascotController, curve: Curves.easeOut));
    
    _mascotController.forward();
  }
  
  @override
  void dispose() {
    _mascotController.dispose();
    _controller.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _inputController.text.trim();
    if (text.isNotEmpty) {
      _inputController.clear();
      _controller.sendMessage(text);
    }
  }

  void _handleImageUpload() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload Pet Media or Document',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen),
              ),
              const SizedBox(height: 6),
              Text(
                'Attach a photo of symptoms, prescription, or lab report for AI analysis.',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined, color: AppColors.primaryDeepGreen),
                title: const Text('Take Photo with Camera'),
                subtitle: const Text('Capture live pet symptom or report'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndSendAttachment(source: ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined, color: AppColors.primaryDeepGreen),
                title: const Text('Choose Photo from Gallery'),
                subtitle: const Text('Select pet symptom photo from device'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndSendAttachment(source: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickAndSendAttachment({ImageSource source = ImageSource.gallery}) {
    WebPlatformHelper.pickWebFile((bytes, filename) async {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Uploading $filename for Gopu AI analysis...'),
            backgroundColor: AppColors.primaryDeepGreen,
            duration: const Duration(seconds: 2),
          ),
        );
        var uploadRes = await ApiClient().uploadMultipartBytes('/uploads/symptom-photo', bytes, filename);
        if (!uploadRes.isSuccess) {
          uploadRes = await ApiClient().uploadMultipartBytes('/uploads/user-photo', bytes, filename);
        }

        String attachedMsg = '🖼️ [Image Attached: $filename]';
        String? uploadedUrl;
        if (uploadRes.isSuccess && uploadRes.data != null) {
          final rawUrl = uploadRes.data!['url']?.toString() ?? uploadRes.data!['path']?.toString() ?? '';
          if (rawUrl.isNotEmpty) {
            final formattedPath = rawUrl.startsWith('/') ? rawUrl : '/$rawUrl';
            uploadedUrl = rawUrl.startsWith('http')
                ? rawUrl
                : 'https://pashuvaani.com$formattedPath';
            attachedMsg = '🖼️ [Image Attached: $uploadedUrl]';
          }
        }
        final base64Str = base64Encode(bytes);
        if (mounted) {
          _controller.sendMessage(
            '$attachedMsg\nPlease analyze this pet health symptom photo.',
            imageBase64: base64Str,
            imageUrl: uploadedUrl,
          );
        }
      }
    }, source: source);
  }

  void _handleVoiceInput() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.primaryDeepGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mic, color: AppColors.primaryDeepGreen, size: 36),
              ),
              const SizedBox(height: 16),
              const Text(
                'Listening to your voice...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDeepGreen),
              ),
              const SizedBox(height: 6),
              Text(
                'Speak your pet\'s symptoms clearly in English or Hindi',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              const Text('Tap a spoken sample or speak:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _buildVoiceSampleChip('My pet has a high fever'),
                  _buildVoiceSampleChip('My dog is vomiting and dull'),
                  _buildVoiceSampleChip('How to improve cattle milk yield?'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                icon: const Icon(Icons.stop, color: Colors.white, size: 16),
                label: const Text('Stop Recording', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVoiceSampleChip(String text) {
    return ActionChip(
      avatar: const Icon(Icons.record_voice_over, size: 14, color: AppColors.primaryDeepGreen),
      label: Text(text, style: const TextStyle(fontSize: 11)),
      backgroundColor: AppColors.softMint,
      onPressed: () {
        Navigator.pop(context);
        _inputController.text = text;
        _send();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Soft organic background for mascot
                Positioned(
                  right: -20,
                  top: -10,
                  child: Container(
                    width: 200,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? const Color(0xFF19231F)
                          : const Color(0xFFF1F5F2),
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text & Logo Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
                                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: AppStyles.getBoxShadow(context),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset('assets/images/logo/logopsv.png', fit: BoxFit.cover),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: ValueListenableBuilder<ThemeMode>(
                                    valueListenable: ThemeService().themeMode,
                                    builder: (context, mode, _) {
                                      return Icon(
                                        mode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      );
                                    },
                                  ),
                                  onPressed: () => ThemeService().toggleTheme(),
                                ),
                                const SizedBox(width: 4),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(Icons.person_outline_rounded, color: Theme.of(context).colorScheme.onSurface),
                                  tooltip: 'Profile & Settings',
                                  onPressed: () => Navigator.pushNamed(context, AppRoutes.moreMenu),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Text(
                                  'Gopu.AI', 
                                  style: TextStyle(
                                    fontSize: 22, 
                                    fontWeight: FontWeight.w800, 
                                    color: AppColors.primaryDeepGreen,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDeepGreen.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.primaryDeepGreen.withOpacity(0.2)),
                                  ),
                                  child: const Text('6 Left', style: TextStyle(fontSize: 10, color: AppColors.primaryDeepGreen, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Pet Health Companion', 
                              style: TextStyle(
                                fontSize: 11, 
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), 
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Language Selector & SOS Button Wrap to prevent overflow
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardTheme.color,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.primaryDeepGreen.withOpacity(0.3)),
                                  ),
                                  child: ValueListenableBuilder<String>(
                                    valueListenable: UserStore.languageNotifier,
                                    builder: (context, currentLang, _) {
                                      final selectedValue = AppConstants.languages.contains(currentLang)
                                          ? currentLang
                                          : AppConstants.languages.firstWhere(
                                              (l) => l.toLowerCase().contains(currentLang.toLowerCase()),
                                              orElse: () => 'English',
                                            );
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedValue,
                                          isDense: true,
                                          icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.primaryDeepGreen),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          onChanged: (String? newLang) {
                                            if (newLang != null) {
                                              _controller.setLanguage(newLang);
                                            }
                                          },
                                          items: AppConstants.languages.map((String lang) {
                                            return DropdownMenuItem<String>(
                                              value: lang,
                                              child: Text(lang),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(context, AppRoutes.emergencyHelp),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.redAccent, width: 1),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add, size: 12, color: Colors.redAccent),
                                        SizedBox(width: 2),
                                        Text(
                                          'Emergency SOS',
                                          style: TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Animated Mascot
                      FadeTransition(
                        opacity: _mascotFade,
                        child: SlideTransition(
                          position: _mascotMove,
                          child: ScaleTransition(
                            scale: _mascotScale,
                            child: SizedBox(
                              width: 110,
                              height: 110,
                              child: Transform.scale(
                                scale: 1.3,
                                child: ShaderMask(
                                  shaderCallback: (rect) {
                                    return const RadialGradient(
                                      center: Alignment.center,
                                      radius: 0.45,
                                      colors: [Colors.black, Colors.transparent],
                                      stops: [0.6, 1.0],
                                    ).createShader(rect);
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: Image.asset(
                                    'assets/images/gopu/gopu_hi.jpeg', 
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Chat Messages
            Expanded(
              child: AnimalPatternBackground(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: _controller.messages.length + (_controller.messages.length <= 1 ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _controller.messages.length) {
                      final msg = _controller.messages[index];
                      return ChatBubble(
                        text: msg.text,
                        isUser: msg.isUser,
                        timestamp: msg.timestamp,
                        speciesContext: msg.speciesContext,
                      );
                    } else {
                      return _buildQuickQuestions();
                    }
                  },
                ),
              ),
            ),
            
            if (_controller.isTyping) ...[
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 8),
                child: Row(
                  children: [
                    const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryGreen)),
                    const SizedBox(width: 8),
                    Text('Gopu AI is thinking...', style: AppStyles.subtext),
                  ],
                ),
              ),
            ],
            
            // Input Area
            SafeArea(
              bottom: true,
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration( 
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.2)),
                        boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.02),
                             blurRadius: 4,
                             offset: const Offset(0, 2),
                           )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _inputController,
                              style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface),
                              decoration: const InputDecoration(
                                hintText: 'Ask Gopu anything...',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: false,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              ),
                              onSubmitted: (_) => _send(),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.file_upload_outlined, color: AppColors.primaryDeepGreen, size: 22),
                            tooltip: 'Upload Symptom Photo or Lab Report',
                            onPressed: _handleImageUpload,
                          ),
                          IconButton(
                            icon: const Icon(Icons.mic_none_rounded, color: AppColors.primaryDeepGreen, size: 22),
                            tooltip: 'Voice Input',
                            onPressed: _handleVoiceInput,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFF86B39E), // Soft green from the image
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                                onPressed: _send,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gopu.AI can provide health advice but always consult a vet for emergencies.',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickQuestions() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'QUICK QUESTIONS', 
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF6B9A8F).withOpacity(0.8), letterSpacing: 1.2),
          ),
          const SizedBox(height: 16),
          ..._quickQuestions.map((q) {
            return GestureDetector(
              onTap: () => _controller.sendMessage(q['text']!),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Text(q['icon']!, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(q['text']!, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface))),
                    const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF26A69A)),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
