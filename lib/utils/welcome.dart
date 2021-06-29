// The dialog will be shown at the first app opening
import 'package:flutter/material.dart';

Future<void> showWelcomeDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Welcome to JustNote!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('JustNote! is an app that helps you creating simple notes. All content typed into the app is being saved automatically.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok', style: TextStyle(color: Colors.pink[400]),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}