// ignore_for_file: non_constant_identifier_names

class Message {
  final int id;
  final MessageType type;
  final String date;
  final String date_unixtime;
  final String from;
  final String from_id;
  final int reply_to_message_id;
  final String text;
  final String file;
  final int duration_seconds;

  Message(
      {required this.id,
      required this.type,
      required this.date,
      required this.date_unixtime,
      required this.from,
      required this.from_id,
      required this.reply_to_message_id,
      required this.text,
      required this.file,
      required this.duration_seconds});

  static Message fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        type: json['type'],
        date: json['date'],
        date_unixtime: json['date_unixtime'],
        from: json['from'],
        from_id: json['from_id'],
        reply_to_message_id: json['reply_to_message_id'],
        text: json['text'],
        duration_seconds: json['duration_seconds'],
        file: json['file']);
  }
}

// "id": 177712,
//  "type": "message",
//  "date": "2022-06-04T17:33:12",
//  "date_unixtime": "1654363992",
//  "from": "𝙱𝚊𝚋𝚎 𝚂𝚊𝚕𝚎𝚑 𝙼𝚊𝚑𝚏𝚘𝚞𝚍",
//  "from_id": "user1161880465",
//  "reply_to_message_id": 177711,
//  "text": "وانه كيني غزواني ؟"

enum MessageType { text, voice, audio, video, image, link }
