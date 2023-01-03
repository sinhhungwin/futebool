import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String title;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  const CustomButton(
      {Key? key,
      required this.tabController,
      required this.title,
      this.emailController,
      this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
          onPressed: () async {
            if (emailController != null && passwordController != null) {
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailController!.text,
                      password: passwordController!.text)
                  .then(
                (value) {
                  if (kDebugMode) {
                    print('User Added');
                  }
                },
              ).catchError(
                (error) {
                  if (kDebugMode) {
                    print('Failed to Add User');
                  }
                },
              );
            }
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
