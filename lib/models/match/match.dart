class MatchModel {
  List<String> like;
  List<String> liked;
  List<ChatModel> chats;

  MatchModel({required this.like, required this.liked, required this.chats});

  MatchModel.fromJSON(data)
      : like = List<String>.from(data['like']),
        liked = List<String>.from(data['liked']),
        chats = [] {
    List<ChatModel> res = [];
    data['chats'].forEach((e) => res.add(ChatModel.fromJSON(e)));

    chats = res;
  }

  @override
  String toString() {
    return "Match: $like - $liked - $chats";
  }
}

class ChatModel {
  String last;
  String email;
  bool lastMessage;

  ChatModel(
      {required this.email, required this.last, required this.lastMessage});

  ChatModel.fromJSON(data)
      : last = data['last'],
        email = data['email'],
        lastMessage = data['lastMessage'];

  @override
  String toString() {
    return "Chat: $email - $last - $lastMessage";
  }
}
