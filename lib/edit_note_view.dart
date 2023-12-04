import 'package:flutter/material.dart';
import 'package:learning_sqflite/sqldb.dart';

class EditNoteView extends StatefulWidget {
  final String title;
  final String note;
  final int id;
  const EditNoteView(
      {super.key, required this.title, required this.note, required this.id});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
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
                initialValue: widget.title,
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                initialValue: widget.note,
                onChanged: (value) {
                  note = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    sqlDb.updatetData('''
                    UPDATE notes SET
                    note = "${note ?? widget.note}",
                    title = "${title ?? widget.title}"
                    WHERE id = "${widget.id}"
                    ''');
                    Navigator.of(context).pop();
                  },
                  child: Text("Edit"))
            ],
          ))
        ],
      ),
    );
  }
}
