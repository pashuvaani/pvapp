import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    if (file.path.contains('app_theme.dart') || file.path.contains('app_colors.dart')) continue;
    
    String content = file.readAsStringSync();
    bool changed = false;

    if (content.contains('Colors.black87')) {
      content = content.replaceAllMapped(
          RegExp(r'const\s+TextStyle\([^)]*color:\s*Colors\.black87[^)]*\)'),
          (match) {
            String m = match.group(0)!;
            return m.replaceAll('const TextStyle', 'TextStyle')
                    .replaceAll('Colors.black87', 'Theme.of(context).colorScheme.onSurface');
          });
      content = content.replaceAll('color: Colors.black87', 'color: Theme.of(context).colorScheme.onSurface');
      changed = true;
    }
    
    if (content.contains('Colors.black54')) {
      content = content.replaceAllMapped(
          RegExp(r'const\s+TextStyle\([^)]*color:\s*Colors\.black54[^)]*\)'),
          (match) {
            String m = match.group(0)!;
            return m.replaceAll('const TextStyle', 'TextStyle')
                    .replaceAll('Colors.black54', 'Theme.of(context).colorScheme.onSurface.withOpacity(0.7)');
          });
      content = content.replaceAll('color: Colors.black54', 'color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)');
      changed = true;
    }

    if (content.contains('Colors.black')) {
      content = content.replaceAll(
          RegExp(r'color:\s*Colors\.black(?![\d])'), 
          'color: Theme.of(context).colorScheme.onSurface'
      );
      changed = true;
    }

    if (content.contains('decoration:') && content.contains('Colors.white')) {
       content = content.replaceAll(
          RegExp(r'decoration:\s*const\s*BoxDecoration\(\s*color:\s*Colors\.white'),
          r'decoration: BoxDecoration( color: Theme.of(context).cardTheme.color'
       );
       content = content.replaceAll(
          RegExp(r'decoration:\s*BoxDecoration\(\s*color:\s*Colors\.white'),
          r'decoration: BoxDecoration( color: Theme.of(context).cardTheme.color'
       );
       changed = true;
    }

    if (changed) {
       content = content.replaceAllMapped(RegExp(r'const\s+Text\(([^,]+),\s*style:\s*TextStyle'), (m) => 'Text(${m.group(1)}, style: TextStyle');
       // In case there are orphaned consts around Column/Row children
       content = content.replaceAll('children: const [', 'children: [');
       file.writeAsStringSync(content);
       print('Updated ${file.path}');
    }
  }
}
