import 'dart:async';

import 'package:flutter/material.dart';
import 'package:futebol/config/service_locator.dart';
import 'package:futebol/screens/screens.dart';
import 'package:futebol/services/api.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_model.dart';

class SplashModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  onModelReady(context) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';

    if (email.isEmpty) {
      toOnboardingScreen(context);
    } else {
      toHomeScreen(context);
    }
  }

  toOnboardingScreen(context) => Timer(
        const Duration(seconds: 1),
        () => Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const OnboardingScreen(),
            ),
            (_) => false),
      );

  toHomeScreen(context) => Timer(
        const Duration(seconds: 1),
        () => Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const HomeScreen(),
            ),
            (_) => false),
      );
}
