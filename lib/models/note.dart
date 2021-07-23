class Note {
  final String title;
  final String content;
  final String? image;

  const Note({this.title = '', this.content = '', this.image});
}

List<Note> notesFromDB(List notesFromDB) {

  List<Note> notes = [];

  for(int i = 0; i < notesFromDB.length; i++) {
    notes.add(Note(title: notesFromDB[i]['title'], content: notesFromDB[i]['content'], image: notesFromDB[i]['image']));
  }

  return notes;
}