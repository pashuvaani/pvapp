import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

ImageProvider? buildAvatarImageProvider(String? photoUrl, {String? defaultAsset}) {
  if (photoUrl == null || photoUrl.trim().isEmpty) {
    return defaultAsset != null ? AssetImage(defaultAsset) : null;
  }
  final url = photoUrl.trim();
  if (url.startsWith('http://') || url.startsWith('https://')) {
    return NetworkImage(url);
  }
  if (url.startsWith('data:image') || url.contains('base64,')) {
    try {
      final base64Part = url.split('base64,').last.replaceAll(RegExp(r'\s+'), '');
      final bytes = base64Decode(base64Part);
      return MemoryImage(bytes);
    } catch (_) {
      return defaultAsset != null ? AssetImage(defaultAsset) : null;
    }
  }
  if (url.startsWith('assets/')) {
    return AssetImage(url);
  }
  try {
    final bytes = base64Decode(url.replaceAll(RegExp(r'\s+'), ''));
    return MemoryImage(bytes);
  } catch (_) {
    return defaultAsset != null ? AssetImage(defaultAsset) : null;
  }
}

class UserProfileData {
  String ownerName;
  String petName;
  String petBreed;
  String phone;
  String? photoUrl;

  UserProfileData({
    required this.ownerName,
    required this.petName,
    required this.petBreed,
    required this.phone,
    this.photoUrl,
  });

  String get petInfo {
    if (petName.isEmpty && petBreed.isEmpty) return 'No Pet Info Added';
    if (petBreed.isEmpty) return 'Pet: $petName';
    if (petName.isEmpty) return 'Breed: $petBreed';
    return 'Pet: $petName ($petBreed)';
  }
}

class UserStore {
  static bool _isLoggedIn = false;
  static bool get isLoggedIn => _isLoggedIn;

  static final ValueNotifier<UserProfileData> userNotifier = ValueNotifier<UserProfileData>(
    UserProfileData(
      ownerName: 'Animal Owner',
      petName: '',
      petBreed: '',
      phone: '',
    ),
  );

  static UserProfileData get currentUser => userNotifier.value;

  static final ValueNotifier<String> languageNotifier = ValueNotifier<String>('English');
  static String get language => languageNotifier.value;

  static Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      final currentAccount = prefs.getString('current_account_id') ?? 'default';
      final ownerName = prefs.getString('user_owner_name_$currentAccount') ?? prefs.getString('user_owner_name') ?? 'Animal Owner';
      final petName = prefs.getString('user_pet_name_$currentAccount') ?? prefs.getString('user_pet_name') ?? '';
      final petBreed = prefs.getString('user_pet_breed_$currentAccount') ?? prefs.getString('user_pet_breed') ?? '';
      final phone = prefs.getString('user_phone_$currentAccount') ?? prefs.getString('user_phone') ?? '';
      final photoUrl = prefs.getString('user_photo_url_$currentAccount') ?? prefs.getString('user_photo_url');
      final savedLang = prefs.getString('user_app_language') ?? 'English';
      final token = prefs.getString('auth_token');

      languageNotifier.value = savedLang;

      if (token != null && token.isNotEmpty) {
        ApiClient.authToken = token;
      }

