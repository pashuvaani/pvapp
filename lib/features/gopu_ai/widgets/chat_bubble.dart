import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? speciesContext;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.speciesContext,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color aiBgColor = isDark ? const Color(0xFF25332D) : const Color(0xFFF4F8F5);
    final Color userBgColor = isDark ? const Color(0xFF138A5E) : AppColors.primaryDeepGreen;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                boxShadow: AppStyles.getBoxShadow(context),
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset('assets/images/logo/logopsv.png', fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: isUser ? userBgColor : aiBgColor,
                border: isUser ? null : Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
                boxShadow: isUser ? [] : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Text.rich(
                TextSpan(
                  children: _parseMarkdown(
                    text,
                    TextStyle(
                      fontSize: 15,
                      height: 1.45,
                      color: isUser ? Colors.white : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 40),
        ],
      ),
    );
  }

  List<InlineSpan> _parseMarkdown(String input, TextStyle baseStyle) {
    // 1. Remove heading symbols (e.g. ### Header -> Header)
    String cleaned = input.replaceAll(RegExp(r'^#+\s*', multiLine: true), '');
    // 2. Remove italic asterisks (*item* -> item)
    cleaned = cleaned.replaceAll(RegExp(r'(?<!\*)\*(?!\*)'), '');

    final List<InlineSpan> spans = [];
    final List<String> parts = cleaned.split('**');
    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      if (i % 2 == 1) {
        // Bold part without ** symbols
        spans.add(TextSpan(
          text: parts[i],
          style: baseStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: isUser ? Colors.white : (baseStyle.color ?? Colors.black),
          ),
        ));
      } else {
        // Normal text part
        spans.add(TextSpan(
          text: parts[i],
          style: baseStyle,
        ));
      }
    }
    return spans;
  }
}
