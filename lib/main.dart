import 'package:flutter/material.dart';

import 'Screens/editScreen.dart';

void main() {
  runApp(TodoApp());
}

List<String> NotesList = ["Заметка 1"];

class TodoApp extends StatefulWidget {
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
          title: Text("Список заметок"),
        ),
        // body: Column(children: NotesList),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return Note(NotesList[index]);
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: NotesList.length),
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
  NotesList.add("Заметка ${NotesList.length + 1}");
}

class Note extends StatefulWidget {
  String text = "";

  Note(String s) {
    text = s;
  }

  @override
  State<StatefulWidget> createState() {
    return NoteState(text);
  }

}
class NoteState extends State<StatefulWidget> {
  String text = "";
  NoteState(this.text);

  @override
  Widget build(BuildContext context) {
    Route _createRoute(String textNote) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            EditScreen(textNote),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
      );
    }
    return GestureDetector(
      child: Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.black12),
        child: Center(child: Text(text)),
      ),
      onTap: ()  async {
        String textF = await Navigator.of(context).push(_createRoute(text));
        setState(()  {
          text = textF;
        });
      },
    );
  }
}