      userNotifier.value = UserProfileData(
        ownerName: _sanitizeOwnerName(ownerName),
        petName: petName,
        petBreed: petBreed,
        phone: phone,
        photoUrl: photoUrl,
      );
    } catch (e) {
      debugPrint('UserStore init error: $e');
    }
  }

  static Future<void> setLanguage(String newLang) async {
    if (newLang.isEmpty) return;
    languageNotifier.value = newLang;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_app_language', newLang);
    } catch (e) {
      debugPrint('UserStore setLanguage error: $e');
    }
  }

  static String _sanitizeOwnerName(String raw) {
    if (raw.trim().isEmpty || RegExp(r'^\d+$').hasMatch(raw.trim())) {
      return 'Animal Owner';
    }
    return raw;
  }

  static Future<void> loginSession({
    required String ownerName,
    required String phone,
    String? petName,
    String? petBreed,
    String? photoUrl,
    String? token,
  }) async {
    _isLoggedIn = true;
    final accountKey = phone.trim().toLowerCase();

    if (token != null && token.isNotEmpty) {
      ApiClient.authToken = token;
    }

    String finalOwnerName = _sanitizeOwnerName(ownerName);
    String finalPhone = phone;
    String finalPetName = petName ?? '';
    String finalPetBreed = petBreed ?? '';
    String? finalPhotoUrl = photoUrl;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_account_id', accountKey);

      // 1. Read existing stored profile specifically for THIS accountKey
      final cachedOwner = prefs.getString('user_owner_name_$accountKey');
      final cachedPet = prefs.getString('user_pet_name_$accountKey');
      final cachedBreed = prefs.getString('user_pet_breed_$accountKey');
      final cachedPhone = prefs.getString('user_phone_$accountKey');
      final cachedPhoto = prefs.getString('user_photo_url_$accountKey');

      if (cachedOwner != null && cachedOwner.trim().isNotEmpty && cachedOwner != 'Animal Owner') {
        finalOwnerName = _sanitizeOwnerName(cachedOwner);
      }
      if (cachedPet != null && cachedPet.trim().isNotEmpty) {
        finalPetName = cachedPet;
      }
      if (cachedBreed != null && cachedBreed.trim().isNotEmpty) {
        finalPetBreed = cachedBreed;
      }
      if (cachedPhone != null && cachedPhone.trim().isNotEmpty) {
        finalPhone = cachedPhone;
      }
      if (cachedPhoto != null && cachedPhoto.trim().isNotEmpty) {
        finalPhotoUrl = cachedPhoto;
      }

      // 2. Fetch live user profile from backend database if online
      try {
        final profileResp = await ApiClient().get('/auth/me');
        if (profileResp.isSuccess && profileResp.data != null) {
          final pData = profileResp.data!;
          final serverOwner = pData['owner_name'] ?? pData['full_name'] ?? pData['name'];
          final serverPet = pData['pet_name'];
          final serverBreed = pData['pet_breed'] ?? pData['breed'];
          final serverPhone = pData['phone'] ?? pData['mobile_number'];
          final serverPhoto = pData['photo_url'] ?? pData['avatar'];

          if (serverOwner != null && serverOwner.toString().isNotEmpty && (cachedOwner == null || cachedOwner.isEmpty || cachedOwner == 'Animal Owner')) {
            finalOwnerName = _sanitizeOwnerName(serverOwner.toString());
          }
          if (serverPet != null && serverPet.toString().isNotEmpty && (cachedPet == null || cachedPet.isEmpty)) {
            finalPetName = serverPet.toString();
          }
          if (serverBreed != null && serverBreed.toString().isNotEmpty && (cachedBreed == null || cachedBreed.isEmpty)) {
            finalPetBreed = serverBreed.toString();
          }
          if (serverPhone != null && serverPhone.toString().isNotEmpty && (cachedPhone == null || cachedPhone.isEmpty)) {
            finalPhone = serverPhone.toString();
          }
          if (serverPhoto != null && serverPhoto.toString().isNotEmpty && (cachedPhoto == null || cachedPhoto.isEmpty)) {
            finalPhotoUrl = serverPhoto.toString();
          }
        }
      } catch (_) {}

      // Save merged profile data to device storage for THIS account
      await prefs.setString('user_owner_name_$accountKey', finalOwnerName);
      await prefs.setString('user_phone_$accountKey', finalPhone);
      await prefs.setString('user_pet_name_$accountKey', finalPetName);
      await prefs.setString('user_pet_breed_$accountKey', finalPetBreed);
      if (finalPhotoUrl != null && finalPhotoUrl.isNotEmpty) {
        await prefs.setString('user_photo_url_$accountKey', finalPhotoUrl);
        await prefs.setString('user_photo_url', finalPhotoUrl);
      }

      await prefs.setString('user_owner_name', finalOwnerName);
      await prefs.setString('user_phone', finalPhone);
      await prefs.setString('user_pet_name', finalPetName);
      await prefs.setString('user_pet_breed', finalPetBreed);

      if (token != null) {
        await prefs.setString('auth_token', token);
      }

      userNotifier.value = UserProfileData(
        ownerName: finalOwnerName,
        petName: finalPetName,
        petBreed: finalPetBreed,
        phone: finalPhone,
        photoUrl: finalPhotoUrl,
      );
    } catch (e) {
      debugPrint('UserStore loginSession save error: $e');
    }
  }

  static Future<void> logoutSession() async {
    _isLoggedIn = false;
    ApiClient.authToken = null;
    userNotifier.value = UserProfileData(
      ownerName: 'Animal Owner',
      petName: '',
      petBreed: '',
      phone: '',
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', false);
      await prefs.remove('auth_token');
      await prefs.remove('current_account_id');
    } catch (e) {
      debugPrint('UserStore logoutSession error: $e');
    }
  }

  static Future<void> updateProfile({
    String? ownerName,
    String? petName,
    String? petBreed,
    String? phone,
    String? photoUrl,
  }) async {
    final cleanOwnerName = _sanitizeOwnerName(ownerName ?? currentUser.ownerName);
    final String finalPetName = petName ?? currentUser.petName;
    final String finalPetBreed = petBreed ?? currentUser.petBreed;
    final String finalPhone = phone ?? currentUser.phone;
    final String? finalPhotoUrl = photoUrl ?? currentUser.photoUrl;

    userNotifier.value = UserProfileData(
      ownerName: cleanOwnerName,
      petName: finalPetName,
      petBreed: finalPetBreed,
      phone: finalPhone,
      photoUrl: finalPhotoUrl,
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      final accountKey = prefs.getString('current_account_id') ?? 'default';

      await prefs.setString('user_owner_name_$accountKey', cleanOwnerName);
      await prefs.setString('user_pet_name_$accountKey', finalPetName);
      await prefs.setString('user_pet_breed_$accountKey', finalPetBreed);
      await prefs.setString('user_phone_$accountKey', finalPhone);
      if (finalPhotoUrl != null && finalPhotoUrl.isNotEmpty) {
        await prefs.setString('user_photo_url_$accountKey', finalPhotoUrl);
        await prefs.setString('user_photo_url', finalPhotoUrl);
      }

      await prefs.setString('user_owner_name', cleanOwnerName);
      await prefs.setString('user_pet_name', finalPetName);
      await prefs.setString('user_pet_breed', finalPetBreed);
      await prefs.setString('user_phone', finalPhone);
    } catch (e) {
      debugPrint('UserStore updateProfile error: $e');
    }
  }
}
