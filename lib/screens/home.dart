import 'package:flutter/material.dart';
import 'package:just_note/db/database.dart';
import 'package:just_note/models/note.dart';
import 'package:just_note/screens/create.dart';
import 'package:just_note/widgets/no_notes_info.dart';
import 'package:just_note/widgets/note_tile.dart';
import 'package:just_note/widgets/show_about_dialog_button.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('inoNotes'),
        actions: [ShowAboutDialogBtn()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Create()),
          );

          refreshNotes();
        },
      ),
      body: Center(
        child: isLoading ? CircularProgressIndicator() : notes.isEmpty ? NoNotesInfo() : buildNotes(),
      ));

  Widget buildNotes() => Padding(
      padding: EdgeInsets.all((8)),
      child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteTile(
                content: notes[index].content,
                id: notes[index].id,
                refreshNotes: refreshNotes);
          }));
}
