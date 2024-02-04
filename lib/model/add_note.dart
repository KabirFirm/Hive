import 'package:flutter/material.dart';

import '../controller/note_controller.dart';
import 'note.dart';

class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final controller = NoteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Note'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final content = contentController.text;
                final note = Note(title: title, content: content);
                await controller.saveNote(note);
                titleController.clear();
                contentController.clear();
                // after note insert successfully, return success
                Navigator.pop(context, 'success');
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
