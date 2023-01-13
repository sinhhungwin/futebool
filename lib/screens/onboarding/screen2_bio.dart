import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Name and Bio
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enter Name
                CustomTextHeader(tabController: tabController, text: "Name"),
                CustomTextField(
                  tabController: tabController,
                  text: "ENTER YOUR NAME",
                  controller: nameController,
                ),
                const SizedBox(
                  height: 100,
                ),

                // Enter Bio
                CustomTextHeader(tabController: tabController, text: "Bio"),
                CustomTextField(
                  tabController: tabController,
                  text: "ENTER YOUR TEAM DESCRIPTION",
                  controller: descriptionController,
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
                  tabController: tabController,
                  title: 'Next Step',
                  onPressed: () async {
                    // Obtain shared preferences.
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setString('name', nameController.text);
                    await prefs.setString('bio', descriptionController.text);

                    tabController.animateTo(tabController.index + 1);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
