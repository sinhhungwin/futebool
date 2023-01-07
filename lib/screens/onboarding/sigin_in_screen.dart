import 'package:flutter/material.dart';

import '../../enums/view_state.dart';
import '../../scoped_models/models.dart';
import '../../widgets/widgets.dart';
import '../base_screen.dart';
import 'widget_custom_button.dart';
import 'widget_custom_text_field.dart';
import 'widget_custom_text_header.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/sign-in';
  final TabController tabController;

  static Route route({required TabController tabController}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SignInScreen(
        tabController: tabController,
      ),
    );
  }

  const SignInScreen({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return BaseScreen<SignInModel>(onModelReady: (model) {
      model.onModelReady();
    }, builder: (context, child, model) {
      switch (model.state) {
        case ViewState.busy:

        case ViewState.retrieved:

        case ViewState.error:
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'Futebol',
              hasActions: false,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Enter Email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextHeader(
                          tabController: tabController, text: "Email"),
                      CustomTextField(
                          tabController: tabController,
                          text: "ENTER YOUR EMAIL",
                          controller: model.emailController),
                      const SizedBox(
                        height: 100,
                      ),
                      CustomTextHeader(
                          tabController: tabController, text: "Password"),
                      CustomTextField(
                          tabController: tabController,
                          text: "ENTER YOUR PASSWORD ",
                          obscureText: true,
                          controller: model.passwordController),
                    ],
                  ),

                  // To next onboarding screen
                  CustomButton(
                    tabController: tabController,
                    title: 'Sign In',
                    onPressed: () => model.signInWithEmail(tabController),
                  ),
                ],
              ),
            ),
          );
        default:
          return const Scaffold();
      }
    });
  }
}
