import 'package:chat/constants.dart';
import 'package:chat/data/providers.dart';
import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  int userId = 0;
  bool isLeft = false;
  @override
  Widget build(BuildContext context) {
    userId = Provider.of<ChatProvider>(context).userId;
    isLeft = userId != (int.parse(widget.message.from_id.substring(4)));
    return Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Material(
            borderRadius: kMessageBorderRadius(!isLeft),
            elevation: 2,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 4,
                top: 4,
                right: isLeft ? 18 : 4,
                left: isLeft ? 4 : 18,
              ),
              decoration: BoxDecoration(
                  borderRadius: kMessageBorderRadius(!isLeft),
                  color: Colors.greenAccent.withOpacity(0.4)),
              child: Column(
                crossAxisAlignment:
                    isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(widget.message.text, style: kMessageTextStyle),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        Provider.of<ChatProvider>(context)
                            .formatDate(widget.message.date),
                        style: kMessageDateStyle),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context, listen: false).init();
    var messages = Provider.of<ChatProvider>(context, listen: false).messages;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (contex, index) {
              Message message = messages[index];

              return MessageWidget(message: message);
            },
          ),
        ));
  }
}
