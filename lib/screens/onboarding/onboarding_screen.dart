import 'package:flutter/material.dart';
import 'package:futebol/screens/onboarding/screen2_email_verification.dart';
import 'package:futebol/widgets/custom_appbar.dart';

import '../../scoped_models/models.dart';
import '../base_screen.dart';
import 'screen0_start.dart';
import 'screen1_email.dart';
import 'screen3_picture.dart';
import 'screen4_bio.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboard';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OnboardingScreen(),
    );
  }

  const OnboardingScreen({super.key});

  static const List<Tab> tabs = <Tab>[
    Tab(
      text: 'Start',
    ),
    Tab(
      text: 'Email',
    ),
    Tab(
      text: 'Email Verification',
    ),
    Tab(
      text: 'Picture',
    ),
    Tab(
      text: 'Bio',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen<OnboardingModel>(onModelReady: (model) {
      model.onModelReady();
    }, builder: (context, child, model) {
      return DefaultTabController(
        length: tabs.length,
        child: Builder(
          builder: (context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {}
            });

            return Scaffold(
              appBar: const CustomAppBar(
                title: 'futebol',
                hasActions: false,
              ),
              body: TabBarView(
                children: [
                  Start(tabController: tabController),
                  Email(tabController: tabController),
                  EmailVerification(tabController: tabController),
                  Picture(tabController: tabController),
                  Bio(tabController: tabController)
                ],
              ),
            );
          },
        ),
      );
      // ,
      // switch (model.state) {
      //   case ViewState.busy:
      //
      //   case ViewState.retrieved:
      //     return Scaffold(
      //         appBar: CustomAppBar(
      //           title: 'futebol',
      //           hasActions: false,
      //         ),
      //         body: Text('Retrieved'));
      //
      //   case ViewState.error:
      //
      //   default:
      //     return const Scaffold();
      // }
    });
  }
}
