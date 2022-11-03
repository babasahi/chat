import 'package:flutter/material.dart';

class ImportFilePage extends StatelessWidget {
  const ImportFilePage({super.key});
  Future<void> importFiles() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () async {
              importFiles();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: const Text('Import Files'),
            ),
          ),
        ),
      ),
    );
  }
}
