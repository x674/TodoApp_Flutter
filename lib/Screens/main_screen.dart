import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp_flutter/Model/note_model.dart';

import '../Storage/file_storage.dart';
import 'edit_screen.dart';

List<Note> notesList = [Note("Заголовок","Текст заметки")];

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    () async{ notesList = await ReadNotesFromFile();}.call();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Список заметок"),
      ),
      // body: Column(children: NotesList),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return NoteWidget(notesList[index]);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: notesList.length),
      // body: Center(child: Text('Нажми + чтобы добавить заметку!')),
      floatingActionButton: FloatingActionButton(
          onPressed: () => onClickAddNewNote(),
          child: const Icon(Icons.add_circle)),
    );
  }

  Future<void> onClickAddNewNote() async {var e = json.encode(notesList);
    var newNote = Note.empty();
    notesList.add(newNote);
    newNote = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen(newNote),));
    await SaveJsonNotesToFile(json.encode(notesList));
    setState(() {
      //notesList.last = returnedText;
    });
  }
}
class NoteWidget extends StatefulWidget {
  Note note;
  NoteWidget(this.note, {Key? key}) : super(key: key);

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        decoration: const BoxDecoration(color: Colors.black12),
        child: Center(child: Text(widget.note.textNote)),
      ),
      onTap: () => onTap()
      ,
    );
  }

  onTap() async {
    Note returnedNote = await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        EditScreen(widget.note),));
    setState(()  {
      widget.note.titleNote = returnedNote.titleNote;
      widget.note.textNote = returnedNote.textNote;
    });
  }
}