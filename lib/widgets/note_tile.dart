import 'package:flutter/material.dart';
import 'package:just_note/db/database.dart';

class NoteTile extends StatelessWidget {

  final String content;
  final int? id;
  final Function refreshNotes;

  NoteTile({required this.content, required this.id, required this.refreshNotes});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(content),
        onLongPress: () async {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Delete?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await NotesDatabase.instance.delete(
                          int.parse(id.toString()));
                      refreshNotes();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
