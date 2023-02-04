import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/home_page.dart';
import 'package:flutter_notes_app/utils/user_shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController nameController;
  late TextEditingController pinController;
  bool isPinExist = false;
  String? _pin;

  @override
  void initState() {
    nameController = TextEditingController();
    pinController = TextEditingController();
    String? pin = UserSharedPreferences.getPin();
    if (pin != null) {
      setState(() {
        isPinExist = true;
        _pin = pin;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 248, 209, 118),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Buku Catatan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Nama',
              style: TextStyle(
                fontSize: 20,
                // color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: TextField(
                autofocus: true,
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const Text(
              'PIN',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: TextField(
                // autofocus: true,
                controller: pinController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                await UserSharedPreferences.setName(
                  name: nameController.text,
                  pin: pinController.text,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
