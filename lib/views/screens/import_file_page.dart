import 'package:chat/constants.dart';
import 'package:flutter/material.dart';

class ImportFilePage extends StatelessWidget {
  const ImportFilePage({super.key});
  Future<void> importFiles() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            elevation: 3,
            child: GestureDetector(
              onTap: () async {
                importFiles();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  'Import Files',
                  style: kMessageTextStyle.copyWith(fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
