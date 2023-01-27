import 'package:flutter/material.dart';

import '../../enums/view_state.dart';
import '../../scoped_models/models.dart';
import '../../widgets/widgets.dart';
import '../base_screen.dart';

class ProfileBio extends StatelessWidget {
  static const String routeName = '/profile-bio';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfileBio(),
    );
  }

  const ProfileBio({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen<ProfileModel>(
        onModelReady: (model) => model.onModelReady(),
        builder: (context, child, model) {
          switch (model.state) {
            case ViewState.busy:
              return const Scaffold(
                appBar: CustomAppBar(
                  title: 'Futebol',
                  hasActions: false,
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ViewState.retrieved:
              return Scaffold(
                appBar: const CustomAppBar(
                  title: 'Futebol',
                  hasActions: false,
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                              controller: model.nameController,
                            ),
                            const SizedBox(
                              height: 100,
                            ),

                            // Enter Bio
                            const CustomTextHeader(text: "Bio"),
                            CustomTextField(
                              text: "ENTER YOUR TEAM DESCRIPTION",
                              controller: model.descriptionController,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 100,
                        ),

                        // To next onboarding screen
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              title: 'Update',
                              onPressed: () => model.updateBio(context),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            case ViewState.error:

            default:
              return const Scaffold();
          }
        });
  }
}
