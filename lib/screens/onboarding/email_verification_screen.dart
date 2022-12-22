import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'custom_button.dart';
import 'custom_text_field.dart';
import 'custom_text_header.dart';

class EmailVerification extends StatelessWidget {
  final TabController tabController;

  const EmailVerification({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                  tabController: tabController,
                  text: "Your Verification Code?"),
              CustomTextField(
                  tabController: tabController, text: "ENTER YOUR CODE"),
            ],
          ),
          StepProgressIndicator(
            totalSteps: 5,
            currentStep: 2,
            selectedColor: Theme.of(context).primaryColor,
            unselectedColor: Theme.of(context).backgroundColor,
          ),
          CustomButton(tabController: tabController, title: 'Next Step')
        ],
      ),
    );
  }
}
