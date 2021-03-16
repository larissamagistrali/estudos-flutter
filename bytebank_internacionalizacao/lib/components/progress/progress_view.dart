import 'package:bytebank/components/progress/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ProgressView extends StatelessWidget {
  String message;

  ProgressView({String message = "Sending..."}) {
    this.message = message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Processing'),
      ),
      body: Progress(
        message: message,
      ),
    );
  }
}
