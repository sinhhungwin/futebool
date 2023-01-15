import 'dart:async';

import 'package:flutter/material.dart';
import 'package:futebol/screens/screens.dart';
import 'package:futebol/service_locator.dart';
import 'package:futebol/services/api.dart';
import 'package:page_transition/page_transition.dart';

import '../base_model.dart';

class SplashModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  onModelReady() {}

  toOnboardingScreen(context) {
    Timer(
        const Duration(seconds: 1),
        () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const OnboardingScreen(),
              ),
            ));
  }
}
