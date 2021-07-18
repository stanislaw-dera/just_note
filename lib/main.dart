import 'package:flutter/material.dart';
import 'package:just_note/compatibility/compatibility_check.dart';
import 'package:just_note/screens/home.dart';

void main() {
  runApp(MyApp());
  doCompatibilityCheck();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inoNotes',
      home: NotesPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pinkAccent
      ),
    );
  }
}
