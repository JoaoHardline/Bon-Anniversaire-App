import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/components/contacts.dart';



class ContactsInherited extends InheritedWidget {
  ContactsInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  List<Contacts> contactsList = [];


  void newContact(String name, String birthdayDate, String photo){
    contactsList.add(Contacts(name, birthdayDate));
  }


  static ContactsInherited of(BuildContext context) {
    final ContactsInherited? result =
    context.dependOnInheritedWidgetOfExactType<ContactsInherited>();
    assert(result != null, 'No ContactsInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ContactsInherited oldWidget) {
    return (oldWidget.contactsList.length != contactsList.length);
  }
}
