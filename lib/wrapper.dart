import 'package:flutter/material.dart';
import 'package:just_note/models/the_user.dart';
import 'package:just_note/screens/authenticate/authenticate.dart';
import 'package:just_note/screens/home.dart';
import 'package:just_note/widgets/data_provider.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser?>(context);

    return user == null ? Authenticate() : DataProvider();
  }
}
