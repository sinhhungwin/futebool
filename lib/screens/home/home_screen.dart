import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futebol/scoped_models/home_model.dart';
import 'package:futebol/screens/screens.dart';
import 'package:futebol/widgets/widgets.dart';

import '../../enums/view_state.dart';
import '../../models/models.dart';
import '../base_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Image.asset(
                'assets/logo.png',
                height: 50,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Discover'.toUpperCase(),
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      body: BaseScreen<HomeModel>(
          onModelReady: (model) => model.onModelReady(User.users),
          builder: (context, child, model) {
            switch (model.state) {
              case ViewState.busy:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ViewState.retrieved:
                return Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Navigator.pushNamed(context, UserScreen.routeName,
                            arguments: model.currentUser);
                      },
                      child: Draggable(
                        feedback: UserCard(user: model.currentUser),
                        childWhenDragging: UserCard(user: model.nextUser),
                        onDragEnd: (drag) {
                          if (drag.velocity.pixelsPerSecond.dx < 0) {
                            // Swiped Left
                            if (kDebugMode) {
                              model.swipeLeft();
                              print('Swipe Left');
                            }
                          } else {
                            // Swiped Right
                            if (kDebugMode) {
                              model.swipeRight();
                              print('Swipe Right');
                            }
                          }
                        },
                        child: UserCard(user: model.currentUser),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => model.swipeLeft(),
                            child: ChoiceButton(
                              size: 25,
                              color: Theme.of(context).colorScheme.secondary,
                              icon: Icons.clear_rounded,
                              height: 60,
                              width: 60,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.swipeRight(),
                            child: ChoiceButton(
                              size: 40,
                              color: Theme.of(context).colorScheme.secondary,
                              icon: Icons.favorite,
                              height: 80,
                              width: 80,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.swipeLeft(),
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
                    )
                  ],
                );

              case ViewState.error:
                return const Center(
                  child: Text('Something went wrong'),
                );

              default:
                return const Scaffold();
            }
          }),
    );
  }
}
