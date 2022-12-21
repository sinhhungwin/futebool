import 'package:flutter/material.dart';
import 'package:futebol/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const ChatScreen());
  }

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: routeName),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
