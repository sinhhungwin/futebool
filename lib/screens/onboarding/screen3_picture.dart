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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                  tabController: tabController, text: "Add 2 or More Pictures"),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                ],
              ),
              Row(
                children: [
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                ],
              ),
            ],
          ),
          StepProgressIndicator(
            totalSteps: 5,
            currentStep: 3,
            selectedColor: Theme.of(context).primaryColor,
            unselectedColor: Theme.of(context).backgroundColor,
          ),
          CustomButton(tabController: tabController, title: 'Next Step')
        ],
      ),
    );
  }
}
