import 'package:flutter/material.dart';

import '../../screens/screens.dart';
import '../base_model.dart';

class StartModel extends BaseModel {
  onModelReady() {
    setState(ViewState.retrieved);
  }

  toSignIn(context) {
    Navigator.pushNamed(context, SignInScreen.routeName);
  }
}
