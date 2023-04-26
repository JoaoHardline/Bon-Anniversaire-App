import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/data/contacts_inherited.dart';
import 'package:bon_aniverssaire_app/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  ContactsInherited(child: const InitialScreen()),
    );
  }
}
