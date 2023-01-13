import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:futebol/enums/view_state.dart';
import 'package:futebol/screens/base_screen.dart';
import 'package:latlong2/latlong.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../scoped_models/models.dart';
import 'widget_custom_button.dart';
import 'widget_custom_text_header.dart';

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
                    CustomTextHeader(
                      tabController: tabController,
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
                            center: LatLng(21.028511, 105.804817),
                            zoom: 9.2,
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
                          tabController: tabController,
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
