// Migrate from 1.0.0 to 2.0.0
// SharedPreferences => SQLite

import 'package:just_note/db/database.dart';
import 'package:just_note/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

void doCompatibilityCheck() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.get('note') != null) {
    // start migration
    Note newNote = Note(content: prefs.get('note').toString());
    await NotesDatabase.instance.create(newNote);
    await prefs.remove('note');
  }
}