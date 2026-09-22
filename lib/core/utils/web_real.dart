import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'dart:typed_data';

class WebPlatformHelper {
  static void registerIframeView(String viewId, String srcUrl) {
    ui_web.platformViewRegistry.registerViewFactory(
      viewId,
      (int id) {
        final iframe = html.IFrameElement()
          ..src = srcUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allow = 'camera; microphone; display-capture; autoplay; clipboard-write';
        return iframe;
      },
    );
  }

  static void pickWebFile(Function(List<int> bytes, String filename) onFilePicked, {dynamic source}) {
    final uploadInput = html.FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          if (reader.result != null) {
            final List<int> bytes = (reader.result as Uint8List).toList();
            onFilePicked(bytes, file.name);
          }
        });
      }
    });
  }
}
