import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/components/contacts.dart';

class ContactsInherited extends InheritedWidget {
  ContactsInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Contacts> contactsList = [
    Contacts('João Pedro', '0', 'assets/image/caco.webp'),
    Contacts('Laura Pires', '0', 'assets/image/bookopen.jpg'),
    Contacts('Fernando', '0', 'assets/image/meditation.jpeg'),
    Contacts('Luis', '0', 'assets/image/cacogame.jpg'),
  ];


  void newContact(String name, String birthdayDate, String photo){
    contactsList.add(Contacts(name, birthdayDate, photo));
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
