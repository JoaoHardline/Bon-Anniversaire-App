import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/components/contacts.dart';


class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Bon Anniversaire App'),
      ),
      body: AnimatedOpacity(
        opacity: opacity ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: ListView(
          children: const [
            Contacts('Novo Contato',
                'assets/images/newcontact.png'),
            Contacts('João Pedro',
                'assets/images/caco.webp'),
            Contacts('Laura Pires',
                'assets/images/bookopen.jpg'),
            Contacts('Fernando',
                'assets/images/meditation.jpeg'),
            Contacts('Luis',
                'assets/images/cacogame.jpg'),
            SizedBox(height: 80,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacity = !opacity;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}
