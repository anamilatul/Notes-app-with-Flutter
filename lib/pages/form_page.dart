// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_notes_app/utils/notes_database.dart';

import '../models/note.dart';

class FormPage extends StatefulWidget {
  final Note? note;
  const FormPage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController titleControler = TextEditingController();
  TextEditingController descControler = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleControler.text = widget.note!.title;
      descControler.text = widget.note!.description;
    }
    super.initState();
  }

  Future addNote() async {
    final note = Note(
      title: titleControler.text,
      description: descControler.text,
      time: DateTime.now(),
    );
    await NotesDatabase.instance.create(note);
    Navigator.of(context).pop();
  }

  Future updateNote() async {
    final note = widget.note!.copyWith(
      title: titleControler.text,
      description: descControler.text,
    );
    await NotesDatabase.instance.update(note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        actions: [
          InkWell(
            onTap: () {
              if (widget.note != null) {
                updateNote();
              } else {
                addNote();
              }
            },
            child: const Icon(Icons.save),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView(children: [
          TextFormField(
            controller: titleControler,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Title',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: descControler,
            maxLines: 16,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Catatan . . .',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
