class Massage {
  final String sender;
  final String receiver;
  final String message;
  final DateTime dateTime;

  const Massage({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.dateTime,
  });

  Massage.fromJSON(data)
      : sender = data['sender'],
        receiver = data['receiver'],
        message = data['message'],
        dateTime = DateTime.fromMillisecondsSinceEpoch(
            data['dateTime'].seconds * 1000);
}
