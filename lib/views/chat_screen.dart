import 'package:chat/constants.dart';
import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {Key? key,
      required this.messages,
      required this.userId,
      required this.chatAccountName})
      : super(key: key);
  final List<Message> messages;
  final int userId;
  final String chatAccountName;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
            widget.chatAccountName,
            style: kTitleStyle,
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: widget.messages.length,
            itemBuilder: (contex, index) {
              Message message = widget.messages[index];

              return MessageWidget(
                message: message,
                userId: widget.userId,
              );
            },
          ),
        ));
  }
}

class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key, required this.message, required this.userId})
      : super(key: key);

  final Message message;
  final int userId;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool isLeft = false;

  String formatDate(String date) {
    var f = date.split('T')[1].substring(0, 5);
    return f;
  }

  @override
  Widget build(BuildContext context) {
    isLeft = widget.userId != (int.parse(widget.message.from_id.substring(4)));
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
                  left: isLeft ? 4 : 18),
              decoration: BoxDecoration(
                  borderRadius: kMessageBorderRadius(!isLeft),
                  color: Colors.deepPurpleAccent.withOpacity(0.4)),
              child: Column(
                crossAxisAlignment:
                    isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(widget.message.text, style: kMessageTextStyle),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(formatDate(widget.message.date),
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
