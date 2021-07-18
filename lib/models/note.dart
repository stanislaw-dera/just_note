final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, content];

  static final String id = '_id';
  static final String content = 'content';
}

class Note {
  final int? id;
  final String content;

  const Note({this.id, required this.content});

  Note copy({
    int? id,
    String? content,
  }) =>
      Note(
        id: id ?? this.id,
        content: content ?? this.content,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        content: json[NoteFields.content] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.content: content,
      };
}
