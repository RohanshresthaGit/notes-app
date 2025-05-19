import 'package:flutter/material.dart';
import 'package:notes_app/features/add_notes/view/add_notes_views.dart';
import 'package:notes_app/features/hidden_notes/views/authenticate_view.dart';
import 'package:notes_app/features/hidden_notes/views/hidden_notes_settings_view.dart';
import 'package:notes_app/features/hidden_notes/views/hidden_notes_views.dart';
import 'package:notes_app/features/notes/views/view_notes_view.dart';
import 'package:notes_app/features/splash_screen/views/splash_page.dart';

class Routes {
  static const String splash = '/';
  static const String notes = '/notes';
  static const String addNotes = '/add';
  static const String updateNotes = '/update';
  static const String authenticateUser = '/authenticateUser';
  static const String hiddenNotes = '/hiddenNotes';
  static const String hiddenNotesSettings = '/hiddenNotesSettings';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(builder: (context) => SplashPage());
    case Routes.notes:
      return _createRouteAnimation(ViewNotesView(), animationType: 'LR');
    case Routes.addNotes:
      return _createRouteAnimation(AddNotesViews(), animationType: "RT");
    case Routes.updateNotes:
      final args = settings.arguments as Map<String, dynamic>?;

      return _createRouteAnimation(
        AddNotesViews(isUpdate: true, index: args!['index']),
        animationType: "RT",
      );
    case Routes.authenticateUser:
      return _createRouteAnimation(AuthenticateView(), animationType: "RT");
    case Routes.hiddenNotes:
      return _createRouteAnimation(HiddenNotesViews(), animationType: "DU");
    case Routes.hiddenNotesSettings:
      return _createRouteAnimation(
        HiddenNotesSettingsView(),
        animationType: "RT",
      );
    default:
      return MaterialPageRoute(builder: (context) => SplashPage());
  }
}

PageRouteBuilder _createRouteAnimation(
  Widget page, {
  String animationType = 'LT',
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (animationType) {
        case 'LR':
          var slideAnimation = Tween<Offset>(
            begin: Offset(-1.0, 0.0), // Right to left
            end: Offset(0.0, 0.0),
          ).animate(animation);
          return SlideTransition(position: slideAnimation, child: child);
        case 'DU':
          var slideAnimation = Tween<Offset>(
            begin: Offset(0.0, 1.0), // Down To Up
            end: Offset(0.0, 0.0),
          ).animate(animation);
          return SlideTransition(position: slideAnimation, child: child);
        case 'RT':
        default:
          var slideAnimation = Tween<Offset>(
            begin: Offset(1.0, 0.0), // Right to left
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(position: slideAnimation, child: child);
      }
    },
  );
}
