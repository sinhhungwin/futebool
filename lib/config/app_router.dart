import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futebol/models/user/models.dart';
import 'package:futebol/screens/screens.dart';
import 'package:futebol/widgets/custom_appbar.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('This is route: ${settings.name}');
    }

    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case MatchScreen.routeName:
        return MatchScreen.route();
      case UserScreen.routeName:
        return UserScreen.route(user: settings.arguments as User);
      case ChatScreen.routeName:
        return ChatScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const Scaffold(
        appBar: CustomAppBar(
          title: 'Error Navigating',
        ),
      ),
    );
  }
}
