// import 'dart:async';
//
// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class NoteDatabase {
//   _init() async {
//     // Avoid errors caused by flutter upgrade.
//     // Importing 'package:flutter/widgets.dart' is required.
//     WidgetsFlutterBinding.ensureInitialized();
//     // Open the database and store the reference.
//     final database = openDatabase(
//       // Set the path to the database. Note: Using the `join` function from the
//       // `path` package is best practice to ensure the path is correctly
//       // constructed for each platform.
//       join(await getDatabasesPath(), 'notes_database.db'),
//       onCreate: (db, version) {
//         // Run the CREATE TABLE statement on the database.
//         return db.execute(
//           'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
//         );
//       },
//     );
//   }
//   Future<void> insertNote(Note note) async {
//     // Get a reference to the database.
//     final db = await database;
//
//     // Insert the Dog into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same dog is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'dogs',
//       Note.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//   // A method that retrieves all the dogs from the dogs table.
//   Future<List<Note>> notes() async {
//     // Get a reference to the database.
//     final db = await database;
//
//     // Query the table for all The Dogs.
//     final List<Map<String, dynamic>> maps = await db.query('notes');
//
//     // Convert the List<Map<String, dynamic> into a List<Dog>.
//     return List.generate(maps.length, (i) {
//       return Note(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         age: maps[i]['age'],
//       );
//     });
//   }
// }
