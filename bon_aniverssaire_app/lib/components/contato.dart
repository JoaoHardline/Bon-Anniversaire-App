import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/data/contact_dao.dart';

class Contact extends StatefulWidget {
  final String nome;
  final String foto;
  final int data;

  Contact(this.nome,
      this.foto,
      this.data, [
        Key? key,
      ]) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool PickedImage() {
    if (widget.foto.isNotEmpty) {
      return true;
    }
    return false;
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.indigo),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: PickedImage()
                            ? Image.file(File(widget.foto!))
                            : Container(
                            child: Icon(Icons.account_box_rounded, size: 48, )),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 62,
                      width: 62,
                      child: ElevatedButton(
                          onPressed: () {
                            //versao final dever abrir nova pagina com novos botoes de edição (deletar, update nome/data/foto)
                            },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.edit),
                              Text(
                                'Editar',
                                style: TextStyle(fontSize: 11),
                              )
                            ],
                          )),
                    ),
                    SizedBox(width: 1,)
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
                        value: (widget.data > 0)
                            ? 1 - (widget.data / 360)
                            : 1,
                      ),
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Faltam: ${widget.data} dias',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void removeContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Text('Deletar'),
              Icon(Icons.delete_forever),
            ],
          ),
          content: const Text('Tem certeza de que deseja deletar esse aniversariante?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
                child: const Text('Deletar'),
                onPressed: () {
                  ContactDao().delete(widget.nome);
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

}
