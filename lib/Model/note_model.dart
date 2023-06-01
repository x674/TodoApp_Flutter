import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class Note{
  String titleNote = "";
  String textNote = "";

  Note.empty();
  Note(this.titleNote, this.textNote);

  factory Note.fromJson(Map<String,dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}

// @JsonSerializable()
// class NotesList{
//   List<Note> notesList = List.empty();
//
//   factory NotesList.fromJson(Map<String, dynamic> json) => _$NotesListFromJson(json);
//   Map<String, dynamic> toJson() => _$NotesListToJson(this);
// }