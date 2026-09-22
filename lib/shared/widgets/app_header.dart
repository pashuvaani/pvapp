import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 65 : 56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).cardTheme.color,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.heading2),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(subtitle!, style: AppStyles.subtext.copyWith(fontSize: 11)),
          ],
        ],
      ),
      actions: actions,
    );
  }
}
