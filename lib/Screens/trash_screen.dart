import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todoapp_flutter/Model/note_model.dart';
import 'package:todoapp_flutter/widgets/navigation_drawer.dart';
import 'package:todoapp_flutter/widgets/note_widget.dart';

import '../Storage/file_storage.dart';
import 'edit_screen.dart';
import 'main_screen.dart';

class TrashScreen extends StatelessWidget {
  TrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var visibleListNotes = notesList.where((element) => element.deleted).toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Корзина")),
      drawer: NavigationDrawerApp(), //navigationDrawer,
      body: SafeArea(
          child: MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: visibleListNotes.length,
              itemBuilder: (context, index) => Dismissible(onDismissed: (direction) {
                visibleListNotes[index].deleted = false;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Заметка восстановлена"),
                  duration: Duration(seconds: 2),
                ));
                saveJsonNotesToFile(json.encode(notesList));
              },
                  key: GlobalKey(),
                  child: NoteWidget(
                    visibleListNotes[index],
                    onPressed: () async {
                      Note returnedNote =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EditScreen(visibleListNotes[index]),
                      ));
                    },
                  )))),
    );
  }
}
