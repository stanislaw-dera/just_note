import 'package:flutter/material.dart';
import 'package:just_note/compatibility/get_sqlite_notes.dart';
import 'package:just_note/models/note.dart';
import 'package:just_note/services/auth.dart';
import 'package:just_note/services/database.dart';

class MoreOptionsSheet extends StatelessWidget {

  final DatabaseService databaseService;

  MoreOptionsSheet({required this.databaseService});

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
                title: Text('Recover my notes'),
                leading: Icon(Icons.history),
                onTap: () async {

                  final List<Note> recoveredNotes = await getSQLiteNotes();

                  for(int i = 0; i < recoveredNotes.length; i++) {
                    await databaseService.addNote(title: '', content: recoveredNotes[i].content);
                  }

                  Navigator.of(context).pop();
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
                      applicationVersion: '3.2.0',
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
