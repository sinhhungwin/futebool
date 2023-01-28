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
                            SizedBox(
                              height: 300,
                              child: GridView.count(
                                crossAxisCount: 3,
                                children: [
                                  for (int i = 0; i < model.imgUrls.length; i++)
                                    ImgContainer(
                                      index: i,
                                      url: model.imgUrls[i],
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),

                        // To next onboarding screen
                        Column(
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              title: 'UPDATE',
                              // TODO: Update pics
                              // onPressed: () => model.,
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

class ImgContainer extends StatelessWidget {
  final int index;
  final String url;

  const ImgContainer({super.key, required this.index, required this.url});

  @override
  Widget build(BuildContext context) {
    return BaseScreen<ImgModel>(onModelReady: (model) {
      model.onModelReady(url);
    }, builder: (context, child, model) {
      switch (model.state) {
        case ViewState.busy:
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 10),
            child: Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                  left: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                  right: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE84545),
                ),
              ),
            ),
          );
        case ViewState.retrieved:
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 10),
            child: Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: model.image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                  left: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                  right: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () => model.updateImage(url, context),
                  icon: Icon(
                    model.isOld(url) ? Icons.edit : Icons.add_circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
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
