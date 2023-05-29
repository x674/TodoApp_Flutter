import 'package:flutter/material.dart';

String _contentNote = "";
String _titleNote = "";

class EditScreen extends StatelessWidget {
  EditScreen(String textNote, {super.key}) {
    _contentNote = textNote;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: _EditBox(),
      ),
      onWillPop: () {
        Navigator.pop(context, _contentNote);
        return Future.value(false);
      },
    );
  }
}

class _EditBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            _titleNote = value;
          },
          decoration: const InputDecoration(labelText: "Заголовок заметки:"),
        ),
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: TextFormField(
              initialValue: _contentNote,
              onChanged: (value) {
                _contentNote = value;
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
