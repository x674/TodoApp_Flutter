import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../Model/note_model.dart';

Future<void> SaveJsonNotesToFile(String jsonNotes) async {
 final directory = await getApplicationDocumentsDirectory();

 final file = File('${directory.path}${Platform.pathSeparator}notes.json');

 await file.writeAsString(jsonNotes,mode: FileMode.writeOnly);
}

Future<List<Note>> ReadNotesFromFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}${Platform.pathSeparator}notes.json');
  final jsonNotes = await file.readAsString();
  var map = json.decode(jsonNotes);
  List<Note> notes = (map as List).map((e) => Note.fromJson(e)).toList();
  return notes;
}