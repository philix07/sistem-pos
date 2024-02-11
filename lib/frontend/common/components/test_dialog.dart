import 'package:flutter/material.dart';

class TestDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Container(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        color: Colors.white,
        child: const Text('Dialog Showed'),
      ),
    );
  }
}
