import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('This is route: ${settings.name}');
    }

    switch (settings.name) {
      case SignInScreen.routeName:
        return SignInScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case MatchScreen.routeName:
        return MatchScreen.route();
      case UserScreen.routeName:
        return UserScreen.route(user: settings.arguments as User);
      case ChatScreen.routeName:
        final args = settings.arguments as ChatScreenArguments;
        return ChatScreen.route(
            email: args.email, name: args.name, avatarUrl: args.avatarUrl);
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();

      // Edit profile
      case ProfileBio.routeName:
        return ProfileBio.route();
      case ProfilePic.routeName:
        return ProfilePic.route();
      case ProfileMap.routeName:
        return ProfileMap.route();
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
