import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futebol/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const SplashScreen());
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/futbol-solid.svg';

    final Widget svgIcon = SizedBox(
      height: 251,
      width: 251,
      child: SvgPicture.asset(
          assetName,
          color: const Color(0xffC83939),
          semanticsLabel: 'App logo icon'
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svgIcon,
            const SizedBox(height: 20,),
            Text(
              'Futebol',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),

    );
  }
}
