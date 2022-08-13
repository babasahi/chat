// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:chat/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> _messages = [];
  String _chatAccountName = '';
  int _chatAccountId = 0;
  int _userId = 0;
  String _userName = '';
  ChatProvider();

  List<Message> get messages => _messages;
  String get chatAccountName => _chatAccountName;
  int get chatAccountId => _chatAccountId;
  String get userName => _userName;
  int get userId => _userId;

  void init() {
    readFile();
  }

  void getChatInfo(String response) {
    final raw = json.decode(response);
    _chatAccountName = raw['name'];
    print('got name');
    _chatAccountId = raw['id'];
    print('got id');
    for (var message in raw['messages']) {
      var m = message as Map<String, dynamic>;
      if (m.containsKey('from') && m.containsKey('from_id')) {
        if (m['from'] != _chatAccountName) {
          _userName = m['from'] as String;
          print('got user name');
          String i = m['from_id'] as String;
          i = i.substring(4);
          _userId = int.parse(i);
          break;
        }
      }
    }
    notifyListeners();
    print('chat name is :$_chatAccountName');
    print('chat id is :$_chatAccountId');
    print('user id is :$_userId');
    print('user name is$_userName');
  }

  Future<void> readFile() async {
    final response = await rootBundle.loadString('assets/file.json');
    print('loaded files');
    _messages = parseData(response);
    getChatInfo(response);
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
