class MatchModel {
  List<String> like;
  List<String> liked;
  List<Message> messages;

  MatchModel({required this.like, required this.liked, required this.messages});

  MatchModel.fromJSON(data)
      : like = List<String>.from(data['like'] ?? []),
        liked = List<String>.from(data['liked'] ?? []),
        messages = [] {
    List<Message> messages = [];

    ((data['messages'] ?? {}) as Map).forEach((key, value) {
      messages.add(Message.fromJSON(key, value));
    });
    this.messages = messages;
  }

  @override
  String toString() {
    return 'MatchModel{like: $like, liked: $liked, messages: $messages}';
  }
}

class Message {
  String email;
  String message;
  String name;
  DateTime? time;

  Message({this.email = '', this.message = '', this.name = '', this.time});

  Message.fromJSON(this.email, data)
      : message = data['message'],
        name = data['name'],
        time = DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000);

  @override
  String toString() {
    return 'Message{email: $email, message: $message, name: $name, time: $time}';
  }
}
