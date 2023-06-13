import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_flutter/Model/note_model.dart';

import '../Storage/file_storage.dart';
import 'edit_screen.dart';

List<Note> notesList = [];

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    //TODO Тормозит загрузка на секунду при запуске
    readNotesFromFile().then((value) {
      setState(() {
        notesList = value;
      });
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: NavigationDrawer(children: <Widget>[
        ListTile(
          leading: const Icon(Icons.notes),selected: true, selectedTileColor: Colors.cyan,
          title: const Text('Заметки'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Корзина'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Настройки'),
          onTap: () {},
        ),
      ]),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: SearchAnchor.bar(
                suggestionsBuilder: (context, controller) {
                  return List.empty();
                },
                barLeading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                ),
                barHintText: "Искать в заметках",
                barTrailing: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh),
                  )
                ],
              )),
          Expanded(
              child: notesList.isEmpty
                  ? const Center(child: Text('Нажми + чтобы добавить заметку!'))
                  : MasonryGridView.count(
                      crossAxisCount: 2,
                      itemCount: notesList.length,
                      itemBuilder: (context, index) => Dismissible(
                            key: GlobalKey(),
                            child: NoteWidget(notesList[index]),
                          ))),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () => onClickAddNewNote(),
          child: const Icon(Icons.create)),
    );
  }

  Future<void> onClickAddNewNote() async {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => EditScreen(),
    ))
        .then(
      (newNote) {
        if (newNote.textNote.isEmpty && newNote.titleNote.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Пустая заметка удалена"),
            duration: Duration(seconds: 2),
          ));
        } else {
          setState(() {
            notesList.add(newNote);
            saveJsonNotesToFile(json.encode(notesList));
          });
        }
      },
    );
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
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(widget.note.titleNote,
                  style: const TextStyle(
                      fontFamily: "Metropolis",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 0.1)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text(
                widget.note.textNote,
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2),
              ),
            )
          ],
        ),
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
