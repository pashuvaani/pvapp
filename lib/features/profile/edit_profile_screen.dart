import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/user_store.dart';

import '../../core/utils/platform_web_helper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _ownerNameController;
  late final TextEditingController _petNameController;
  late final TextEditingController _petBreedController;
  late final TextEditingController _phoneController;
  String? _selectedPhotoUrl;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final user = UserStore.currentUser;
    // Don't pre-fill numeric usernames or default 'Animal Owner' into editable field
    final initialOwnerName = (user.ownerName == 'Animal Owner' || RegExp(r'^\d+$').hasMatch(user.ownerName.trim()))
        ? ''
        : user.ownerName;

    _ownerNameController = TextEditingController(text: initialOwnerName);
    _petNameController = TextEditingController(text: user.petName);
    _petBreedController = TextEditingController(text: user.petBreed);
    _phoneController = TextEditingController(text: user.phone);
    _selectedPhotoUrl = user.photoUrl;
  }

  @override
  void dispose() {
    _ownerNameController.dispose();
    _petNameController.dispose();
    _petBreedController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _pickProfilePhoto() {
    WebPlatformHelper.pickWebFile((bytes, filename) async {
      if (mounted) {
        setState(() => _isUploading = true);
        final uploadRes = await ApiClient().uploadMultipartBytes('/uploads/user-photo', bytes, filename);

        if (mounted) {
          setState(() => _isUploading = false);
          if (uploadRes.isSuccess && uploadRes.data != null) {
            final rawUrl = uploadRes.data!['url']?.toString() ?? '';
            final String fullPhotoUrl;
            if (rawUrl.startsWith('http') || rawUrl.startsWith('assets/')) {
              fullPhotoUrl = rawUrl;
            } else {
              final formattedPath = rawUrl.startsWith('/') ? rawUrl : '/$rawUrl';
              fullPhotoUrl = '${ApiClient.baseUrl.replaceAll('/api', '')}$formattedPath';
            }
            setState(() {
              _selectedPhotoUrl = fullPhotoUrl;
            });
            UserStore.updateProfile(photoUrl: fullPhotoUrl);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ Profile photo uploaded successfully!'),
                backgroundColor: AppColors.primaryDeepGreen,
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            // Base64 fallback if offline or backend error
            final String ext = filename.toLowerCase();
            final String mimeType = ext.endsWith('.png')
                ? 'image/png'
                : ext.endsWith('.webp')
                    ? 'image/webp'
                    : 'image/jpeg';
            final base64Str = 'data:$mimeType;base64,${base64Encode(bytes)}';
            setState(() {
              _selectedPhotoUrl = base64Str;
            });
            UserStore.updateProfile(photoUrl: base64Str);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ Profile photo updated!'),
                backgroundColor: AppColors.primaryDeepGreen,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ImageProvider avatarImage = buildAvatarImageProvider(
      _selectedPhotoUrl,
      defaultAsset: 'assets/images/logo/ic_adaptive_padded.png',
    )!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo section
            Center(
              child: GestureDetector(
                onTap: _pickProfilePhoto,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 54,
                      backgroundColor: AppColors.softMint,
                      backgroundImage: _selectedPhotoUrl != null ? avatarImage : null,
                      child: _isUploading
                          ? const CircularProgressIndicator(color: AppColors.primaryDeepGreen)
                          : (_selectedPhotoUrl == null
                              ? const Icon(Icons.pets, size: 50, color: AppColors.primaryDeepGreen)
                              : null),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryDeepGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: _isUploading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildLabel('Owner Name *'),
            _buildTextField(
              hint: 'Enter your full name (Letters only)', 
              controller: _ownerNameController,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
            ),
            const SizedBox(height: 20),

            _buildLabel('Pet Name'),
            _buildTextField(
              hint: 'Enter Pet Name (Letters only)', 
              controller: _petNameController,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
            ),
            const SizedBox(height: 20),

            _buildLabel('Pet Breed / Type'),
            _buildTextField(
              hint: 'e.g. Golden Retriever, Labrador, Gir Cow', 
              controller: _petBreedController,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
            ),
            const SizedBox(height: 20),

            _buildLabel('Contact Number'),
            _buildTextField(
              hint: '10-digit Mobile Number', 
              controller: _phoneController, 
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
            ),
            const SizedBox(height: 40),

            // Save Changes Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () async {
                  final String ownerNameVal = _ownerNameController.text.trim();
                  final String petNameVal = _petNameController.text.trim();
                  final String petBreedVal = _petBreedController.text.trim();
                  final String phoneVal = _phoneController.text.trim();

                  if (ownerNameVal.isNotEmpty && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(ownerNameVal)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('⚠️ Owner name must contain letters only'), backgroundColor: Colors.redAccent),
                    );
                    return;
                  }

                  if (petNameVal.isNotEmpty && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(petNameVal)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('⚠️ Pet name must contain letters only'), backgroundColor: Colors.redAccent),
                    );
                    return;
                  }

                  if (phoneVal.isNotEmpty && !RegExp(r'^\d{10}$').hasMatch(phoneVal)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('⚠️ Please enter a valid 10-digit phone number'), backgroundColor: Colors.redAccent),
                    );
                    return;
                  }

                  await UserStore.updateProfile(
                    ownerName: ownerNameVal.isEmpty ? 'Animal Owner' : ownerNameVal,
                    petName: petNameVal,
                    petBreed: petBreedVal,
                    phone: phoneVal,
                    photoUrl: _selectedPhotoUrl,
                  );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✅ Profile details saved successfully!'),
                        backgroundColor: AppColors.primaryDeepGreen,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDeepGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Theme.of(context).hintColor.withValues(alpha: 0.5), fontSize: 14),
        filled: true,
        fillColor: Theme.of(context).cardTheme.color,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
        ),
      ),
    );
  }
}
