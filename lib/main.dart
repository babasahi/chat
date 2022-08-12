import 'dart:convert';

import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Message> _messages = [];
  Future<void> readFile() async {
    final response = await rootBundle.loadString('assets/file.json');
    print('loaded files');
    final data = json.decode(response)['messages'];
    print(data);
    for (var j in data) {
      if (j['type'] == 'message' && j['text'].toString().isNotEmpty) {
        Message = Message.fromJson(j);
        // _messages.add(Message.fromJson(j));
        print(j['text']);
      }
    }
    print('filled items');
  }

  @override
  void initState() {
    super.initState();
    readFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (contex, index) {
            Message message = _messages[index];

            return MessageWidget(message: message);
          },
        ),
      )),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 8, horizontal: MediaQuery.of(context).size.width / 3),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            color: Colors.yellowAccent.withOpacity(0.6)),
        child: Column(
          children: [
            Text(
              message.text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              message.date,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
