import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../enums/view_state.dart';
import '../../service_locator.dart';
import '../../services/api.dart';
import '../base_model.dart';

class EmailModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  onModelReady() {
    setState(ViewState.retrieved);
  }

  registerWithEmail(TabController tabController) async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController!.text, password: passwordController!.text)
          .then(
        (value) {
          if (kDebugMode) {
            print('User Added');
          }
        },
      ).catchError(
        (error) {
          if (kDebugMode) {
            print('Failed to Add User');
          }
        },
      );
    }
    tabController.animateTo(tabController.index + 1);
  }
}
