import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../enums/view_state.dart';
import '../../scoped_models/models.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_text_header.dart';
import '../base_screen.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<EmailModel>(
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
                    // Enter Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextHeader(text: "Email"),
                        CustomTextField(
                            text: "ENTER YOUR EMAIL",
                            controller: model.emailController),
                        const SizedBox(
                          height: 50,
                        ),
                        const CustomTextHeader(text: "Password"),
                        CustomTextField(
                            text: "ENTER YOUR PASSWORD ",
                            obscureText: true,
                            controller: model.passwordController),
                        const SizedBox(
                          height: 50,
                        ),
                        const CustomTextHeader(text: "Password Again"),
                        CustomTextField(
                            text: "ENTER YOUR PASSWORD ",
                            obscureText: true,
                            controller: model.verifiedPasswordController),
                      ],
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    // To next onboarding screen
                    Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 4,
                          currentStep: 1,
                          selectedColor: Theme.of(context).primaryColor,
                          unselectedColor: Theme.of(context).backgroundColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          title: 'Next Step',
                          onPressed: () =>
                              model.registerWithEmail(tabController, context),
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
