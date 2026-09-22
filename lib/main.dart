import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_constants.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/user_store.dart';
import 'services/theme_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await UserStore.init();
  runApp(const PashuVaaniApp());
}

class PashuVaaniApp extends StatelessWidget {
  const PashuVaaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService().themeMode,
      builder: (context, currentThemeMode, child) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentThemeMode,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: (settings) {
            final builder = AppRoutes.routes[settings.name];
            if (builder != null) {
              if (settings.name == AppRoutes.gopuAi || 
                  settings.name == AppRoutes.products || 
                  settings.name == AppRoutes.consultation ||
                  settings.name == AppRoutes.home) {
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (context, animation, secondaryAnimation) => builder(context),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                  reverseTransitionDuration: const Duration(milliseconds: 300),
                );
              }
              return MaterialPageRoute(
                settings: settings,
                builder: builder,
              );
            }
            return null;
          },
        );
      },
    );
  }
}
