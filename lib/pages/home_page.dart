import 'package:flutter/material.dart';
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
    Note(
        id: 1, title: 'Work', description: 'Develop App', time: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Catatan'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return CardWidget(
              index: index,
              note: notes[index],
            );
          },
          itemCount: notes.length,
        ),
      ),
    );
  }
}
