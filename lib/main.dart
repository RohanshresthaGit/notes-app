import 'package:flutter/material.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/config/themes.dart';
import 'package:notes_app/core/common/themes/theme_viewmodel.dart';
import 'package:notes_app/services/hive_services/hive_service.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService.initializeHive();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeViewmodel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root of our application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewmodel>(
      builder:
          (context, theme, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notes',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: Routes.splash,
            themeMode: theme.themeMode,
            // themeAnimationCurve: Curves.linear,
            // themeAnimationDuration: Duration(milliseconds: 500),
            onGenerateRoute: generateRoute,
          ),
    );
  }
}
