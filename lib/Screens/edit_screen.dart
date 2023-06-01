import 'package:flutter/material.dart';

import '../Model/note_model.dart';

class EditScreen extends StatelessWidget {
  Note note;

  EditScreen(this.note, {super.key});

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
  Note note;

  EditBox(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: note.titleNote,
          onChanged: (value) {
            note.titleNote = value;
          },
          decoration: const InputDecoration(labelText: "Заголовок заметки:"),
        ),
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: TextFormField(
              initialValue: note.textNote,
              onChanged: (value) {
                note.textNote = value;
              },
              decoration:
                  const InputDecoration.collapsed(hintText: "Текст заметки"),
              scrollPadding: const EdgeInsets.all(20.0),
              maxLines: 99999,
              keyboardType: TextInputType.multiline,
            ))
          ],
        ))
      ],
    );
  }
}
