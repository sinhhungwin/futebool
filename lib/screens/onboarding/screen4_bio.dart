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
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Name and Bio
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enter Name
              CustomTextHeader(
                  tabController: tabController, text: "What's is Your Name?"),
              CustomTextField(
                tabController: tabController,
                text: "ENTER YOUR NAME",
                controller: nameController,
              ),
              const SizedBox(
                height: 100,
              ),

              // Enter Bio
              CustomTextHeader(
                  tabController: tabController,
                  text: "Tell Us About Your Team?"),
              CustomTextField(
                tabController: tabController,
                text: "ENTER YOUR TEAM DESCRIPTION",
                controller: descriptionController,
              ),
            ],
          ),

          // To next onboarding screen
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 5,
                currentStep: 4,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).backgroundColor,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                tabController: tabController,
                title: 'Next Step',
              )
            ],
          ),
        ],
      ),
    );
  }
}
