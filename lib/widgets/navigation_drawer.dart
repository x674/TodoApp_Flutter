import 'package:flutter/material.dart';

import '../Screens/trash_screen.dart';

class NavigationDrawerApp extends StatelessWidget {
  const NavigationDrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(children: <Widget>[
      ListTile(
        leading: const Icon(Icons.notes),
        selected: true,
        selectedTileColor: Colors.cyan,
        title: const Text('Заметки'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.delete),
        title: const Text('Корзина'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrashScreen(),
              ));
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Настройки'),
        onTap: () {},
      ),
    ]);
  }
}
