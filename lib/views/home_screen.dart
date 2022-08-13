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
  @override
  Widget build(BuildContext context) {
    userId = Provider.of<ChatProvider>(context).userId;
    return Container(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.only(
          bottom: 8,
          right: userId != (int.parse(widget.message.from_id.substring(4)))
              ? MediaQuery.of(context).size.width / 3
              : 6,
          left: userId == (int.parse(widget.message.from_id.substring(4)))
              ? MediaQuery.of(context).size.width / 3
              : 6),
      child: Material(
        borderRadius: BorderRadius.only(
            topLeft: userId == (int.parse(widget.message.from_id.substring(4)))
                ? const Radius.circular(18)
                : const Radius.circular(0),
            bottomLeft:
                userId == (int.parse(widget.message.from_id.substring(4)))
                    ? const Radius.circular(18)
                    : const Radius.circular(0),
            topRight: userId != (int.parse(widget.message.from_id.substring(4)))
                ? const Radius.circular(18)
                : const Radius.circular(0),
            bottomRight:
                userId != (int.parse(widget.message.from_id.substring(4)))
                    ? const Radius.circular(18)
                    : const Radius.circular(0)),
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft:
                      userId == (int.parse(widget.message.from_id.substring(4)))
                          ? const Radius.circular(18)
                          : const Radius.circular(0),
                  bottomLeft:
                      userId == (int.parse(widget.message.from_id.substring(4)))
                          ? const Radius.circular(18)
                          : const Radius.circular(0),
                  topRight:
                      userId != (int.parse(widget.message.from_id.substring(4)))
                          ? const Radius.circular(18)
                          : const Radius.circular(0),
                  bottomRight:
                      userId != (int.parse(widget.message.from_id.substring(4)))
                          ? const Radius.circular(18)
                          : const Radius.circular(0)),
              color: Colors.greenAccent.withOpacity(0.4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.message.text,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                widget.message.date,
                style: const TextStyle(fontSize: 12),
              ),
            ],
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
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (contex, index) {
            Message message = messages[index];

            return MessageWidget(message: message);
          },
        ),
      )),
    );
  }
}
