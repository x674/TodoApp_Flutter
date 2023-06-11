import 'package:flutter/material.dart';

import '../Model/note_model.dart';
import '../styles/text_styles.dart';

class EditScreen extends StatelessWidget {
  Note note = Note.empty();

//TODO back {super.key}
  EditScreen([Note? note]) {
    if (note != null) {
      this.note = note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: EditBox(note),
      ),
      onWillPop: () {
        Navigator.pop(context, note);
        return Future.value(false);
      },
    );
  }
}

class EditBox extends StatelessWidget {
  final Note note;

  const EditBox(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 33, 17, 0),
      child: ListView(
        children: [
          TextFormField(
            initialValue: note.titleNote,
            onChanged: (value) {
              note.titleNote = value;
            },
            style: const TextStyle(fontSize: 24, fontFamily: font_family),
            decoration: const InputDecoration.collapsed(
                hintText: "Заголовок",
                hintStyle: TextStyle(fontSize: 24, fontFamily: font_family)),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            initialValue: note.textNote,
            style: const TextStyle(fontSize: 16, fontFamily: font_family),
            onChanged: (value) {
              note.textNote = value;
            },
            decoration: const InputDecoration.collapsed(
                hintText: "Заметка",
                hintStyle: TextStyle(fontSize: 16, fontFamily: font_family)),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          )
        ],
      ),
    );
  }
}
