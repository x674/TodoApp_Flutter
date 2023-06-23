import 'package:flutter/material.dart';

import 'Screens/main_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),theme: ThemeData(useMaterial3: true),debugShowCheckedModeBanner: false,
    );
  }
}