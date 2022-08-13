import 'package:chat/data/providers.dart';
import 'package:chat/models/models.dart';
import 'package:chat/views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int userId = 0;
  String chatAccountName = '';
  List<Message> messages = [];
  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text(
            'Chat Preview',
            style: TextStyle(fontSize: 30, fontFamily: 'Poppins'),
          ),
        ),
        body: SafeArea(
            child: Center(
          child: GestureDetector(
            onTap: (() {
              messages =
                  Provider.of<ChatProvider>(context, listen: false).messages;
              userId = Provider.of<ChatProvider>(context, listen: false).userId;
              chatAccountName =
                  Provider.of<ChatProvider>(context, listen: false)
                      .chatAccountName;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                          messages: messages,
                          userId: userId,
                          chatAccountName: chatAccountName)));
            }),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.deepOrangeAccent.withOpacity(0.8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: const Text('Launch Chat'),
            ),
          ),
        )));
  }
}
