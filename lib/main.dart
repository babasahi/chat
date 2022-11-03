// ignore_for_file: avoid_print
import 'package:chat/data/providers.dart';
import 'package:chat/views/screens/import_file_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => ChatProvider(),
        builder: (context, child) => const ImportFilePage(),
      ),
    );
  }
}
