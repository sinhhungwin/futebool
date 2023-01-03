import 'package:flutter/material.dart';
import 'package:futebol/models/models.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ChatScreen(userMatch: userMatch),
    );
  }

  final UserMatch userMatch;

  const ChatScreen({Key? key, required this.userMatch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage:
                    NetworkImage(userMatch.matchedUser.imageUrls.first),
              ),
              Text(
                userMatch.matchedUser.name,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat != null
                  ? Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: userMatch.chat![0].messages.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: userMatch
                                          .chat![0].messages[index].senderId ==
                                      1
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            color: Theme.of(context)
                                                .backgroundColor),
                                        child: Text(
                                          userMatch
                                              .chat![0].messages[index].message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(
                                                userMatch.matchedUser.imageUrls
                                                    .first),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Text(
                                              userMatch.chat![0].messages[index]
                                                  .message,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            );
                          }),
                    )
                  : const SizedBox(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(Icons.send_outlined),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Type here...',
                      contentPadding:
                          EdgeInsets.only(left: 20, bottom: 5, top: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
