import 'package:flutter/material.dart';
import 'package:notes_app/data/database/db_helper.dart';

class ViewNotes extends StatefulWidget {
  final int id;
  final String title;
  final String body;
  const ViewNotes({
    super.key,
    required this.title,
    required this.body,
    required this.id,
  });

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController =
        TextEditingController(text: widget.title);
    TextEditingController _bodyController =
        TextEditingController(text: widget.body);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseHelper.dbHelper.updateRecord({
            DatabaseHelper.notesId: widget.id,
            DatabaseHelper.notesTitle: _titleController.text,
            DatabaseHelper.notesBody: _bodyController.text,
          });
          Navigator.pop(context);
        },
        child: IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.done),
        ),
      ),
      appBar: AppBar(
        title: const Text("Update Notes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _bodyController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: "Body",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
