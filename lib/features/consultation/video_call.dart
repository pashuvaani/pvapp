import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/helpers.dart';

import '../../core/utils/platform_web_helper.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isCameraOff = false;
  bool _isLiveMeetingActive = true;
  String _viewId = '';
  late String _roomName;
  late String _meetingUrl;

  @override
  void initState() {
    super.initState();
    // Unique room name per consultation session
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(7);
    _roomName = 'PashuVaaniConsultation_$timestamp';
    _meetingUrl = 'https://meet.jit.si/$_roomName#config.prejoinPageEnabled=false&config.startWithAudioMuted=false&config.disableDeepLinking=true';

    if (kIsWeb) {
      _viewId = 'jitsi-container-$timestamp';
      WebPlatformHelper.registerIframeView(_viewId, _meetingUrl);
    }
  }

  Future<void> _openExternalMeeting() async {
    final uri = Uri.parse('https://meet.jit.si/$_roomName');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        Helpers.showSnackBar(context, 'Opening meeting room...');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String docName = args?['name'] ?? args?['doctorName'] ?? 'Dr. Kiran Bishnoi';
    final String docTitle = args?['title'] ?? args?['specialty'] ?? 'Veterinary Specialist';
    final String docImg = args?['image'] ?? 'assets/images/doctors/dr_ananya_photo.png';

    ImageProvider imgProvider;
    if (docImg.startsWith('http://') || docImg.startsWith('https://')) {
      imgProvider = NetworkImage(docImg);
    } else {
      imgProvider = AssetImage(docImg);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Live WebRTC Meeting Room / Fallback Simulated Call
            if (kIsWeb && _isLiveMeetingActive)
              HtmlElementView(viewType: _viewId)
            else
              Image.asset(
                docImg,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/images/doctors/dr_ananya_photo.png',
                  fit: BoxFit.cover,
                ),
              ),

            // 2. Gradient Overlay for Controls Readability
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 220,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.9),
                      Colors.black.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // 3. Top Header Bar: Back Button, Room Badge & Launch Full Screen
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // LIVE Room Status Chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepGreen.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: Colors.greenAccent, size: 10),
                        SizedBox(width: 6),
                        Text('LIVE CONSULTATION', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.8)),
                      ],
                    ),
                  ),

                  // Open External / Fullscreen Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.open_in_new, color: Colors.white, size: 20),
                      tooltip: 'Open in Full Screen / Browser',
                      onPressed: _openExternalMeeting,
                    ),
                  ),
                ],
              ),
            ),

            // 4. Doctor Info Label
            Positioned(
              bottom: 110,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: imgProvider,
                    backgroundColor: Colors.white24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        docName,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        docTitle,
                        style: TextStyle(color: Colors.grey[300], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 5. Bottom Call Control Toolbar
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    label: _isMuted ? 'Unmute' : 'Mute',
                    onTap: () => setState(() => _isMuted = !_isMuted),
                    backgroundColor: _isMuted ? Colors.amber : Colors.white.withValues(alpha: 0.25),
                    iconColor: _isMuted ? Colors.black : Colors.white,
                  ),
                  _buildControlButton(
                    icon: _isCameraOff ? Icons.videocam_off : Icons.videocam,
                    label: _isCameraOff ? 'Cam On' : 'Cam Off',
                    onTap: () => setState(() => _isCameraOff = !_isCameraOff),
                    backgroundColor: _isCameraOff ? Colors.amber : Colors.white.withValues(alpha: 0.25),
                    iconColor: _isCameraOff ? Colors.black : Colors.white,
                  ),
                  _buildControlButton(
                    icon: Icons.open_in_browser,
                    label: 'Browser',
                    onTap: _openExternalMeeting,
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                    iconColor: Colors.white,
                  ),
                  _buildControlButton(
                    icon: Icons.call_end,
                    label: 'End Call',
                    onTap: () {
                      Helpers.showSnackBar(context, 'Consultation Ended');
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.red,
                    iconColor: Colors.white,
                    isLarge: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color iconColor,
    bool isLarge = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(isLarge ? 16 : 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: isLarge ? 26 : 22),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

