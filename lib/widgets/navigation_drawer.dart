import 'package:flutter/material.dart';
import 'package:todoapp_flutter/Screens/main_screen.dart';

import '../Screens/trash_screen.dart';

//final navigationDrawer = NavigationDrawerApp();
int screenIndex = 0;
class NavigationDrawerApp extends StatefulWidget {

  NavigationDrawerApp({super.key});

  @override
  State<NavigationDrawerApp> createState() => _NavigationDrawerAppState();
}

class _NavigationDrawerAppState extends State<NavigationDrawerApp> {

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
        selectedIndex: screenIndex,
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

    if(screenIndex != index) {
      switch (index) {
        case 0:
          //Navigator.pop(context);
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const MainScreen(),));
        case 1:
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TrashScreen(),));
        case 2:
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Scaffold(drawer: NavigationDrawerApp(),appBar: AppBar(),body: Center(child: Text("Settings screen"),)),));
      }
      setState(() {
        screenIndex = index;
      });
    }
  }
}