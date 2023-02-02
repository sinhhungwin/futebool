import 'package:flutter/foundation.dart';

import '../../config/service_locator.dart';
import '../../models/models.dart';
import '../../services/api.dart';
import '../base_model.dart';

class MatchesModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  String errorText = '';
  late MatchModel match;
  List<User> liked = [];

  onModelReady() async {
    try {
      match = await apiService.getMatches();
      for (String i in match.liked) {
        await getUser(i);
      }

      setState(ViewState.retrieved);
    } catch (e) {
      errorText = e.toString();
      setState(ViewState.error);
    }
  }

  getUser(String email) async {
    try {
      User user = await apiService.getProfileData(email: email);
      debugPrint(user.toString());
      liked.add(user);
    } catch (e) {
      errorText = e.toString();
    }
    if (errorText.isNotEmpty) {
      setState(ViewState.error);
    }
  }
}
