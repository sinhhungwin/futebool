import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../config/service_locator.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';
import '../../services/api.dart';
import '../base_model.dart';

class HomeModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  late User currentUser;
  late User nextUser;
  late List<User> users;

  onModelReady() async {
    setState(ViewState.busy);

    users = await apiService.getAllUsers();
    currentUser = users[0];
    nextUser = users[1];

    setState(ViewState.retrieved);
  }

  toUserScreen(context) => Navigator.pushNamed(context, UserScreen.routeName,
      arguments: currentUser);

  swipeLeft() {
    currentUser = nextUser;
    int nextIndex = (users.indexOf(nextUser) + 1) % users.length;
    if (kDebugMode) {
      print('nextIndex = $nextIndex');
    }
    nextUser = users[nextIndex];
    notifyListeners();
  }

  swipeRight() async {
    // Use API Service to update backend with this "like"
    // Let's call this function like(String email)
    await apiService.like(currentUser.email);
    swipeLeft();
  }
}
