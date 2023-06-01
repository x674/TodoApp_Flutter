import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp_flutter/Model/note_model.dart';
import 'package:todoapp_flutter/Storage/file_storage.dart';

List<Note> listNotes = [Note("123","234")];
void main(){
  testWidgets("File save test",(widgetTester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final path = await getApplicationDocumentsDirectory();
    print(path);
  }, );

  // test(
  //     "File save test",
  //         () => () async {
  //       var jsonStr = json.encode(listNotes);
  //       await SaveJsonNotesToFile(jsonStr);
  //     });
}

Future<void> saveJson() async {
  //final path = await getApplicationDocumentsDirectory();
  // var jsonStr = json.encode(listNotes);
  // await SaveJsonNotesToFile(jsonStr);
}