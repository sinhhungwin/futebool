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
  final verifiedPasswordController = TextEditingController();

  onModelReady() {
    setState(ViewState.retrieved);
  }

  registerWithEmail(TabController tabController, context) async {
    String email = emailController.text;
    String password = passwordController.text;
    String passwordAgain = verifiedPasswordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      if (password != passwordAgain) {
        SnackBar snackBar = const SnackBar(
          content: Text('Passwords not matched'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then(
          (value) {
            if (kDebugMode) {
              print('User Added');
            }
          },
        ).catchError(
          (error) {
            if (kDebugMode) {
              SnackBar snackBar = SnackBar(
                content: Text(
                  error.toString(),
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              print('Failed to Add User');
            }
          },
        );
      }
    }
    tabController.animateTo(tabController.index + 1);
  }
}
