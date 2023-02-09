import '../chat/massage_model.dart';

class MatchModel {
  List<String> like;
  List<String> liked;
  List<Massage> chats;

  MatchModel({required this.like, required this.liked, required this.chats});

  MatchModel.fromJSON(data)
      : like = List<String>.from(data['like']),
        liked = List<String>.from(data['liked']),
        chats = [] {
    List<Massage> res = [];
    data['chats'].forEach((e) => res.add(Massage.fromJSON(e)));

    chats = res;
  }

  @override
  String toString() {
    return "Match: $like - $liked - $chats";
  }
}
