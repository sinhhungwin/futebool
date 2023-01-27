import 'package:flutter/material.dart';

import '../../enums/view_state.dart';
import '../../scoped_models/models.dart';
import '../../widgets/widgets.dart';
import '../base_screen.dart';

class ProfilePic extends StatelessWidget {
  static const String routeName = '/profile-picture';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfilePic(),
    );
  }

  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen<ProfileModel>(
        onModelReady: (model) {},
        builder: (context, child, model) {
          switch (model.state) {
            case ViewState.busy:
            case ViewState.retrieved:
              return Scaffold(
                appBar: const CustomAppBar(
                  title: 'Futebol',
                  hasActions: false,
                ),
                body: Container(),
              );
            case ViewState.error:

            default:
              return const Scaffold();
          }
        });
  }
}
