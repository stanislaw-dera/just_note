import 'package:flutter/material.dart';
import 'package:just_note/services/database.dart';

class CreateScreen extends StatefulWidget {

  final DatabaseService databaseService;

  const CreateScreen({required this.databaseService});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String noteTitle = '';
  String noteContent = '';

  @override
  void dispose() {
    saveNote();
    super.dispose();
  }

  void saveNote() {
    if(noteTitle.length != 0 || noteContent.length != 0) widget.databaseService.addNote(noteTitle, noteContent);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('New note'),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
                onChanged: (val) {
                  setState(() => noteTitle = val);
                },
              ),
              TextFormField(
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                maxLines: 10,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type something...',
                ),
                onChanged: (val) {
                  setState(() => noteContent = val);
                },
              )
            ],
          ),
        ));
  }
}