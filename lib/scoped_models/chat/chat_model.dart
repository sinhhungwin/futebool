import 'package:flutter/cupertino.dart';
import 'package:futebol/models/chat/massage_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/service_locator.dart';
import '../../services/api.dart';
import '../base_model.dart';

class ChatModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  String errorText = '';

  TextEditingController newMessage = TextEditingController();
  List<Massage> messages = [];

  onModelReady(email) async {
    try {
      messages = await apiService.getMessages(email);

      setState(ViewState.retrieved);
    } catch (e) {
      errorText = e.toString();
      setState(ViewState.error);
    }
  }

  sendMessage(String email, String name) async {
    apiService.sendMessage(newMessage.text, email);
    apiService.updateLastMessage(newMessage.text, email, name);

    final prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email') ?? '';

    messages.add(
      Massage(
        sender: myEmail,
        receiver: email,
        message: newMessage.text,
        dateTime: DateTime.now(),
      ),
    );

    newMessage.clear();

    notifyListeners();
  }
}
