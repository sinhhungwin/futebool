import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futebol/config/theme.dart';
import 'package:futebol/screens/base_screen.dart';

import '../../enums/match_result.dart';

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
    return BaseScreen<ChatModel>(
      onModelReady: (model) {
        model.onModelReady(email);
      },
      builder: (context, child, model) {
        switch (model.state) {
          case ViewState.busy:
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
                        backgroundImage: CachedNetworkImageProvider(avatarUrl),
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ViewState.retrieved:
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
                        backgroundImage: CachedNetworkImageProvider(avatarUrl),
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => model.ratingDialog(context),
                    child: const Text('Rate'),
                  ),
                  IconButton(
                    onPressed: () => model.addMatchDialog(context, email),
                    tooltip: 'Update result',
                    icon: SvgPicture.asset(
                      'assets/add_new_match.svg',
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                    stream: model.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      model.parseMessages(snapshot.data?.data());

                      Widget topWidget = const SizedBox(
                        height: 20,
                      );

                      if (model.isPending(snapshot.data?.data())) {
                        model.loadPending(snapshot.data?.data());

                        // TODO: Change != to ==
                        if (email != model.pending.home) {
                          String result;

                          switch (model.pending.result) {
                            case Result.win:
                              result = 'WIN';
                              break;
                            case Result.draw:
                              result = 'DRAW';
                              break;
                            case Result.loss:
                              result = 'LOSE';
                              break;
                          }

                          topWidget = ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("$name $result to you ?"),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          model.approveMatchResult(email);
                                        },
                                        icon: const Icon(
                                          Icons.check,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          model.disapproveMatchResult(email);
                                        },
                                        icon: const Icon(
                                            Icons.delete_outline_sharp)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      return Column(
                        children: [
                          topWidget,
                          Expanded(
                            child: ListView.builder(
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
                                                      CachedNetworkImageProvider(
                                                          avatarUrl),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(8),
                                                      ),
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  child: Text(
                                                    model.messages[index]
                                                        .message,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  );
                                }),
                          ),
                        ],
                      );
                    },
                  )
                      // : const SizedBox(),
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
              ),
            );
          case ViewState.error:
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
                        backgroundImage: CachedNetworkImageProvider(avatarUrl),
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Text(
                    model.errorText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
