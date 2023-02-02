import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../base_screen.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/sign-in';

  const SignInScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SignInScreen(),
    );
  }

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Enter Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextHeader(text: "Email"),
                        CustomTextField(
                            text: "ENTER YOUR EMAIL",
                            controller: model.emailController),
                        const SizedBox(
                          height: 100,
                        ),
                        const CustomTextHeader(text: "Password"),
                        CustomTextField(
                            text: "ENTER YOUR PASSWORD ",
                            obscureText: true,
                            controller: model.passwordController),
                      ],
                    ),

                    const SizedBox(
                      height: 100,
                    ),

                    // To Home Screen
                    CustomButton(
                      title: 'Sign In',
                      onPressed: () => model.signInWithEmail(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        default:
          return const Scaffold();
      }
    });
  }
}
