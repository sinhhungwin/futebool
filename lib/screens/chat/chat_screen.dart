import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futebol/screens/base_screen.dart';

class ChatScreenArguments {
  final String email;
  final String name;
  final String avatarUrl;

  ChatScreenArguments(this.email, this.name, this.avatarUrl);
}

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route(
      {required String email,
      required String name,
      required String avatarUrl}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ChatScreen(
        email: email,
        name: name,
        avatarUrl: avatarUrl,
      ),
    );
  }

  final String email;
  final String name;
  final String avatarUrl;

  const ChatScreen(
      {Key? key,
      required this.email,
      required this.name,
      required this.avatarUrl})
      : super(key: key);

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
                backgroundImage: NetworkImage(avatarUrl),
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
      ),
      body: BaseScreen<ChatModel>(
        onModelReady: (model) {
          model.onModelReady(email);
        },
        builder: (context, child, model) {
          switch (model.state) {
            case ViewState.busy:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ViewState.retrieved:
              return Column(
                children: [
                  Expanded(
                    child: model.messages.isNotEmpty
                        ? ListView.builder(
                            controller: model.chatController,
                            shrinkWrap: true,
                            itemCount: model.messages.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: model.messages[index].sender != email
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
                                            model.messages[index].message,
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
                                              backgroundImage:
                                                  NetworkImage(avatarUrl),
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
                                                model.messages[index].message,
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
                            })
                        : const SizedBox(),
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
                            onPressed: () => model.sendMessage(email, name),
                            color: Colors.white,
                            icon: const Icon(Icons.send_outlined),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextField(
                            textInputAction: TextInputAction.newline,
                            onSubmitted: (value) =>
                                model.sendMessage(email, name),
                            controller: model.newMessage,
                            decoration: const InputDecoration(
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
              );
            case ViewState.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Text(
                    model.errorText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
