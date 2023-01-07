import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;

  const CustomAppBar({Key? key, required this.title, this.hasActions = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/futbol-solid.svg';

    final Widget svgIcon = SizedBox(
      height: 51,
      child: SvgPicture.asset(assetName,
          color: const Color(0xffC83939), semanticsLabel: 'App logo icon'),
    );

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: Hero(tag: 'logo', child: svgIcon),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
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
