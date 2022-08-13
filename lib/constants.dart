import 'package:flutter/material.dart';

const TextStyle kMessageTextStyle =
    TextStyle(fontSize: 16, fontFamily: 'Poppins');

const kTitleStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 26,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold);

const TextStyle kMessageDateStyle = TextStyle(
  fontSize: 10,
  fontFamily: 'Poppins',
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
