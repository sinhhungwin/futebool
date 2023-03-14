import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:futebol/models/chat/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/glicko.dart' as algo;
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
  late PendingMatch pending;

  onModelReady(email) async {
    try {
      // messages = await apiService.getMessages(email);
      stream = await apiService.messagesStream(email);

      setState(ViewState.retrieved);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        //write or call your logic
        //code will run when widget rendering complete
        scrollDown();
      });
    } catch (e) {
      errorText = e.toString();
      dump(e);
      setState(ViewState.error);
    }
  }

  parseMessages(snapshot) {
    List<MessageModel> res = [];
    for (var item in snapshot['messages'] ?? []) {
      res.add(MessageModel.fromJSON(item));
    }

    messages = res;
    notifyListeners();
  }

  isPending(snapshot) => snapshot['pending'] != null;
  getMessagesLength(snapshot) =>
      isPending(snapshot) ? messages.length + 1 : messages.length;

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

  disapproveMatchResult(String partner) {
    apiService.deletePending(partner);
  }

  approveMatchResult(String partner) {
    apiService.deletePending(partner);
    updateStrength();
    apiService.updateStrength(
        pending.home, pending.homeStrength, pending.homePhi);
    apiService.updateStrength(
        pending.away, pending.awayStrength, pending.awayPhi);
  }

  updateStrength() {
    algo.Rating r1 = algo.Glicko2().createRating(mu: pending.homeStrength);
    algo.Rating r2 = algo.Glicko2().createRating(mu: pending.awayStrength);

    algo.Tuple<algo.Rating, algo.Rating> res;

    switch (pending.result) {
      case Result.win:
        res = algo.Glicko2().rate1vs1(r1, r2);
        break;
      case Result.draw:
        res = algo.Glicko2().rate1vs1(r1, r2, drawn: true);
        break;
      case Result.loss:
        res = algo.Glicko2().rate1vs1(r2, r1);
        break;
    }

    pending.homeStrength = res.item1.mu;
    pending.homePhi = res.item1.phi;
    pending.awayStrength = res.item2.mu;
    pending.awayPhi = res.item2.phi;
  }

  void addMatchDialog(context, String email) {
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
                apiService.addMatch(email, 'W');
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'D',
                style: ts?.copyWith(color: Colors.grey),
              ),
              onPressed: () {
                apiService.addMatch(email, 'D');
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'L',
                style: ts?.copyWith(color: Colors.red),
              ),
              onPressed: () {
                apiService.addMatch(email, 'L');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void ratingDialog(context, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextStyle? prompt = Theme.of(context).textTheme.headline3;

        TextEditingController ratingController = TextEditingController();
        double rating = 0;

        return AlertDialog(
          title: Text('Your rating:', style: prompt),
          actions: [
            Column(
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (_) => rating = _,
                ),
                TextFormField(
                  controller: ratingController,
                  decoration: const InputDecoration(hintText: "Your comment"),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          apiService.addRating(
                              email, rating, ratingController.text);
                          Navigator.pop(context);
                        },
                        child: const Text('Update')),
                  ],
                )
              ],
            )
          ],
        );
      },
    );
  }

  loadPending(snapshot) {
    pending = PendingMatch.fromJson(snapshot['pending']);
    notifyListeners();
  }
}

class PendingMatch {
  String home;
  num homeStrength;
  num homePhi;
  Result result;
  String away;
  num awayStrength;
  num awayPhi;

  PendingMatch.fromJson(data)
      : home = data['home'] ?? '',
        homeStrength = data['homeStrength'] ?? 0,
        homePhi = data['homePhi'] ?? 0,
        away = data['away'] ?? '',
        awayStrength = data['awayStrength'] ?? 0,
        awayPhi = data['awayPhi'] ?? 0,
        result = data['result'] == 'W'
            ? Result.win
            : data['result'] == 'D'
                ? Result.draw
                : Result.loss;
}
