import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/controller/note_controller.dart';
import 'package:hive_demo/add_note.dart';
import 'package:hive_demo/note_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //await Hive.openBox<Note>('encryptedBox');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  final controller = NoteController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteList()
    );
  }
}


