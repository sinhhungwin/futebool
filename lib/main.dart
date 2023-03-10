import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futebol/config/app_router.dart';
import 'package:futebol/config/theme.dart';
import 'package:futebol/screens/screens.dart';

import 'config/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futebol',
      theme: theme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
