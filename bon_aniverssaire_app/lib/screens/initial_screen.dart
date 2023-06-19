import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/screens/form_screen.dart';
import 'package:bon_aniverssaire_app/data/contacts_inherited.dart';

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
      body: ListView(
        children: ContactsInherited.of(context).contactsList,
        padding: const EdgeInsets.only(bottom: 70, top: 8),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (NewContext) => FormScreen(contactsContext: context,),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget checkEmpty(){
    if(ContactsInherited.of(context).contactsList.isEmpty){
      return const Text('Adicione seu primeiro contato.');
    }else{
      return ListView(
        children: ContactsInherited.of(context).contactsList,
        padding: const EdgeInsets.only(bottom: 70, top: 8),
      );
    }
  }

}
