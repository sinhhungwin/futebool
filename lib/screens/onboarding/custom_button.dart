import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String title;

  const CustomButton(
      {Key? key, required this.tabController, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
          onPressed: () {
            tabController.animateTo(tabController.index + 1);
          },
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
            ),
          )),
    );
  }
}
