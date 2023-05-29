import 'package:flutter/material.dart';

import 'Screens/editScreen.dart';

void main() {
  runApp(const TodoApp());
}

List<String> notesList = ["Заметка 1"];

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TodoAppState();
  }
}

class _TodoAppState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Список заметок"),
        ),
        // body: Column(children: NotesList),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return Note(notesList[index]);
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: notesList.length),
        // body: Center(child: Text('Нажми + чтобы добавить заметку!')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                addNoteToList();
              });
            },
            child: const Icon(Icons.add_circle)),
      ),
    );
  }
}

void addNoteToList() {
  notesList.add("Заметка ${notesList.length + 1}");
}

class Note extends StatefulWidget {
  String noteText;
  Note(this.noteText, {super.key});
  @override
  State<StatefulWidget> createState() => NoteState();
}

class NoteState extends State<Note> {
  

  @override
  Widget build(BuildContext context) {
    Route createRoute(String textNote) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            EditScreen(textNote),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
      );
    }
    void onTap() async {
        String returnedText = await Navigator.of(context).push(createRoute(widget.noteText));
        setState(()  {
          widget.noteText = returnedText;
        });
  }
    return GestureDetector(
      child: Container(
        height: 50,
        decoration: const BoxDecoration(color: Colors.black12),
        child: Center(child: Text(widget.noteText)),
      ),
      onTap: () => onTap()
      ,
    );
  }
}