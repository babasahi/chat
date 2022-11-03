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
    _messages = parseJsonToMessages(response);
    getChatInfo(response);
    notifyListeners();
    print('filled items');
  }

  List<Message> parseJsonToMessages(String rawJson) {
    List<Message> list = [];
    final data = json.decode(rawJson)['messages'];
    for (var json in data) {
      var result = json as Map<String, dynamic>;
      if (result.containsKey('media_type')) {
        if (result['media_type'] == 'voice_message') {
          Message message = Message(
              id: result['id'],
              width: 0,
              height: 0,
              type: MessageType.voice,
              date: result['date'],
              date_unixtime: result['date_unixtime'],
              from: result['from'],
              from_id: result['from_id'],
              reply_to_message_id: result.containsKey('reply_to_message_id')
                  ? result['reply_to_message_id']
                  : -1,
              text: '',
              file: result['file'],
              duration_seconds: result.containsKey('duration_seconds')
                  ? result['duration_seconds']
                  : 0);

          list.add(message);
        } else if (result['media_type'] == 'video_file') {
          Message message = Message(
              id: result.containsKey('id') ? result['id'] : '',
              type: MessageType.video,
              date: result['date'],
              width: result['width'],
              height: result['height'],
              date_unixtime: result['date_unixtime'],
              from: result['from'],
              from_id: result['from_id'],
              reply_to_message_id: result.containsKey('reply_to_message_id')
                  ? result['reply_to_message_id']
                  : -1,
              text: '',
              file: result['file'],
              duration_seconds: 0);

          list.add(message);
        }
      } else if (result.containsKey('photo')) {
        Message message = Message(
            id: result['id'],
            width: result['width'],
            height: result['height'],
            type: MessageType.image,
            date: result['date'],
            date_unixtime: result['date_unixtime'],
            from: result['from'],
            from_id: result['from_id'],
            reply_to_message_id: result.containsKey('reply_to_message_id')
                ? result['reply_to_message_id']
                : -1,
            text: '',
            file: result['photo'],
            duration_seconds: result.containsKey('duration_seconds')
                ? result['duration_seconds']
                : 0);

        list.add(message);
      } else if (result['text'] != '') {
        String m = result['text'].toString();

        if (m.startsWith('[') && m.endsWith(']')) {
          if (m.contains('phone')) {
            Message message = Message(
                id: result.containsKey('id') ? result['id'] : '',
                type: MessageType.text,
                date: result['date'],
                width: 0,
                height: 0,
                date_unixtime: result['date_unixtime'],
                from: result['from'],
                from_id: result['from_id'],
                reply_to_message_id: result.containsKey('reply_to_message_id')
                    ? result['reply_to_message_id']
                    : -1,
                text: m.substring(21).replaceRange(
                    m.substring(21).length - 2, m.substring(21).length, ''),
                file: '',
                duration_seconds: 0);

            list.add(message);
          } else {
            Message message = Message(
                id: result.containsKey('id') ? result['id'] : '',
                type: MessageType.link,
                date: result['date'],
                height: 0,
                width: 0,
                date_unixtime: result['date_unixtime'],
                from: result['from'],
                from_id: result['from_id'],
                reply_to_message_id: result.containsKey('reply_to_message_id')
                    ? result['reply_to_message_id']
                    : -1,
                text: m.substring(19).replaceRange(
                    m.substring(19).length - 2, m.substring(19).length, ''),
                file: '',
                duration_seconds: 0);

            list.add(message);
          }
        } else {
          Message message = Message(
              id: result.containsKey('id') ? result['id'] : '',
              type: MessageType.text,
              height: 0,
              width: 0,
              date: result.containsKey('date') ? result['date'] : '',
              date_unixtime: result.containsKey('date_unixtime')
                  ? result['date_unixtime']
                  : '',
              from: result.containsKey('from') ? result['from'] : '',
              from_id: result.containsKey('from_id') ? result['from_id'] : '',
              reply_to_message_id: result.containsKey('reply_to_message_id')
                  ? result['reply_to_message_id']
                  : -1,
              text: result['text'].toString(),
              file: '',
              duration_seconds: 0);

          list.add(message);
        }
      }
    }
    return list;
  }

  bool isArabic(String s) {
    int c = s.runes.first;
    if (c >= 0x0600 && c <= 0x06E0) {
      print('testing');
      return true;
    }
    return false;
  }
}
