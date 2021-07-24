import 'package:just_note/models/note.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Note>> getSQLiteNotes() async {

  var db = await openDatabase('notes.db');
  final result = await db.query('notes');

  return result.map((json) => Note.fromJson(json)).toList();
}