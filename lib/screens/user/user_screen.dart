import 'package:cached_network_image/cached_network_image.dart';
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
                              image: CachedNetworkImageProvider(
                                  user.imageUrls.first),
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

                // Info
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
                      const SizedBox(
                        height: 15,
                      ),

                      // City
                      Text(
                        'City',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        user.city,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.normal, height: 2),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Bio
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

                      // Pictures
                      Text(
                        'Pictures',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 125,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: user.imageUrls.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Container(
                                  height: 125,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          user.imageUrls[index]),
                                    ),
                                  ),
                                ),
                              );
                            }),
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
