import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowAboutDialogBtn extends StatelessWidget {
  const ShowAboutDialogBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () =>
        {
          showAboutDialog(
              context: context,
              applicationName: 'inoNote',
              applicationVersion: '2.0.0',
              applicationLegalese: '© 2021 Stanisław Dera',
              applicationIcon: CircleAvatar(backgroundImage: AssetImage('assets/app_logo.png'),)
          ),
        },
        icon: Icon(Icons.more_vert));
  }
}
