import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futebol/screens/screens.dart';
import 'package:futebol/service_locator.dart';
import 'package:futebol/services/api.dart';

import '../../enums/view_state.dart';
import '../base_model.dart';

class SignInModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  onModelReady() {
    setState(ViewState.retrieved);
  }

  signInWithEmail(TabController tabController, context) async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          if (kDebugMode) {
            print('User Signed In Successfully');
          }

          Navigator.pushNamed(context, HomeScreen.routeName);
        },
      ).catchError(
        (error) {
          SnackBar snackBar = SnackBar(
            content: Text(
              error.toString(),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          if (kDebugMode) {
            print('Failed to Sign In');
          }
        },
      );
    }
    tabController.animateTo(tabController.index + 1);
  }
}
