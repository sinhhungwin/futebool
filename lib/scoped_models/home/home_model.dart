import 'package:flutter/foundation.dart';
import 'package:futebol/enums/view_state.dart';
import 'package:futebol/service_locator.dart';
import 'package:futebol/services/api.dart';

import '../../models/models.dart';
import '../base_model.dart';

class HomeModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  late User currentUser;
  late User nextUser;
  late List<User> users;

  onModelReady(List<User> users) async {
    setState(ViewState.busy);

    this.users = users;
    currentUser = this.users[0];
    nextUser = this.users[1];
    await Future.delayed(const Duration(seconds: 2));

    setState(ViewState.retrieved);
  }

  swipeLeft() {
    currentUser = nextUser;
    int nextIndex = (users.indexOf(nextUser) + 1) % 3;
    if (kDebugMode) {
      print('nextIndex = $nextIndex');
    }
    nextUser = users[nextIndex];
    notifyListeners();
  }

  swipeRight() {
    swipeLeft();
  }
}
