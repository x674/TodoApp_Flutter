import 'dart:io';

import 'package:flutter/material.dart';

String? _noteText;
class EditScreen extends StatefulWidget {

  EditScreen(String textNote){
    _noteText = textNote;
  }
  @override
  State<StatefulWidget> createState() {
    return _Layout();
  }
}

class _Layout extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(actions: [BackButton(onPressed: () => print("OUT MESSAGE"),)]),
      body: _EditBox(),
    ), onWillPop: () {
      Navigator.pop(context,_noteText);
      return Future.value(false);
    },);
  }
}

class _EditBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: "Заголовок заметки:"),
        ),
        Expanded(
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(initialValue: _noteText,
                      decoration: InputDecoration.collapsed(
                          hintText: "Текст заметки"),
                      scrollPadding: EdgeInsets.all(20.0),
                      maxLines: 99999,
                      keyboardType: TextInputType.multiline,))
              ],
            ))
      ],
    );
  }
}
