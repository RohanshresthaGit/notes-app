import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/config/themes.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:notes_app/core/common/themes/theme_viewmodel.dart';
import 'package:notes_app/features/add_notes/view_model/add_notes_view_model.dart';
import 'package:notes_app/features/hidden_notes/view_model/hidden_notes_ui_view_model.dart';
import 'package:notes_app/features/hidden_notes/view_model/hidden_notes_view_model.dart';
import 'package:notes_app/features/notes/view_model/ui_view_model.dart';
import 'package:notes_app/features/notes/view_model/view_notes_view_model.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:notes_app/services/hive_service.dart';
import 'package:notes_app/services/navigation_service.dart';
import 'package:provider/provider.dart';

import 'features/add_hidden_notes/view_model/add_hidden_notes_view_model.dart';
import 'services/move_notes_view_model.dart';

final navigation = NavigationService.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Box<Notes> box = await DataBaseManager.initialize();
  final hiveService = HiveService(box);
  final hiddenNotes = HiddenNotesService();
  await hiddenNotes.openHiddenbox();
  final uiViewModel = UiViewModel();
  final authService = AuthServices();
  final hiddenNotesUiViewModel = HiddenNotesUiViewModel();
  final hiddenNotesViewModel = HiddenNotesViewModel(
    hiddenNotes,
    hiddenNotesUiViewModel,
    hiveService,
  );
  final notesViewModel = NotesViewModel(
    hiveService,
    uiViewModel,
    // hiddenNotesViewModel,
    hiddenNotes,
  );
  final moveNotesViewModel = MoveNotesViewModel(
    hiddenNotesViewModel: hiddenNotesViewModel,
    notesViewModel: notesViewModel,
  );
  final addHiddenNotesViewModel = AddHiddenNotesViewModel(
    hiddenNotes,
    hiddenNotesViewModel,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<HiveService>(create: (context) => hiveService),
        ChangeNotifierProvider<AuthServices>(create: (context) => authService),
        ChangeNotifierProvider<NotesViewModel>(
          create: (context) => notesViewModel,
        ),
        ChangeNotifierProvider(create: (context) => ThemeViewmodel()),
        ChangeNotifierProvider(
          create: (context) => AddNotesViewModel(hiveService, notesViewModel),
        ),
        ChangeNotifierProvider(
          create: (context) => uiViewModel,
          // DeleteNotesViewModel(box: box, viewNotesViewModel),
        ),
        ChangeNotifierProvider(create: (context) => hiddenNotesViewModel),
        ChangeNotifierProvider(create: (context) => hiddenNotesUiViewModel),
        ChangeNotifierProvider(create: (context) => moveNotesViewModel),
        ChangeNotifierProvider(create: (context) => addHiddenNotesViewModel),
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
            navigatorKey: NavigationService.instance.navigationKey,
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
