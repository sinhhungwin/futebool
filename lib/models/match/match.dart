// TODO: rename match and chat
class Match2 {
  List<String> like;
  List<String> liked;
  List<Chat2> chats;

  Match2({required this.like, required this.liked, required this.chats});

  Match2.fromJSON(data)
      : like = List<String>.from(data['like']),
        liked = List<String>.from(data['liked']),
        chats = [] {
    List<Chat2> res = [];
    data['chats'].forEach((e) => res.add(Chat2.fromJSON(e)));

    chats = res;
  }

  @override
  String toString() {
    return "Match: $like - $liked - $chats";
  }
}

class Chat2 {
  String last;
  String email;
  bool lastMessage;

  Chat2({required this.email, required this.last, required this.lastMessage});

  Chat2.fromJSON(data)
      : last = data['last'],
        email = data['email'],
        lastMessage = data['lastMessage'];

  @override
  String toString() {
    return "Chat: $email - $last - $lastMessage";
  }
}
