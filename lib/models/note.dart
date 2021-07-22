class Note {
  final String title;
  final String content;

  const Note({required this.title, required this.content});
}

List<Note> notesFromDB(List notesFromDB) {

  List<Note> notes = [];

  for(int i = 0; i < notesFromDB.length; i++) {
    notes.add(Note(title: notesFromDB[i]['title'], content: notesFromDB[i]['content']));
  }

  return notes;
}