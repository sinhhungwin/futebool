import 'package:flutter/foundation.dart';

import '../../config/service_locator.dart';
import '../../enums/view_state.dart';
import '../../models/models.dart';
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
