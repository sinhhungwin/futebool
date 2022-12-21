import 'package:flutter/material.dart';
import 'package:futebol/widgets/widgets.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const UserScreen());
  }

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: routeName),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
