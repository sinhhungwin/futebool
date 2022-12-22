import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;

  const CustomAppBar({Key? key, required this.title, this.hasActions = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              title.toUpperCase(),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
      ),
      actions: !hasActions
          ? []
          : [
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
