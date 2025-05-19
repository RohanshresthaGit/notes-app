import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/config/themes.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:notes_app/core/common/themes/theme_viewmodel.dart';
import 'package:notes_app/features/add_notes/view_model/add_notes_vire_model.dart';
import 'package:notes_app/features/notes/view_model/delete_notes_view_model.dart';
import 'package:notes_app/features/notes/view_model/view_notes_view_model.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:notes_app/services/hive_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Box<Notes> box = await DataBaseManager.initialize();
  final viewNotesViewModel = ViewNotesViewModel(box);
  final hiveService = HiveService(box);
  final authService = AuthServices();
  runApp(
    MultiProvider(
      providers: [
        Provider<HiveService>(create: (context) => hiveService),
        ChangeNotifierProvider<AuthServices>(create: (context) => authService),
        ChangeNotifierProvider<ViewNotesViewModel>(
          create: (context) => viewNotesViewModel,
        ),
        ChangeNotifierProvider(create: (context) => ThemeViewmodel()),
        ChangeNotifierProvider(
          create:
              (context) => AddNotesViewModel(hiveService, viewNotesViewModel),
        ),
        ChangeNotifierProvider(
          create:
              (context) => DeleteNotesViewModel(box: box, viewNotesViewModel),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            onGenerateRoute: generateRoute,
          ),
    );
  }
}
