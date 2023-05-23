import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Layout();
  }
}

class _Layout extends State<Scaffold>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
class _EditBox extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
     children: [TextFormField()],
    );
  }
}