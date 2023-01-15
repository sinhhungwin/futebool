import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String title;
  final VoidCallback? onPressed;

  const CustomButton(
      {Key? key,
      required this.tabController,
      required this.title,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
              Color(0xffC83939),
            ),
          ),
          onPressed: onPressed ?? () {},
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
