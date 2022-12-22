import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'widget_custom_button.dart';
import 'widget_custom_text_field.dart';
import 'widget_custom_text_header.dart';

class Bio extends StatelessWidget {
  final TabController tabController;

  const Bio({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                  tabController: tabController, text: "What's is Your Name?"),
              CustomTextField(
                  tabController: tabController, text: "ENTER YOUR NAME"),
              const SizedBox(
                height: 100,
              ),
              CustomTextHeader(
                  tabController: tabController,
                  text: "Tell Us About Your Team?"),
              CustomTextField(
                  tabController: tabController,
                  text: "ENTER YOUR TEAM DESCRIPTION"),
            ],
          ),
          StepProgressIndicator(
            totalSteps: 5,
            currentStep: 4,
            selectedColor: Theme.of(context).primaryColor,
            unselectedColor: Theme.of(context).backgroundColor,
          ),
          CustomButton(tabController: tabController, title: 'Next Step')
        ],
      ),
    );
  }
}
