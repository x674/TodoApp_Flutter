import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp_flutter/Model/note_model.dart';

import '../Storage/file_storage.dart';
import 'edit_screen.dart';

List<Note> notesList = [Note("Заголовок", "Текст заметки")];

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    readNotesFromFile().then((value) {
      setState(() {
        notesList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SearchBar(),
          // SearchAnchor.bar(
          //   suggestionsBuilder: (context, controller) {
          //
          //     return List.empty();
          //   },
          // ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: notesList.length,
              itemBuilder: (context, index) => NoteWidget(notesList[index]),
            ),
          ),
        ],
      )),
      // body: Center(child: Text('Нажми + чтобы добавить заметку!')),
      floatingActionButton: FloatingActionButton(
          onPressed: () => onClickAddNewNote(),
          child: const Icon(Icons.create)),
    );
  }

  Future<void> onClickAddNewNote() async {
    var newNote = Note.empty();
    notesList.add(newNote);
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => EditScreen(newNote),
    ))
        .then(
      (value) {
        setState(() {
          newNote = value;
        });
      },
    );
    await saveJsonNotesToFile(json.encode(notesList));
  }
}

class NoteWidget extends StatefulWidget {
  final Note note;

  const NoteWidget(this.note, {Key? key}) : super(key: key);

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.note.titleNote,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.note.textNote)
          ],
        ),color: Colors.white,borderOnForeground: false,shadowColor: Colors.yellow,surfaceTintColor: Colors.indigoAccent,
      ),
      onTap: () => onClickEditNote(),
    );
  }

  onClickEditNote() async {
    Note returnedNote = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditScreen(widget.note),
    ));
    setState(() {
      widget.note.titleNote = returnedNote.titleNote;
      widget.note.textNote = returnedNote.textNote;
    });
    await saveJsonNotesToFile(json.encode(notesList));
  }
}
