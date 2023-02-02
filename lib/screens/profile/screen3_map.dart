import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../widgets/widgets.dart';
import '../base_screen.dart';

class ProfileMap extends StatelessWidget {
  static const String routeName = '/profile-map';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfileMap(),
    );
  }

  const ProfileMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen<ProfileModel>(
        onModelReady: (model) => model.onModelReady(),
        builder: (context, child, model) {
          switch (model.state) {
            case ViewState.busy:
              return const Scaffold(
                appBar: CustomAppBar(
                  title: 'Futebol',
                  hasActions: false,
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ViewState.retrieved:
              return Scaffold(
                appBar: const CustomAppBar(
                  title: 'Futebol',
                  hasActions: false,
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Map
                        const CustomTextHeader(
                          text: 'Where are you?',
                        ),

                        Text(
                          model.city,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 300,
                          child: FlutterMap(
                            options: MapOptions(
                                center: model.location,
                                zoom: 15,
                                onTap: (_, location) {
                                  model.onTap(location);
                                }),
                            nonRotatedChildren: [
                              AttributionWidget.defaultWidget(
                                source: 'OpenStreetMap contributors',
                                onSourceTapped: null,
                              ),
                            ],
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                              MarkerLayer(
                                markers: [
                                  model.marker,
                                ],
                              ),
                            ],
                          ),
                        ),

                        // To next onboarding screen
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              title: 'UPDATE',
                              onPressed: () => model.updateMap(context),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            case ViewState.error:

            default:
              return const Scaffold();
          }
        });
  }
}
