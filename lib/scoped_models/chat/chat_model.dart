import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late Stream<DocumentSnapshot> stream;

  onModelReady(email) async {
    try {
      messages = await apiService.getMessages(email);
      stream = await apiService.messagesStream(email);

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

  parseMessages(snapshot) {
    List<MessageModel> res = [];
    for (var item in snapshot['messages']) {
      res.add(MessageModel.fromJSON(item));
    }

    messages = res;
    notifyListeners();
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

  void addMatchDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextStyle? ts = Theme.of(context).textTheme.headline1;
        TextStyle? prompt = Theme.of(context).textTheme.headline3;

        return AlertDialog(
          title: Text('Your result:', style: prompt),
          actions: [
            TextButton(
              child: Text(
                'W',
                style: ts?.copyWith(color: Colors.green),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'D',
                style: ts?.copyWith(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'L',
                style: ts?.copyWith(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void ratingDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextStyle? ts = Theme.of(context).textTheme.headline1;
        TextStyle? prompt = Theme.of(context).textTheme.headline3;

        return AlertDialog(
          title: Text('Your rating:', style: prompt),
          actions: [
            TextButton(
              child: Text(
                'W',
                style: ts?.copyWith(color: Colors.green),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'D',
                style: ts?.copyWith(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'L',
                style: ts?.copyWith(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
