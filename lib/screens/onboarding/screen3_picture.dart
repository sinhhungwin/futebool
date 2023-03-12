import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_img_container.dart';
import '../../widgets/custom_text_header.dart';
import '../base_screen.dart';

class Picture extends StatelessWidget {
  final TabController tabController;

  const Picture({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<PictureModel>(
        builder: (context, child, model) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Team pics
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextHeader(text: "Add Pictures"),
                      const SizedBox(
                        height: 20,
                      ),

                      // Minimum 2 pics, Maximum 6 pics
                      // 3 pics each row
                      // First row of pics
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomImageContainer(),
                          CustomImageContainer(),
                          CustomImageContainer(),
                        ],
                      ),

                      // Second row of pics
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomImageContainer(),
                          CustomImageContainer(),
                          CustomImageContainer(),
                        ],
                      ),
                    ],
                  ),

                  // To next onboarding screen
                  Column(
                    children: [
                      StepProgressIndicator(
                        totalSteps: 4,
                        currentStep: 3,
                        selectedColor: Theme.of(context).primaryColor,
                        unselectedColor: Theme.of(context).backgroundColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        title: 'Next Step',
                        onPressed: () => model.toMap(context, tabController),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        onModelReady: (model) => model.onModelReady());
  }
}
