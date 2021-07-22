import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_note/models/the_user.dart';
import 'package:just_note/services/auth.dart';
import 'package:just_note/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'inoNotes',
        home: Wrapper(),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.pinkAccent
        ),
      ),
    );
  }
}
