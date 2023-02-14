class MessageModel {
  final String sender;
  final String receiver;
  final String message;
  final DateTime dateTime;

  const MessageModel({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.dateTime,
  });

  MessageModel.fromJSON(data)
      : sender = data['sender'],
        receiver = data['receiver'],
        message = data['message'],
        dateTime = DateTime.fromMillisecondsSinceEpoch(
            data['dateTime'].seconds * 1000);

  @override
  String toString() {
    return 'Massage{sender: $sender, receiver: $receiver, message: $message, dateTime: $dateTime}';
  }
}
