import 'dart:convert';

import 'package:chat/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;
  void init() {
    readFile();
  }

  Future<void> readFile() async {
    final response = await rootBundle.loadString('assets/file.json');
    print('loaded files');
    _messages = parseData(response);
    notifyListeners();
    print('filled items');
  }

  List<Message> parseData(String rawJson) {
    List<Message> list = [];
    final data = json.decode(rawJson)['messages'];
    for (var json in data) {
      var result = json as Map<String, dynamic>;
      if (result.containsKey('id') &&
          result.containsKey('type') &&
          result.containsKey('date') &&
          result.containsKey('date_unixtime') &&
          result.containsKey('from') &&
          result.containsKey('from_id') &&
          result.containsKey('reply_to_message_id') &&
          result.containsKey('text')) {
        if (result['text'].isNotEmpty && result['type'] == 'message') {
          Message message = Message(
              id: result['id'],
              type: result['type'],
              date: result['date'],
              date_unixtime: result['date_unixtime'],
              from: result['from'],
              from_id: result['from_id'],
              reply_to_message_id: result['reply_to_message_id'],
              text: result['text']);

          list.add(message);
        }
      }
    }
    return list;
  }

  String formatDate(String date) {
    String f = date.split(':')[1];
    return f;
  }
}
