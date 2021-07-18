import 'package:flutter/material.dart';
import 'package:just_note/db/database.dart';
import 'package:just_note/models/note.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String noteContent = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New note'),
        actions: [
          TextButton(
              onPressed: () async => {
                    await NotesDatabase.instance
                        .create(Note(content: this.noteContent)),
                    Navigator.pop(context)
                  },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
          child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Start typing...',
          contentPadding: EdgeInsets.all(20.0),
        ),
        expands: true,
        minLines: null,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.left,
        onChanged: (val) => {setState(() => noteContent = val)},
      )),
    );
    ;
  }
}
