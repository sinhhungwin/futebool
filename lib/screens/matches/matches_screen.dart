import 'package:flutter/material.dart';
import 'package:futebol/widgets/widgets.dart';

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
    return const Scaffold(
      appBar: CustomAppBar(title: routeName),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
