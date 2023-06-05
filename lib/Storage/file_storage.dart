import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../Model/note_model.dart';

Future<void> saveJsonNotesToFile(String jsonNotes) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}${Platform.pathSeparator}notes.json');
  await file.writeAsString(jsonNotes, mode: FileMode.writeOnly);
}

Future<List<Note>> readNotesFromFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}${Platform.pathSeparator}notes.json');
  var fileExist = await file.exists();
  List<Note> notes;
  if (fileExist) {
    final jsonNotes = await file.readAsString();
    var map = json.decode(jsonNotes);
    notes = (map as List).map((e) => Note.fromJson(e)).toList();
  } else {
    return [];
  }

  return notes;
}
