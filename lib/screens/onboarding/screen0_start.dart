import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../scoped_models/models.dart';
import '../../widgets/custom_button.dart';
import '../base_screen.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/balling-1.svg';

    final Widget svgIcon = SizedBox(
      height: 251,
      width: 251,
      child: SvgPicture.asset(assetName),
    );

    return BaseScreen<StartModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, child, model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: svgIcon,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Welcome Text
                  Text(
                    'Welcome to Futebol',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Project Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Convenient football team opponent finder. Join our polite and fair play community. And get your team a matching rival !',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(height: 1.8),
                    ),
                  ),
                ],
              ),

              // To next onboarding screen
              // or sign in screen
              Column(
                children: [
                  TextButton(
                      onPressed: () => model.toSignIn(context),
                      child: const Text('Already have an account ?')),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Next Step',
                    onPressed: () =>
                        tabController.animateTo(tabController.index + 1),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
