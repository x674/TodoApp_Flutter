import 'package:flutter/material.dart';
import 'package:todoapp_flutter/Screens/main_screen.dart';

import '../Screens/trash_screen.dart';

final navigationDrawer = NavigationDrawerApp();

class NavigationDrawerApp extends StatefulWidget {
  int screenIndex = 0;
  NavigationDrawerApp({super.key});

  @override
  State<NavigationDrawerApp> createState() => _NavigationDrawerAppState();
}

class _NavigationDrawerAppState extends State<NavigationDrawerApp> {

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
        selectedIndex: widget.screenIndex,
        onDestinationSelected: handleScreenChanged,
        children: const <Widget>[
          NavigationDrawerDestination(
            icon: Icon(Icons.notes),
            label: Text('Заметки'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.delete),
            label: Text('Корзина'),
          ),
          NavigationDrawerDestination(icon: Icon(Icons.settings), label: Text('Настройки')),
        ]);
  }
  handleScreenChanged(int index) {

    if(widget.screenIndex != index) {
      switch (index) {
        case 0:
          Navigator.pop(context);
        case 1:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TrashScreen(),));
        case 2:
          Navigator.push(context,MaterialPageRoute(builder: (context) => Scaffold(drawer: navigationDrawer,appBar: AppBar(),body: Center(child: Text("Settings screen"),)),));
      }
      setState(() {
        widget.screenIndex = index;
      });
    }
  }
}