import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todoapp_flutter/Model/note_model.dart';

import '../Storage/file_storage.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/note_widget.dart';
import 'edit_screen.dart';

List<Note> notesList = [];
late final FocusNode _focusNode;
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    _focusNode = FocusNode();
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
    var visibleListNotes = notesList.where((element) => !element.deleted).toList();
    return Scaffold(
      key: scaffoldKey,
      drawer: NavigationDrawerApp(), //navigationDrawer,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: SearchAnchor.bar(
                suggestionsBuilder: (context, controller) {
                  var foundedNotes = visibleListNotes
                      .where((element) =>
                          element.titleNote
                              .toLowerCase()
                              .contains(controller.text) ||
                          element.textNote
                              .toLowerCase()
                              .contains(controller.text))
                      .toList();

                  return foundedNotes.map((e) => NoteWidget(e,onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => EditScreen(e),
                    ));
                  },)).toList();
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
              child: visibleListNotes.isEmpty
                  ? const Center(child: Text('Нажми + чтобы добавить заметку!'))
                  : MasonryGridView.count(
                      crossAxisCount: 2,
                      itemCount: visibleListNotes.length,
                      itemBuilder: (context, index) => Dismissible(
                            key: GlobalKey(),
                            child: NoteWidget(visibleListNotes[index],
                                onPressed: () =>
                                    onClickNote(visibleListNotes[index])),
                            onDismissed: (direction) {
                              setState(() {
                                visibleListNotes[index].deleted = true;
                              });
                              saveJsonNotesToFile(json.encode(notesList));
                            },
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

  onClickNote(Note note) async {
    Note returnedNote = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditScreen(note),
    ));
    setState(() {
      note.titleNote = returnedNote.titleNote;
      note.textNote = returnedNote.textNote;
    });
    await saveJsonNotesToFile(json.encode(notesList));
  }
}
