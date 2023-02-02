import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_text_header.dart';
import '../base_screen.dart';

class Bio extends StatelessWidget {
  final TabController tabController;

  const Bio({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<BioModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, child, model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Name and Bio
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enter Name
                    const CustomTextHeader(text: "Name"),
                    CustomTextField(
                      text: "ENTER YOUR NAME",
                      controller: model.name,
                    ),
                    const SizedBox(
                      height: 100,
                    ),

                    // Enter Bio
                    const CustomTextHeader(text: "Bio"),
                    CustomTextField(
                      text: "ENTER YOUR TEAM DESCRIPTION",
                      controller: model.bio,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 100,
                ),

                // To next onboarding screen
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 4,
                      currentStep: 2,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      title: 'Next Step',
                      onPressed: () => model.toPicture(context, tabController),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
