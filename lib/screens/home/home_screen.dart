import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../base_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

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
      appBar: const CustomAppBar(
        title: 'Futebol',
        hasActions: true,
      ),
      body: BaseScreen<HomeModel>(
          onModelReady: (model) => model.onModelReady(),
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
                      onDoubleTap: () => model.toUserScreen(context),
                      child: Draggable(
                        feedback: UserCard(user: model.currentUser),
                        childWhenDragging: UserCard(user: model.nextUser),
                        onDragEnd: (drag) {
                          if (drag.velocity.pixelsPerSecond.dx < 0) {
                            model.swipeLeft();
                          } else {
                            model.swipeRight();
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
