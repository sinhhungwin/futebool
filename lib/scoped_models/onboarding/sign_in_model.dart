import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../config/service_locator.dart';
import '../../enums/view_state.dart';
import '../../screens/screens.dart';
import '../../services/api.dart';
import '../base_model.dart';

class SignInModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  onModelReady() {
    setState(ViewState.retrieved);
  }

  signInWithEmail(context) async {
    String email = emailController.text;
    String password = passwordController.text;
    String signInRes = '';

    try {
      signInRes = await apiService.signInWithEmail(email, password);
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(
          e.toString(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (kDebugMode) {
        print('Failed to Sign In');
      }
    }

    if (signInRes.isNotEmpty) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }
}
