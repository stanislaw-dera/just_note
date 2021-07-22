import 'package:flutter/material.dart';
import 'package:just_note/models/the_user.dart';
import 'package:just_note/screens/home.dart';
import 'package:just_note/services/database.dart';
import 'package:provider/provider.dart';

class DataProvider extends StatelessWidget {
  const DataProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);

    return StreamProvider.value(
      value: DatabaseService(uid: user!.uid).userData,
        initialData: UserData(uid: '', notes: []),
        child: HomeScreen()
    );
  }
}
