import 'package:flutter/material.dart';

import '../controller/note_controller.dart';
import 'add_note.dart';
import 'note.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  final controller = NoteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note List'),
      ),
      body: FutureBuilder(
        future: controller.getNotes(), // get note
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError) {
              return Text(snapshot.error.toString());
            }else if(snapshot.hasData) {
              final data = snapshot.data;
              // check data is empty or not
              if(data.isNotEmpty) {
                // show list view
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Note note = snapshot.data?[index];
                    return Card(
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.content),
                        trailing: IconButton(
                          onPressed: (){
                            // delete this note
                            final dialog = AlertDialog(
                              title: const Center(child: Text('Alert')),
                              content: const Text("Are you sure to delete this note"),
                              actions: [
                                TextButton(onPressed: (){
                                  // delete note
                                  Navigator.pop(context);
                                  setState(() {
                                    controller.deleteNote(index);
                                  });

                                }, child: const Text('YES', style: TextStyle(color: Colors.red),)),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: const Text('NO')),
                              ],
                            );
                            showDialog(context: context, builder: (context) => dialog);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red,),
                        ),
                      ),
                    );
                  },
                );
              }else {
                // show empty message
                return const Center(child: Text('Note is empty'));
              }
            }else {
              return const Scaffold();
            }
          }else {
            return const Scaffold();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddNote()),
          );
          // if new note is added successfully, then refresh view
          if(result == 'success') {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}