import 'package:flutter/material.dart';

const TextStyle kMessageTextStyle = TextStyle(
  fontSize: 16,
);

const TextStyle kMessageDateStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
);

BorderRadius kMessageBorderRadius(bool isLeft) {
  return BorderRadius.only(
      topLeft: isLeft ? const Radius.circular(18) : const Radius.circular(18),
      bottomLeft: isLeft ? const Radius.circular(18) : const Radius.circular(0),
      topRight: !isLeft ? const Radius.circular(18) : const Radius.circular(18),
      bottomRight:
          !isLeft ? const Radius.circular(18) : const Radius.circular(0));
}
