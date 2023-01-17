import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_model.dart';

class BioModel extends BaseModel {
  final TextEditingController name = TextEditingController();
  final TextEditingController bio = TextEditingController();

  onModelReady() {}

  toPicture(context, tabController) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name.text);
    await prefs.setString('bio', bio.text);

    if (name.text.isNotEmpty && bio.text.isNotEmpty) {
      tabController.animateTo(tabController.index + 1);
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text(
          'Please enter your name and bio',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
