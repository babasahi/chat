import 'package:chat/data/providers.dart';
import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(
          vertical: 8, horizontal: MediaQuery.of(context).size.width / 3),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.yellowAccent.withOpacity(0.6)),
          child: Column(
            children: [
              Text(
                message.text,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                message.date,
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
