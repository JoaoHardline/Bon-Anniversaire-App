import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/components/contato.dart';

class ContactInherited extends InheritedWidget {
  ContactInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Contact> contactList = [];
  int? atualizador;
  void newContact(String name, String photo,int date){
    contactList.add(Contact(name, photo, date));
  }

  static ContactInherited of(BuildContext context) {
    final ContactInherited? result =
        context.dependOnInheritedWidgetOfExactType<ContactInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ContactInherited oldWidget) {
    return oldWidget.contactList.length != contactList.length;
  }
}
