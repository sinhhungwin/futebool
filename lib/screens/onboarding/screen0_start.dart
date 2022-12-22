import 'package:flutter/material.dart';

import 'widget_custom_button.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/team.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to Futebol',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'A Flutter project for underground football club to find its perfect match',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(height: 1.8),
                ),
              ),
            ],
          ),
          CustomButton(tabController: tabController, title: 'Start')
        ],
      ),
    );
  }
}
