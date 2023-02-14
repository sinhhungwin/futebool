import 'message_model.dart';

class Chat {
  final int user;
  final int matchedUser;
  final List<MessageModel> messages;

  const Chat({
    required this.user,
    required this.matchedUser,
    required this.messages,
  });
}
