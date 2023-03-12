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
  List<User> chatted = [];

  onModelReady() async {
    liked = [];
    setState(ViewState.busy);
    try {
      match = await apiService.getMatches() ??
          MatchModel(like: [], liked: [], messages: []);

      for (String i in match.liked) {
        if (match.messages.every((element) => element.email != i)) {
          liked.add(await getUser(i));
        }
      }

      for (Message i in match.messages) {
        chatted.add(await getUser(i.email));
      }

      setState(ViewState.retrieved);
    } catch (e) {
      errorText = e.toString();
      setState(ViewState.error);
    }
  }

  Future<User> getUser(String email) async {
    try {
      User user = await apiService.getProfileData(email: email);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  toChatScreen(context, email) async {
    User user = await getUser(email);

    await Navigator.pushNamed(
      context,
      ChatScreen.routeName,
      arguments: ChatScreenArguments(email, user.name, user.imageUrls.first),
    );

    onModelReady();
  }
}
