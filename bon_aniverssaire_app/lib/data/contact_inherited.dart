import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/components/contato.dart';

class ContactInherited extends InheritedWidget {
  ContactInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Contact> taskList = [];

  void newContact(String name, String photo,int date){
    taskList.add(Contact(name, photo, date));
  }

  static ContactInherited of(BuildContext context) {
    final ContactInherited? result =
        context.dependOnInheritedWidgetOfExactType<ContactInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ContactInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
