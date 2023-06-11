import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/screens/form_screen.dart';
import 'dart:io';

class Contacts extends StatefulWidget {
  final String contactName;
  final String birthdayDate;
  File? image = sharedFile;

  Contacts(this.contactName, this.birthdayDate, {Key? key})
      : super(key: key);

  int nivel = 0;
  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  File? image = sharedFile;
  /*bool assetOrNetwork() {
    if () {
      return false;
    }
    return true;
  }
*/
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue,
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[200],
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black12,
                      ),
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.file(image!),
                      ),
                    ),
                    SizedBox(
                        width: 200,
                        child: Text(
                          widget.contactName,
                          style: const TextStyle(
                            fontSize: 24,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    SizedBox(
                      height: 52,
                      width: 62,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.edit),
                              Text(
                                'Editar',
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: 0,
                      ),
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Dia aniversário: ${widget.nivel}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
