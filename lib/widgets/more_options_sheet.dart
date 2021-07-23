import 'package:flutter/material.dart';
import 'package:just_note/services/auth.dart';

class MoreOptionsSheet extends StatelessWidget {
  const MoreOptionsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                  title: Text('Logout'),
                leading: Icon(Icons.logout),
                onTap: () {
                    Navigator.of(context).pop();
                    AuthService auth = new AuthService();
                    auth.signOut();
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Delete my account'),
                leading: Icon(Icons.delete),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete account'),
                      content: Text('To delete the account, write on stanislaw.dera@outlook.com from the email address connected to this account.\n\nTopic: Account deletion\nContent: empty'),
                    );
                  });
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('About the app'),
                leading: Icon(Icons.info_outline),
                onTap: () {
                  Navigator.of(context).pop();
                  showAboutDialog(
                      context: context,
                      applicationName: 'inoNotes',
                      applicationVersion: '3.1.0',
                      applicationLegalese: '© 2021 Stanisław Dera',
                      applicationIcon: CircleAvatar(backgroundImage: AssetImage('assets/app_logo.png'),)
                  );
                },
              ),
            )
          ],
        ));
  }
}
