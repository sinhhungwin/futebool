import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_header.dart';
import '../base_screen.dart';

class MapScreen extends StatelessWidget {
  final TabController tabController;

  const MapScreen({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<MapModel>(
      onModelReady: (model) {
        model.onModelReady(context);
      },
      builder: (context, child, model) {
        switch (model.state) {
          case ViewState.busy:
          case ViewState.retrieved:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                        StepProgressIndicator(
                          totalSteps: 4,
                          currentStep: 4,
                          selectedColor: Theme.of(context).primaryColor,
                          unselectedColor: Theme.of(context).backgroundColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          title: 'Sign Up',
                          onPressed: () =>
                              model.createNewUser(tabController, context),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          case ViewState.error:
          default:
            return const Scaffold();
        }
      },
    );
  }
}
