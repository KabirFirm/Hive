import 'dart:convert';
import 'package:hive/hive.dart';
import '../model/note.dart';

class NoteController {

  // save note method
  Future<void> saveNote(Note note) async {
    final box = await Hive.openBox<String>('encryptedBox');

    final noteJson = jsonEncode(note.toJson());
    await box.put(DateTime.now().toString(), noteJson);
  }

  // get note method
  Future<List<Note>> getNotes() async {
    final box = await Hive.openBox<String>('encryptedBox');

    final notes = <Note>[];
    for (var key in box.keys) {
      final noteJson = box.get(key);
      if (noteJson != null) {
        final noteMap = jsonDecode(noteJson);
        notes.add(Note.fromJson(noteMap));
      }
    }

    return notes;
  }

  // delete note method
  Future<void> deleteNote(int index) async {
    final box = await Hive.openBox<String>('encryptedBox');
    await box.deleteAt(index);

    /*final data = box.getAt(index);
    Note userData;
    if(data != null) {
      final noteMap = jsonDecode(data);
    }
    userData = Note.fromJson(jsonDecode(data!));
    print('title - ${userData.title}');*/
  }
}