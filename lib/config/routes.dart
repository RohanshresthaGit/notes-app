import 'package:flutter/material.dart';
import 'package:notes_app/features/splash_screen/views/splash_page.dart';

class Routes {
  static const String splash = '/';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(builder: (context) => SplashPage());
    default:
      return MaterialPageRoute(builder: (context) => SplashPage());
  }
}
