import 'package:flutter/material.dart';
import 'package:learning_sqflite/sqldb.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  String? title;
  String? note;
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Title"),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Note details"),
                onChanged: (value) {
                  note = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    sqlDb.insertData('''
                    INSERT INTO 'notes' ('title','note') VALUES ('$title','$note')
''');
                  },
                  child: Text("Add"))
            ],
          ))
        ],
      ),
    );
  }
}
