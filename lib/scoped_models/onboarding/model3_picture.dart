import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_model.dart';

class PictureModel extends BaseModel {
  onModelReady() {}

  toMap(context, tabController) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    List<String> imageUrls = prefs.getStringList('imageUrls') ?? [];

    int length = imageUrls.length;
    if (length < 2) {
      SnackBar snackBar = const SnackBar(
        content: Text(
          'Add at least 2 pictures of your team',
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      tabController.animateTo(tabController.index + 1);
    }
  }
}
