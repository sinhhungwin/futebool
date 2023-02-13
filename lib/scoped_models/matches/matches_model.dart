import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../config/service_locator.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';
import '../../services/api.dart';
import '../base_model.dart';

class MatchesModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  String errorText = '';
  late MatchModel match;
  List<User> liked = [];

  onModelReady() async {
    liked = [];
    setState(ViewState.busy);
    try {
      match = await apiService.getMatches();

      debugPrint("MATCH: $match");

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
      debugPrint(match.messages.toString());
      debugPrint(
          "EMAIL: $email - FLAG - ${match.messages.every((element) => element.email != email)}");

      if (match.messages.every((element) => element.email != email)) {
        liked.add(user);
      }
    } catch (e) {
      errorText = e.toString();
    }
    if (errorText.isNotEmpty) {
      setState(ViewState.error);
    }
  }

  toChatScreen(context, index) async {
    await Navigator.pushNamed(
      context,
      ChatScreen.routeName,
      arguments: ChatScreenArguments(
          liked[index].email, liked[index].name, liked[index].imageUrls.first),
    );

    onModelReady();
  }
}
