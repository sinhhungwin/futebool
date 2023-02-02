import 'package:flutter/material.dart';
import 'package:futebol/screens/base_screen.dart';
import 'package:futebol/widgets/choice_button.dart';

import '../../models/models.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  final User user;

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => UserScreen(
        user: user,
      ),
    );
  }

  const UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BaseScreen<UserModel>(onModelReady: (model) {
        model.onModelReady();
      }, builder: (context, child, model) {
        switch (model.state) {
          case ViewState.busy:

          case ViewState.retrieved:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar Image and 3 Action Buttons
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Stack(
                    children: [
                      // Avatar image
                      Hero(
                        tag: user.imageUrls.first,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(user.imageUrls.first),
                            ),
                          ),
                        ),
                      ),

                      // Action buttons
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                // onTap: () => model.swipeLeft(),
                                child: ChoiceButton(
                                  size: 25,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  icon: Icons.clear_rounded,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                              InkWell(
                                // onTap: () => model.swipeRight(),
                                child: ChoiceButton(
                                  size: 40,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  icon: Icons.favorite,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              InkWell(
                                // onTap: () => model.swipeLeft(),
                                child: ChoiceButton(
                                  size: 25,
                                  color: Theme.of(context).primaryColor,
                                  icon: Icons.watch_later,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Description
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        user.city,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        user.bio,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(height: 2),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Interests',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                )
              ],
            );

          case ViewState.error:

          default:
            return const Scaffold();
        }
      }),
    );
  }
}
