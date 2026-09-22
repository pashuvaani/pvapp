import 'package:image_picker/image_picker.dart';

// Non-web platform stub implementation
class WebPlatformHelper {
  static void registerIframeView(String viewId, String srcUrl) {}

  static void pickWebFile(Function(List<int> bytes, String filename) onFilePicked, {ImageSource source = ImageSource.gallery}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source, imageQuality: 85);
      if (image != null) {
        final List<int> bytes = await image.readAsBytes();
        onFilePicked(bytes, image.name);
      }
    } catch (e) {
      // Print diagnostic log if image picking fails
      print('Image picker error: $e');
    }
  }
}

