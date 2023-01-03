import 'package:flutter/material.dart';
import 'package:futebol/widgets/widgets.dart';

import '../../models/models.dart';

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
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();

    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: CustomAppBar(title: 'matches'.toUpperCase()),
      bottomNavigationBar: const CustomNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your Like Section
              Text(
                'Your Likes',
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
                            url: inactiveMatches[index]
                                .matchedUser
                                .imageUrls
                                .first),
                        Text(
                          inactiveMatches[index].matchedUser.name,
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    );
                  },
                  itemCount: inactiveMatches.length,
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
                  return Row(
                    children: [
                      // Avatar Pic
                      UserImageSmall(
                          url:
                              activeMatches[index].matchedUser.imageUrls.first),

                      // Other info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Text(
                            activeMatches[index].matchedUser.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          // Last chat message
                          Text(
                            activeMatches[index].chat![0].messages[0].message,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          // Last chat time
                          Text(
                            activeMatches[index]
                                .chat![0]
                                .messages[0]
                                .timeString,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      )
                    ],
                  );
                },
                itemCount: activeMatches.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
