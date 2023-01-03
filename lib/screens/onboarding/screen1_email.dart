import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'widget_custom_button.dart';
import 'widget_custom_text_field.dart';
import 'widget_custom_text_header.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Enter Email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                  tabController: tabController,
                  text: "What's is Your Email Address?"),
              CustomTextField(
                  tabController: tabController,
                  text: "ENTER YOUR EMAIL",
                  controller: emailController),
              SizedBox(
                height: 100,
              ),
              CustomTextHeader(
                  tabController: tabController, text: "Choose a Password"),
              CustomTextField(
                  tabController: tabController,
                  text: "ENTER YOUR PASSWORD ",
                  controller: passwordController),
            ],
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
                  title: 'Next Step',
                  emailController: emailController,
                  passwordController: passwordController),
            ],
          )
        ],
      ),
    );
  }
}
