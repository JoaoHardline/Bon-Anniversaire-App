import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/components/difficulty.dart';
import 'package:bon_aniverssaire_app/data/contact_dao.dart';

class Contact extends StatefulWidget {
  final String nome;
  final String foto;
  final int data;
  int dias;

  Contact(this.nome,
      this.foto,
      this.data, [
        this.dias = 0,
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
                borderRadius: BorderRadius.circular(4), color: Colors.blue),
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
                            ? Image.asset(
                          widget.foto,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          widget.foto,
                          fit: BoxFit.cover,
                        ),
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
                        Difficulty(
                          dificultyLevel: widget.data,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onLongPress: () {
                            removeContact(context);
                          },
                          onPressed: () {
                            //versao final dever abrir nova pagina com novos botoes de edição (deletar, update nome/data/foto)
                            print(widget.dias);
                            setState(() {
                              widget.dias++;
                            });
                            // print(nivel);
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
                    )
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
                            ? (widget.dias / widget.data) / 10
                            : 1,
                      ),
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Faltam: ${widget.dias} dias',
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
