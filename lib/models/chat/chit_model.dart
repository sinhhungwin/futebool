import 'message_model.dart';

class Chit {
  final int user;
  final int matchedUser;
  final List<Message> messages;

  const Chit({
    required this.user,
    required this.matchedUser,
    required this.messages,
  });
}
