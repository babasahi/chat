import 'package:flutter/material.dart';

class ImportFilePage extends StatelessWidget {
  const ImportFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: const Text('Import Files'),
        ),
      )),
    );
  }
}
