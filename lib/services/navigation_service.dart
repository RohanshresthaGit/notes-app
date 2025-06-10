import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  static NavigationService instance = NavigationService();

  push(String route, [Map<String, dynamic>? args]) {
    return navigationKey.currentState?.pushNamed(route, arguments: args);
  }

  go(String route, [Map<String, dynamic>? args]) {
    return navigationKey.currentState?.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  popUntill(String route, [Map<String, dynamic>? args]) {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(route, (routes) => true,);
  }

  pop() {
    return navigationKey.currentState?.pop();
  }
}
