import 'package:flutter/cupertino.dart';
import 'package:futebol/models/chat/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/service_locator.dart';
import '../../services/api.dart';
import '../base_model.dart';

class ChatModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  String errorText = '';

  TextEditingController newMessage = TextEditingController();
  ScrollController chatController = ScrollController();
  List<MessageModel> messages = [];

  onModelReady(email) async {
    try {
      messages = await apiService.getMessages(email);

      setState(ViewState.retrieved);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        //write or call your logic
        //code will run when widget rendering complete
        scrollDown();
      });
    } catch (e) {
      errorText = e.toString();
      setState(ViewState.error);
    }
  }

  scrollDown() {
    if (chatController.hasClients) {
      chatController.animateTo(chatController.position.maxScrollExtent + 60,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }

    notifyListeners();
  }

  sendMessage(String email, String name) async {
    apiService.sendMessage(newMessage.text, email);
    apiService.updateLastMessage(newMessage.text, email, name);

    final prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email') ?? '';

    messages.add(
      MessageModel(
        sender: myEmail,
        receiver: email,
        message: newMessage.text,
        dateTime: DateTime.now(),
      ),
    );

    newMessage.clear();

    scrollDown();
  }
}
