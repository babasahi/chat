import 'package:chat/constants.dart';
import 'package:chat/models/models.dart';
import 'package:chat/views/components/chat_components.dart';
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
          centerTitle: true,
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
