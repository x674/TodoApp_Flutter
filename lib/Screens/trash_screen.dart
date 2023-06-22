import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todoapp_flutter/Model/note_model.dart';
import 'package:todoapp_flutter/widgets/navigation_drawer.dart';
import 'package:todoapp_flutter/widgets/note_widget.dart';

import 'main_screen.dart';

class TrashScreen extends StatelessWidget {
  TrashScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Корзина")),
      drawer: NavigationDrawerApp(),//navigationDrawer,
      body: SafeArea(
          child: MasonryGridView.count(
            crossAxisCount: 2,itemCount: notesList.where((e) => e.deleted).length,
            itemBuilder: (context, index) => NoteWidget(notesList.where((e) => e.deleted).toList()[index])// NoteWidget(Note.empty()),
          )),
    );
  }
}
