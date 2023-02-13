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
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => model.toChatScreen(context, index),
                              child: Column(
                                children: [
                                  UserImageSmall(
                                      url: model.liked[index].imageUrls.first),
                                  Text(
                                    model.liked[index].name,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )
                                ],
                              ),
                            ),
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
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              ChatScreen.routeName,
                              arguments: ChatScreenArguments(
                                  model.match.messages[index].email,
                                  model.match.messages[index].name,
                                  // TODO: Add avatar to backend
                                  model.liked[index].imageUrls.first),
                            );

                            model.onModelReady();
                          },
                          child: Row(
                            children: [
                              // Avatar Pic
                              UserImageSmall(
                                  // TODO: Add avatar to backend and update here
                                  url:
                                      "https://t4.ftcdn.net/jpg/03/59/58/91/360_F_359589186_JDLl8dIWoBNf1iqEkHxhUeeOulx0wOC5.jpg"),

                              // Other info
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name
                                  Text(
                                    model.match.messages[index].name,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // Last chat message
                                  Text(
                                    model.match.messages[index].message,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // Last chat time
                                  Text(
                                    model.match.messages[index].time.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: model.match.messages.length,
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
