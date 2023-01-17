import 'package:flutter/material.dart';
import 'package:futebol/enums/view_state.dart';
import 'package:futebol/models/user/user_model.dart';
import 'package:futebol/scoped_models/models.dart';
import 'package:futebol/screens/base_screen.dart';
import 'package:futebol/widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = User.users[0];
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Futebol',
        hasActions: false,
      ),
      body: BaseScreen<ProfileModel>(
        builder: (context, child, model) {
          switch (model.state) {
            case ViewState.busy:
            case ViewState.idle:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ViewState.retrieved:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    // Avatar pic
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(3, 3),
                                blurRadius: 3,
                                spreadRadius: 3,
                              ),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  model.user?.imageUrls.first ?? ''),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.9),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  model.user?.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Bio, Pics, Location and Interest
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bio
                          const TitleWithIcon(title: 'About', icon: Icons.edit),
                          Text(
                            model.user?.bio ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.5),
                          ),

                          // Pics
                          const TitleWithIcon(
                              title: 'Pictures', icon: Icons.edit),
                          SizedBox(
                            height: 125,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: model.user?.imageUrls.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Container(
                                      height: 125,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              model.user?.imageUrls[index] ??
                                                  ''),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),

                          // Location
                          const TitleWithIcon(
                              title: 'Location', icon: Icons.edit),
                          Text(
                            model.user?.city ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.5),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Color(0xffC83939),
                                ),
                              ),
                              onPressed: () {},
                              child: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'sign out'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            case ViewState.error:
            default:
              return Container();
          }
        },
        onModelReady: (model) async {
          await model.onModelReady();
        },
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(icon),
        ),
      ],
    );
  }
}
