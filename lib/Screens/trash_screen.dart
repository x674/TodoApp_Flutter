import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todoapp_flutter/Model/note_model.dart';
import 'package:todoapp_flutter/widgets/navigation_drawer.dart';
import 'package:todoapp_flutter/widgets/note_widget.dart';

class TrashScreen extends StatelessWidget {
  TrashScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(),
//       AppBar(leading: IconButton(icon: Icon(Icons.menu),onPressed: () {
// //        //Navigator.pop(context);
//       },)),
      drawer: navigationDrawer,
      body: SafeArea(
          child: MasonryGridView.count(
            crossAxisCount: 3,itemCount: 30,
            itemBuilder: (context, index) => NoteWidget(Note.empty()),
          )),
    );
  }
}
