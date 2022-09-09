import 'package:chat/constants.dart';
import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';

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
    if (widget.message.type == MessageType.text) {
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
                  crossAxisAlignment: isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
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
    } else if (widget.message.type == MessageType.voice) {
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
                  crossAxisAlignment: isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.audio_file),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(formatDate(widget.message.date),
                          style: kMessageDateStyle),
                    ),
                    Text(widget.message.duration_seconds.toString()),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else if (widget.message.type == MessageType.link) {
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
                  crossAxisAlignment: isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.link),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(formatDate(widget.message.date),
                          style: kMessageDateStyle),
                    ),
                    Text(widget.message.text),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else if (widget.message.type == MessageType.image) {
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
                  crossAxisAlignment: isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Image(
                        height: 40,
                        width: 40,
                        image: AssetImage(widget.message.file)),
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
    } else {
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
                  crossAxisAlignment: isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.link),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(formatDate(widget.message.date),
                          style: kMessageDateStyle),
                    ),
                    Text(widget.message.text),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
