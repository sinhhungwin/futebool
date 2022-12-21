import 'package:flutter/material.dart';
import 'package:futebol/models/models.dart';
import 'package:futebol/widgets/widgets.dart';

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
      body: Column(
        children: [
          UserCard(user: User.users[0]),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceButton(
                  size: 25,
                  color: Theme.of(context).accentColor,
                  icon: Icons.clear_rounded,
                  height: 60,
                  width: 60,
                ),
                ChoiceButton(
                  size: 30,
                  color: Theme.of(context).accentColor,
                  icon: Icons.favorite,
                  height: 80,
                  width: 80,
                ),
                ChoiceButton(
                  size: 25,
                  color: Theme.of(context).primaryColor,
                  icon: Icons.watch_later,
                  height: 60,
                  width: 60,
                ),
              ],
            ),
          )
        ],
      ),

      // bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final IconData icon;

  const ChoiceButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.size,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
