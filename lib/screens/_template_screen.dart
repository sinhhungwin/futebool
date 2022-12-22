import 'package:flutter/material.dart';
import 'package:futebol/screens/base_screen.dart';

import '../enums/view_state.dart';

class Template extends StatelessWidget {
  const Template({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(onModelReady: (model) {
      // model.onModelReady()
    }, builder: (context, child, model) {
      switch (
          // model.state
          model) {
        case ViewState.busy:

        case ViewState.retrieved:

        case ViewState.error:

        default:
          return const Scaffold();
      }
    });
  }
}
