import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'widget_custom_button.dart';
import 'widget_custom_img_container.dart';
import 'widget_custom_text_header.dart';

class Picture extends StatelessWidget {
  final TabController tabController;

  const Picture({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Team pics
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                  tabController: tabController, text: "Add 2 or More Pictures"),
              const SizedBox(
                height: 20,
              ),

              // Minimum 2 pics, Maximum 6 pics
              // 3 pics each row
              // First row of pics
              Row(
                children: [
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                ],
              ),

              // Second row of pics
              Row(
                children: [
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                ],
              ),
            ],
          ),

          // To next onboarding screen
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 5,
                currentStep: 3,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).backgroundColor,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(tabController: tabController, title: 'Next Step')
            ],
          ),
        ],
      ),
    );
  }
}
