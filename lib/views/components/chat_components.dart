import 'dart:async';

import 'package:chat/constants.dart';
import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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

  Widget getMessage() {
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
                width: MediaQuery.of(context).size.width / 4,
                padding: EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                    right: isLeft ? 18 : 4,
                    left: isLeft ? 4 : 18),
                decoration: BoxDecoration(
                    borderRadius: kMessageBorderRadius(!isLeft),
                    color: Colors.deepPurpleAccent.withOpacity(0.4)),
                child: VoicePlayerWidget(
                  file: widget.message.file,
                  duration: widget.message.duration_seconds,
                  isLeft: isLeft,
                  width: ((MediaQuery.of(context).size.width / 4) / 5) * 4,
                  date: formatDate(widget.message.date),
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
                    Text(
                      widget.message.text,
                      style: const TextStyle(
                          color: Colors.blueAccent,
                          fontStyle: FontStyle.italic),
                    ),
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
                height: widget.message.height.toDouble(),
                width: widget.message.width.toDouble(),
                padding: EdgeInsets.only(
                    bottom: 4,
                    top: 4,
                    right: isLeft ? 18 : 4,
                    left: isLeft ? 4 : 18),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 1),
                    borderRadius: kMessageBorderRadius(!isLeft)),
                child: Column(
                  crossAxisAlignment: isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Image(
                        image:
                            AssetImage('assets/images/${widget.message.file}')),
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
    } else if (widget.message.type == MessageType.video) {
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
                height: widget.message.height.toDouble(),
                width: widget.message.width.toDouble(),
                padding: EdgeInsets.only(
                    bottom: 4,
                    top: 4,
                    right: isLeft ? 18 : 4,
                    left: isLeft ? 4 : 18),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 1.5),
                    borderRadius: kMessageBorderRadius(!isLeft)),
                child: Column(
                  crossAxisAlignment: isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.video_file),
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
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    isLeft = widget.userId != (int.parse(widget.message.from_id.substring(4)));
    return getMessage();
  }
}

class VoicePlayerWidget extends StatefulWidget {
  const VoicePlayerWidget({
    super.key,
    required this.file,
    required this.duration,
    required this.width,
    required this.isLeft,
    required this.date,
  });
  final String file;
  final double width;
  final int duration;
  final bool isLeft;
  final String date;
  @override
  State<VoicePlayerWidget> createState() => _VoicePlayerWidgetState();
}

class _VoicePlayerWidgetState extends State<VoicePlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double p = 0;
  double audioTime = -1;

  @override
  void initState() {
    isPlaying = false;
    audioTime = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () async {
                  if (!isPlaying) {
                    setState(() {
                      isPlaying = true;
                      audioTime = widget.duration as double;
                    });
                    await _audioPlayer
                        .play(UrlSource('assets/voice/${widget.file}'));
                    Timer.periodic(const Duration(milliseconds: 10), (timer) {
                      if (_audioPlayer.state == PlayerState.playing) {
                        setState(() {
                          p += widget.width / (widget.duration * 100);
                          audioTime -= 1 / 100;
                        });
                        timer.tick;
                      } else if (_audioPlayer.state == PlayerState.stopped) {
                        setState(() {
                          p = 0;
                          audioTime = -1;
                        });

                        timer.cancel();
                      } else if (_audioPlayer.state == PlayerState.paused) {}
                    });
                  } else {
                    setState(() {
                      isPlaying = false;
                    });

                    await _audioPlayer.stop();
                  }
                },
                child: Icon(
                  isPlaying ? Icons.stop : Icons.play_arrow,
                  size: 30,
                  color: isPlaying ? Colors.greenAccent : Colors.blueAccent,
                )),
            Container(
              width: widget.width,
              height: 16,
              color: Colors.redAccent,
              child: Padding(
                padding:
                    EdgeInsets.only(right: widget.width - (p >= 0 ? p : 0) - 1),
                child: const VerticalDivider(
                  width: 2,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(widget.date, style: kMessageDateStyle),
            ),
            Text(
              (audioTime != -1
                  ? audioTime.toStringAsFixed(0)
                  : widget.duration.toString()),
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
