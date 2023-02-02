import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../base_screen.dart';
import '../screens.dart';

class MatchScreen extends StatelessWidget {
  static const String routeName = '/match';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const MatchScreen());
  }

  const MatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'matches'.toUpperCase(),
        hasActions: false,
      ),
      body: BaseScreen<MatchesModel>(onModelReady: (model) {
        model.onModelReady();
      }, builder: (context, child, model) {
        switch (model.state) {
          case ViewState.busy:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case ViewState.retrieved:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Your Like Section
                    Text(
                      'Like You',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              UserImageSmall(
                                  url: model.liked[index].imageUrls.first),
                              Text(
                                model.liked[index].name,
                                style: Theme.of(context).textTheme.headline5,
                              )
                            ],
                          );
                        },
                        itemCount: model.liked.length,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Your Chat Section
                    Text(
                      'Your Chats',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // TODO: Fix to Chat Screen
                            Navigator.pushNamed(context, ChatScreen.routeName);
                          },
                          child: Row(
                            children: [
                              // Avatar Pic
                              UserImageSmall(
                                  url: model.liked[index].imageUrls.first),

                              // Other info
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name
                                  Text(
                                    model.liked[index].name,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // Last chat message
                                  Text(
                                    model.match.chats[0].last,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // Last chat time
                                  Text(
                                    model.match.chats[0].last,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: model.match.chats.length,
                    ),
                  ],
                ),
              ),
            );
          case ViewState.error:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(38.0),
                child: Text(
                  model.errorText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          default:
            return const Scaffold();
        }
      }),
    );
  }
}
