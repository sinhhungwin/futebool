import '../chat/massage_model.dart';

class MatchModel {
  List<String> like;
  List<String> liked;
  List<Massage> chats;
  List<MMassage> messages;

  MatchModel(
      {required this.like,
      required this.liked,
      required this.chats,
      required this.messages});

  MatchModel.fromJSON(data)
      : like = List<String>.from(data['like']),
        liked = List<String>.from(data['liked']),
        messages = [],
        chats = [] {
    List<Massage> resChat = [];
    List<MMassage> resMessage = [];

    data['chats'].forEach((e) => resChat.add(Massage.fromJSON(e)));
    chats = resChat;

    (data['messages'] as Map).forEach((key, value) {
      resMessage.add(MMassage.fromJSON(key, value));
    });
    messages = resMessage;
  }

  @override
  String toString() {
    return "Match: $like - $liked - $chats - $messages";
  }
}

class MMassage {
  String email;
  String message;
  String name;
  DateTime? time;

  MMassage({this.email = '', this.message = '', this.name = '', this.time});

  MMassage.fromJSON(this.email, data)
      : message = data['message'],
        name = data['name'],
        time = DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000);

  @override
  String toString() {
    return 'MMassage{email: $email, message: $message, name: $name, time: $time}';
  }
}
