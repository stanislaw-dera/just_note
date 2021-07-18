import 'package:flutter/material.dart';

class NoNotesInfo extends StatelessWidget {
  const NoNotesInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'No notes :(',
      style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w300
      ),
    );
  }
}
