import 'package:flutter/material.dart';
import 'package:just_note/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final Function delete;

  NoteTile({required this.note, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
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
                            delete();
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ));
          },


          child: note.image != null
              ? Image.network(
                  note.image.toString(),
                  fit: BoxFit.fill,
                )
              : ListTile(
                  title:
                      note.title == '' ? Text(note.content) : Text(note.title),
                  subtitle: note.title == ''
                      ? null
                      : note.content == ''
                          ? null
                          : Text(note
                              .content), // if note's title is empty, return content as title
                ),
        ));
  }
}
