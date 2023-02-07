import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/detail_page.dart';
import 'package:flutter_notes_app/pages/form_page.dart';
import 'package:flutter_notes_app/utils/notes_database.dart';
import 'package:flutter_notes_app/widgets/card_widget.dart';
import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
        id: 1,
        title: 'Buku',
        description: 'Laskar Pelangi',
        time: DateTime.now()),
    Note(
        id: 1,
        title: 'Lari',
        description: 'Lari di lapangan',
        time: DateTime.now()),
    Note(
        id: 1,
        title: 'Gambar',
        description: 'Gambar abstrak',
        time: DateTime.now()),
    Note(
        id: 1,
        title: 'Shopping',
        description: 'Shoppping baju',
        time: DateTime.now()),
  ];

  bool isLoading = false;
  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Catatan'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return DetailPage(note: notes[index]);
                        }),
                      );
                      refreshNote();
                    },
                    child: CardWidget(
                      index: index,
                      note: notes[index],
                    ),
                  );
                },
                itemCount: notes.length,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const FormPage();
          }));
          refreshNote();
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
