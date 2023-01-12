import 'package:flutter/material.dart';
import 'package:futebol/enums/view_state.dart';
import 'package:futebol/screens/base_screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../scoped_models/models.dart';
import 'widget_custom_button.dart';

class MapScreen extends StatelessWidget {
  final TabController tabController;

  const MapScreen({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<MapModel>(
      onModelReady: (model) {
        model.onModelReady();
      },
      builder: (context, child, model) {
        switch (model.state) {
          case ViewState.busy:
          case ViewState.retrieved:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Map
                    Text(
                      'Map',
                      style: Theme.of(context).textTheme.headline1,
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    // To next onboarding screen
                    Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 5,
                          currentStep: 1,
                          selectedColor: Theme.of(context).primaryColor,
                          unselectedColor: Theme.of(context).backgroundColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          tabController: tabController,
                          title: 'Sign Up',
                          onPressed: () =>
                              model.createNewUser(tabController, context),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          case ViewState.error:
          default:
            return const Scaffold();
        }
      },
    );
  }
}
